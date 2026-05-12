page 50393 EmployerReceivables
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;

    SourceTableView = sorting("No.")
                      order(ascending)
                      where("Customer Type" = filter(Checkoff));



    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    Caption = 'Balance';
                    ApplicationArea = all;
                }
                field("Receivables Amount"; Rec."Receivables Amount") { ApplicationArea = all; }
                field("Credit Amount"; Rec."Credit Amount") { ApplicationArea = all; }
                field("Net Change"; Rec."Net Change") { ApplicationArea = all; }
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
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
}