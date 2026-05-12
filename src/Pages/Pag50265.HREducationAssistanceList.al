#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50265 "HR Education Assistance List"
{
    CardPageID = "HR Education Assistance";
    PageType = List;
    SourceTable = "HR Education Assistance";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee First Name"; Rec."Employee First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Last Name"; Rec."Employee Last Name")
                {
                    ApplicationArea = Basic;
                }
                field("Type Of Institution"; Rec."Type Of Institution")
                {
                    ApplicationArea = Basic;
                }
                field("Educational Institution"; Rec."Educational Institution")
                {
                    ApplicationArea = Basic;
                }
                field("Year Of Study"; Rec."Year Of Study")
                {
                    ApplicationArea = Basic;
                }
                field("Refund Level"; Rec."Refund Level")
                {
                    ApplicationArea = Basic;
                }
                field("Student Number"; Rec."Student Number")
                {
                    ApplicationArea = Basic;
                }
                field("Study Period"; Rec."Study Period")
                {
                    ApplicationArea = Basic;
                }
                field("Total Cost"; Rec."Total Cost")
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

