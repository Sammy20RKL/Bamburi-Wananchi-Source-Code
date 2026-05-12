#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 56023 "Guarantorship Sub List"
{
    CardPageID = "Guarantor Sub Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Guarantorship Substitution H";
    SourceTableView = where(Substituted = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loanee Member No"; Rec."Loanee Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Loanee Name"; Rec."Loanee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Guaranteed"; Rec."Loan Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Substituting Member"; Rec."Substituting Member")
                {
                    ApplicationArea = Basic;
                }
                field("Substituting Member Name"; Rec."Substituting Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Substituted By"; Rec."Substituted By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Substituted"; Rec."Date Substituted")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

