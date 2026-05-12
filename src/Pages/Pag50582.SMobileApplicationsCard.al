#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50582 "S-Mobile Applications Card"
{
    PageType = Card;
    SourceTable = "SwizzKash Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Applied"; Rec."Time Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send for approval")
            {
                ApplicationArea = Basic;
                Caption = 'Send for approval';
                Image = Approve;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Application then
                        Error('Application is already sent for approval');

                    Rec.TestField(Telephone);
                    Rec.TestField("Account No");

                    //Status := Status::" Pending Approval";
                    Rec.Modify;
                    Message('Application has been sent to approval');
                end;
            }
        }
    }
}

