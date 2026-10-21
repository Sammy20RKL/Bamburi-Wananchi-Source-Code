codeunit 51121 "Member Statement Mailer"
{
    // Emails the full Member Detailed Statement (report 50223) to members as a password-protected PDF.
    // Password = "MNO." + member number.
    // Job Queue: leave Parameter String empty to send to every active member,
    // or put a member number in it to send to that member only (for testing).
    // The "Send Member Statements" report (51122) calls the two public procedures below.
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        MemberNo: Code[20];
    begin
        MemberNo := CopyStr(DelChr(Rec."Parameter String", '<>', ' '), 1, MaxStrLen(MemberNo));
        if MemberNo <> '' then
            SendStatementToMember(MemberNo)
        else
            SendStatementsToAllMembers();
    end;

    procedure SendStatementToMember(MemberNo: Code[20]) res: Boolean
    var
        Member: Record Customer;
        MemberEmail: Text;
    begin
        if not Member.Get(MemberNo) then
            Error('Member %1 not found', MemberNo);

        MemberEmail := GetMemberEmail(Member);
        if not IsValidEmail(MemberEmail) then
            Error('Member %1 does not have a valid email address', MemberNo);

        if not QueueStatement(Member, MemberEmail) then
            Error('The statement for member %1 could not be generated', MemberNo);

        if GuiAllowed then
            Message('The statement for member %1 has been sent to %2.', MemberNo, MemberEmail);
        res := true;
    end;

    procedure SendStatementsToAllMembers() res: Boolean
    var
        Member: Record Customer;
        MemberEmail: Text;
        QueuedCount: Integer;
    begin
        Member.Reset();
        Member.SetRange(Status, Member.Status::Active);
        if Member.FindSet() then
            repeat
                MemberEmail := GetMemberEmail(Member);
                if IsValidEmail(MemberEmail) then
                    if QueueStatement(Member, MemberEmail) then
                        QueuedCount += 1;
            until Member.Next() = 0;

        if GuiAllowed then
            Message('Statements have been sent to %1 members.', QueuedCount);
        res := true;
    end;

    local procedure QueueStatement(Member: Record Customer; MemberEmail: Text): Boolean
    var
        StatementMember: Record Customer;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        ProtectedBlob: Codeunit "Temp Blob";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        OutStr: OutStream;
        InStr: InStream;
    begin
        StatementMember.SetRange("No.", Member."No.");
        RecRef.GetTable(StatementMember);

        TempBlob.CreateOutStream(OutStr);
        if not Report.SaveAs(Report::"Member Detailed Statement", '', ReportFormat::Pdf, OutStr, RecRef) then
            exit(false);

        // Password = MNO. + member number. Never send an unprotected statement.
        ProtectPdf(TempBlob, ProtectedBlob, GetPdfPassword(Member."No."));
        ProtectedBlob.CreateInStream(InStr);

        EmailMessage.Create(
            MemberEmail,
            StrSubstNo('Member Statement as at %1', FormatDate(Today)),
            BuildEmailBody(Member),
            true);
        EmailMessage.AddAttachment(StrSubstNo('Statement_%1.pdf', MaskMemberNo(Member."No.")), 'application/pdf', InStr);
        // EmailMessage.AddAttachment(StrSubstNo('Statement_%1.pdf', Member."No."), 'application/pdf', InStr);

        Email.Enqueue(EmailMessage);
        exit(true);
    end;

    local procedure MaskMemberNo(MemberNo: Text): Text
    begin
        // '*' is not allowed in file names, so 'X' is used instead.
        // Example: BWS12345 -> BWSXXX5
        if StrLen(MemberNo) <= 4 then
            exit(CopyStr(MemberNo, 1, 1) + 'XXX');
        exit(CopyStr(MemberNo, 1, 3) + 'XXX' + CopyStr(MemberNo, StrLen(MemberNo), 1));
    end;

    local procedure GetPdfPassword(MemberNo: Code[20]): Text
    begin
        // If the member number already starts with "MNO." do not add the prefix twice.
        if UpperCase(CopyStr(MemberNo, 1, 4)) = 'MNO.' then
            exit(MemberNo);
        exit('MNO.' + MemberNo);
    end;

    local procedure ProtectPdf(var Source: Codeunit "Temp Blob"; var Target: Codeunit "Temp Blob"; Password: Text)
    var
        Base64Convert: Codeunit "Base64 Convert";
        PdfReader: DotNet PdfReader;
        PdfDoc: DotNet PdfDocument;
        Security: DotNet PdfSecuritySettings;
        NetConvert: DotNet Convert;
        NetFile: DotNet File;
        NetPath: DotNet Path;
        InStr: InStream;
        OutStr: OutStream;
        PdfBase64: Text;
        InPath: Text;
        OutPath: Text;
    begin
        // PdfSharp is only given plain string paths (no Stream/enum arguments), because AL's
        // DotNet binding rejects those overloads. The PDF goes through two temp files on the
        // service tier. The member opens the PDF with the password passed in (user password).
        // The owner password is random, so the file cannot be edited.
        Source.CreateInStream(InStr);
        PdfBase64 := Base64Convert.ToBase64(InStr);

        InPath := NetPath.GetTempFileName();
        OutPath := NetPath.GetTempFileName();
        NetFile.WriteAllBytes(InPath, NetConvert.FromBase64String(PdfBase64));

        PdfDoc := PdfReader.Open(InPath);
        Security := PdfDoc.SecuritySettings;
        Security.UserPassword := Password;
        Security.OwnerPassword := DelChr(Format(CreateGuid()), '=', '{}-');
        PdfDoc.Save(OutPath);
        PdfDoc.Close();

        Target.CreateOutStream(OutStr);
        Base64Convert.FromBase64(NetConvert.ToBase64String(NetFile.ReadAllBytes(OutPath)), OutStr);

        NetFile.Delete(InPath);
        NetFile.Delete(OutPath);
    end;

    local procedure BuildEmailBody(Member: Record Customer): Text
    var
        Body: TextBuilder;
    begin
        Body.Append('<div style="font-family:Arial,Helvetica,sans-serif;font-size:14px;color:#222;max-width:650px;">');

        // Sea-green banner (table + bgcolor so Outlook also shows the colour)
        Body.Append('<table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#2E8B57" ' +
                    'style="background-color:#2E8B57;margin:0 0 16px 0;"><tr>' +
                    '<td style="padding:14px 16px;background-color:#2E8B57;">' +
                    '<h3 style="margin:0;color:#FFFFFF;font-size:16px;font-family:Arial,Helvetica,sans-serif;">' +
                    'BAMBURI WANANCHI SACCO MEMBER STATEMENT</h3>' +
                    '</td></tr></table>');

        Body.Append(StrSubstNo('<p>Dear %1,</p>', Member.Name));
        Body.Append(StrSubstNo('<p>Kindly find attached your account statement as at <b>%1</b>.</p>', FormatDate(Today)));
        Body.Append('<p>Please note that the statement is password protected. When prompted, enter <b>MNO.</b> ' +
             'followed by your <b>Membership Number</b> as the password. ' +
             'If you do not know your Membership Number, kindly dial <b>*250#</b> ' +
             'and check member information.</p>');
        Body.Append('<p>We remain committed to supporting your financial growth through reliable savings solutions, ' +
                    'affordable credit facilities and excellent member service.</p>');
        Body.Append('<p>Should you have any questions regarding your statement or require any assistance, ' +
                    'please contact us through:<br>');
        Body.Append('Email: <a href="mailto:wananchi.sacco@bamburigroup.com">wananchi.sacco@bamburigroup.com</a><br>');
        Body.Append('Phone: 0701309651</p>');
        Body.Append('<p>Thank you for your continued trust and membership.</p>');
        Body.Append('<p>Kind Regards,<br><b>Bamburi Wananchi Sacco - Cementing Your Future</b></p>');
        Body.Append('<p><i>58 Years Empowering Members</i></p>');

        Body.Append('<hr style="border:none;border-top:1px solid #ccc;">');
        Body.Append('<p style="font-size:11px;color:#777;">Disclaimer: This email and any attachments contain confidential ' +
                    'information intended only for the named recipient. If you have received this email in error, ' +
                    'please notify Bamburi Wananchi Sacco and delete it immediately. Unauthorized use, disclosure ' +
                    'or distribution is prohibited.</p>');
        Body.Append('</div>');

        exit(Body.ToText());
    end;

    local procedure GetMemberEmail(Member: Record Customer): Text
    var
        MemberEmail: Text;
    begin
        MemberEmail := DelChr(Member."E-Mail", '<>', ' ');
        if MemberEmail = '' then
            MemberEmail := DelChr(Member."E-Mail (Personal)", '<>', ' ');
        exit(MemberEmail);
    end;

    local procedure IsValidEmail(EmailAddress: Text): Boolean
    begin
        if EmailAddress = '' then
            exit(false);
        exit(TryCheckEmail(EmailAddress));
    end;

    [TryFunction]
    local procedure TryCheckEmail(EmailAddress: Text)
    var
        MailManagement: Codeunit "Mail Management";
    begin
        MailManagement.CheckValidEmailAddress(EmailAddress);
    end;

    local procedure FormatDate(Value: Date): Text
    begin
        exit(Format(Value, 0, '<Day,2> <Month Text> <Year4>'));
    end;
}