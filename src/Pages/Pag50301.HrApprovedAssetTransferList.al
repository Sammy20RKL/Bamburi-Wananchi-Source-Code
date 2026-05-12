#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50301 "Hr ApprovedAsset Transfer List"
{
    // CardPageID = "Hr Approved Asset Transfer";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = 51260;
    SourceTableView = where(Transfered = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("No. Seriess"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Transfered; Rec.Transfered)
                {
                    ApplicationArea = Basic;
                }
                field("Date Transfered"; Rec."Date Transfered")
                {
                    ApplicationArea = Basic;
                }
                field("Transfered By"; Rec."Transfered By")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted"; Rec."Time Posted")
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

