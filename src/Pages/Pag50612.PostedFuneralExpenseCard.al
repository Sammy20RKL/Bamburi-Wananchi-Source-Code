#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50612 "Posted Funeral Expense Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Funeral Expense Payment";

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = Basic;
            }
            field("Member No."; Rec."Member No.")
            {
                ApplicationArea = Basic;
            }
            field("Member Name"; Rec."Member Name")
            {
                ApplicationArea = Basic;
            }
            field("Member ID No"; Rec."Member ID No")
            {
                ApplicationArea = Basic;
            }
            field(Picture; Rec.Picture)
            {
                ApplicationArea = Basic;
            }
            field("Member Status"; Rec."Member Status")
            {
                ApplicationArea = Basic;
            }
            field("Death Date"; Rec."Death Date")
            {
                ApplicationArea = Basic;
            }
            field("Date Reported"; Rec."Date Reported")
            {
                ApplicationArea = Basic;
            }
            field("Reported By"; Rec."Reported By")
            {
                ApplicationArea = Basic;
            }
            field("Reporter ID No."; Rec."Reporter ID No.")
            {
                ApplicationArea = Basic;
            }
            field("Reporter Mobile No"; Rec."Reporter Mobile No")
            {
                ApplicationArea = Basic;
            }
            field("Reporter Address"; Rec."Reporter Address")
            {
                ApplicationArea = Basic;
            }
            field("Relationship With Deceased"; Rec."Relationship With Deceased")
            {
                ApplicationArea = Basic;
            }
            field("Received Burial Permit"; Rec."Received Burial Permit")
            {
                ApplicationArea = Basic;
            }
            field("Received Letter From Chief"; Rec."Received Letter From Chief")
            {
                ApplicationArea = Basic;
            }
            field(Posted; Rec.Posted)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Date Posted"; Rec."Date Posted")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Time Posted"; Rec."Time Posted")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Posted By"; Rec."Posted By")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
        }
    }

    actions
    {
    }
}

