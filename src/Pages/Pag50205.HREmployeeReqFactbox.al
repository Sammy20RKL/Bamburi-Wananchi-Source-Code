#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50205 "HR Employee Req. Factbox"
{
    PageType = ListPart;
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            field("Job ID"; Rec."Job ID")
            {
                ApplicationArea = Basic;
            }
            field("No of Posts"; Rec."No of Posts")
            {
                ApplicationArea = Basic;
            }
            field("Position Reporting to"; Rec."Position Reporting to")
            {
                ApplicationArea = Basic;
            }
            field("Occupied Positions"; Rec."Occupied Positions")
            {
                ApplicationArea = Basic;
            }
            field("Vacant Positions"; Rec."Vacant Positions")
            {
                ApplicationArea = Basic;
            }
            field(Category; Rec.Category)
            {
                ApplicationArea = Basic;
            }
            field(Grade; Rec.Grade)
            {
                ApplicationArea = Basic;
            }
            field("Employee Requisitions"; Rec."Employee Requisitions")
            {
                ApplicationArea = Basic;
            }
            field("Supervisor Name"; Rec."Supervisor Name")
            {
                ApplicationArea = Basic;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }
}

