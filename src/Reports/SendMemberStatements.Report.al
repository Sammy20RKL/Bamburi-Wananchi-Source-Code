report 51122 "Send Member Statements"
{

    Caption = 'Send Member Statements';
    ProcessingOnly = true;
    UsageCategory = None;

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(MemberNoField; MemberNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Member No.';
                        TableRelation = Customer."No.";
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var
        Mailer: Codeunit "Member Statement Mailer";
    begin
        if MemberNo <> '' then
            Mailer.SendStatementToMember(MemberNo)
        else
            Mailer.SendStatementsToAllMembers();
    end;

    var
        MemberNo: Code[20];
}
