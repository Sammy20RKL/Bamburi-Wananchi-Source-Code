page 70742 "Loan Updates Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Loan Update";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;
                }
                field("Client No"; Rec."Client No")
                {
                    ApplicationArea = All;
                    Caption = 'Member No';
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = All;
                    Caption = 'Member Name';
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = All;
                }
                field("Amount Applied"; Rec."Amount Applied")
                {
                    ApplicationArea = All;
                    Caption = 'Amount Applied';
                }
                field("Amount Approved"; Rec."Amount Approved")
                {
                    ApplicationArea = All;
                    Caption = 'Amount Approved';
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Date';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = All;
                    Caption = 'Outstanding Balance';
                }
            }
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

    var
        myInt: Integer;
}