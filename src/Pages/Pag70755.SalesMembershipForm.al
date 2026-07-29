page 70755 "Sales Form Fee"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Loan Form";

    layout
    {
        area(Content)
        {
            repeater(SalesFormFee)

            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;

                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;

                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;

                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;

                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Used; Rec.Used)
                {
                    ApplicationArea = Basic;
                }
                field("Member Application No."; Rec."Member Application No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}