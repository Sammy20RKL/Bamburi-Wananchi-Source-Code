#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50532 "Cheque Register List"
{
    PageType = List;
    SourceTable = "Cheques Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic;
                }
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cancelled/Stopped By"; Rec."Cancelled/Stopped By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Cancel Cheque")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to cancel cheque ?', false) = true then begin
                        if Rec.Status <> Rec.Status::Pending then
                            Error('Status must be pending');
                        Rec.Status := Rec.Status::Cancelled;
                        Rec."Approval Date" := Today;
                        Rec."Cancelled/Stopped By" := UserId;
                        Rec.Modify;
                    end;
                end;
            }
            action("Stop Cheque")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to stop cheque ?', false) = true then begin
                        if Rec.Status <> Rec.Status::Pending then
                            Error('Status must be pending');
                        Rec.Status := Rec.Status::stopped;
                        Rec."Approval Date" := Today;
                        Rec."Cancelled/Stopped By" := UserId;
                        Rec.Modify;
                    end;
                end;
            }
            action("Cancel Cheque Book")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    //reset;
                end;
            }
        }
    }
}

