#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50147 "Medical Claim Entries"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Medical Claim Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ApplicationArea = Basic;
                }
                field("Hospital Visit Date"; Rec."Hospital Visit Date")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Limit"; Rec."Claim Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Claim Amount"; Rec."Balance Claim Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Claimed"; Rec."Amount Claimed")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Charged"; Rec."Amount Charged")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field("USER ID"; Rec."USER ID")
                {
                    ApplicationArea = Basic;
                }
                field("Claim No"; Rec."Claim No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
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

