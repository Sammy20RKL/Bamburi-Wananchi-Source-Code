page 52041 "Leave Types Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Leave Type";
    Caption = 'Leave Types Setup';
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Accrue Days"; Rec."Earn Days")
                {
                    ToolTip = 'Specifies the value of the Accrue Days field.';
                }
                field("Unlimited Days"; Rec."Unlimited Days")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Unlimited Days field';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field';
                }
                field("Max Carry Forward Days"; Rec."Max Carry Forward Days")
                {
                    ToolTip = 'Specifies the value of the Max Carry Forward Days field';
                }
                field("Annual Leave"; Rec."Annual Leave")
                {
                    ToolTip = 'Specifies the value of the Annual Leave field';
                }
                field("Inclusive of Holidays"; Rec."Inclusive of Holidays")
                {
                    ToolTip = 'Specifies the value of the Inclusive of Holidays field';
                }
                field("Inclusive of Saturday"; Rec."Inclusive of Saturday")
                {
                    ToolTip = 'Specifies the value of the Inclusive of Saturday field';
                }
                field("Inclusive of Sunday"; Rec."Inclusive of Sunday")
                {
                    ToolTip = 'Specifies the value of the Inclusive of Sunday field';
                }
                field("Off/Holidays Days Leave"; Rec."Off/Holidays Days Leave")
                {
                    ToolTip = 'Specifies the value of the Off/Holidays Days Leave field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(LeaveEntitlement)
            {
                Caption = 'Leave Entitlement Allocation';
                Image = Allocate;
                RunObject = Page "Leave Entitlement Entries";
                RunPageLink = "Leave Type Code" = field(Code);
            }
        }

        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(LeaveEntitlement_Promoted; LeaveEntitlement)
                {
                }
            }
        }
    }
}





