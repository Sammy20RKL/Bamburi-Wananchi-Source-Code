page 52021 "Leave Planner Card"
{
    ApplicationArea = All;
    Caption = 'Leave Planner Card';
    PageType = Card;
    SourceTable = "Leave Planner Header";
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec.Status = Rec.Status::Created;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ToolTip = 'Specifies the value of the Leave Period field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
            }
            part(LeavePlannerLines; "Leave Planner Lines")
            {
                Caption = 'Leave Planner Lines';
                SubPageLink = "Document No." = field("No.");
                Editable = Rec.Status = Rec.Status::Created;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::Created;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to approve the Leave Plan?', false) then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }
}






