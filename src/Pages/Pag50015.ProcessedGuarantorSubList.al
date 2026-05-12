#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50015 "Processed Guarantor Sub List"
{
    CardPageID = "Processed Guarantor Sub Card";
    Editable = false;
    PageType = List;
    SourceTable = 51563;
    SourceTableView = where(Status = filter(Approved));

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
        area(creation)
        {
            action("Member is  Guaranteed")
            {
                ApplicationArea = Basic;
                Caption = 'Member is  Guaranteed';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    cust.Reset;
                    cust.SetRange(cust."No.", Rec."Loanee Member No");
                    if cust.Find('-') then
                        Report.Run(51516504, true, false, cust);
                end;
            }
        }
    }

    var
        cust: Record 51364;
}

