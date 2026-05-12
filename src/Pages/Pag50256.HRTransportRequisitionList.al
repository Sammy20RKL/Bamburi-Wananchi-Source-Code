#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50256 "HR Transport Requisition List"
{
    CardPageID = "HR Staff Transport Requisition";
    PageType = List;
    SourceTable = "HR Transport Requisition";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Code"; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Email"; Rec."Supervisor Email")
                {
                    ApplicationArea = Basic;
                }
                field("Job Tittle"; Rec."Job Tittle")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
                field("Purpose of Trip"; Rec."Purpose of Trip")
                {
                    ApplicationArea = Basic;
                }
                field("Transport type"; Rec."Transport type")
                {
                    ApplicationArea = Basic;
                }
                field("Time of Trip"; Rec."Time of Trip")
                {
                    ApplicationArea = Basic;
                }
                field("Pickup Point"; Rec."Pickup Point")
                {
                    ApplicationArea = Basic;
                }
                field("From Destination"; Rec."From Destination")
                {
                    ApplicationArea = Basic;
                }
                field("To Destination"; Rec."To Destination")
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

