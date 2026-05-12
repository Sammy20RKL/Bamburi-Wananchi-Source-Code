#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50297 "HR Approved  Emp Transfer List"
{
    // CardPageID = "HR Approved Emp Transfer Card";
    Editable = false;
    PageType = List;
    SourceTable = "HR Employee Transfer Header";
    SourceTableView = where(Status = const(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No"; Rec."Request No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested"; Rec."Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Transfer details Updated"; Rec."Transfer details Updated")
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

