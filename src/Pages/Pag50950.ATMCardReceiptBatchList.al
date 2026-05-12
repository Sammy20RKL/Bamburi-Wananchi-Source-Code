#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50950 "ATM Card Receipt Batch List"
{
    // CardPageID = "ATM Card Receipt Batch Card";
    Editable = false;
    PageType = List;
    SourceTable = 51911;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                }
                field("Description/Remarks"; Rec."Description/Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Requested; Rec.Requested)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested"; Rec."Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Prepared By"; Rec."Prepared By")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
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

