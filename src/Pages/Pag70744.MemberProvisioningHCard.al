page 70744 "Member Provisioning H Card"
{
    PageType = Card;
    Caption = 'Member Provisioning Card';
    SourceTable = "Member Provisioning Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Transaction No"; Rec."Transaction No")
                {

                }
                field("Description"; Rec."Description")
                {

                }
                field("Period"; Rec."Period")
                {

                }
                field("Start Date"; Rec."Start Date")
                {

                }
                field("End Date"; Rec."End Date")
                {

                }
                field("Branch Code"; Rec."Branch Code")
                {

                }
                field("No Series"; Rec."No Series")
                {

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
