Codeunit 50802 Emailcodeunit
{
    local procedure SaveReportAsPDF(ReportID: Integer; RecordVariant: Variant; LayoutCode: code[30])
    var
        myInt: Integer;
    begin
        //saves as pdf
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeGetEmailSubject', '', false, false)]
    local procedure SDHCustomEmailsubject(var EmailSubject: Text[250]; PostedDocNo: Code[20]; ReportUsage: Integer; var IsHandled: Boolean)
    Var
        ReportUsageEnum: Enum "Report Selection Usage";
    begin
        ReportUsageEnum := "Report Selection Usage".FromInteger(ReportUsage);
        if ReportUsageEnum <> ReportUsageEnum::"S.Order" then
            exit;
        EmailSubject := 'Polytech Subject ' + PostedDocNo;
        IsHandled := true;
    end;

    //From
    //To
    //Subject
    //Body
    local procedure Simpleemail(var ReceiverEmail: Text[100]; var Subject: Text[100]; Var EmailBody: text[300])
    var
        TempEmailItem: Record "Email Item" temporary;
    begin
        TempEmailItem."Send to" := ReceiverEmail;
        TempEmailItem.Subject := Subject;
        TempEmailItem.SetBodyText(EmailBody);
        TempEmailItem.SendAsHTML(true);
    end;

    procedure SendMail(EmailAddress: Text[60]; EmailSubject: text[100]; EmailBody: Text[2000])
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;

    begin
        EmailMessage.Create(EmailAddress, EmailSubject, EmailBody, true);
        Email.Send(EmailMessage);

    end;


    var
        myInt: Integer;
}