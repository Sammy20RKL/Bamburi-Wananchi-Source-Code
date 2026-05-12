#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50578 "S-Mobile Applications"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "SwizzKash Applications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field(Sent; Rec.Sent)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Applied"; Rec."Date Applied")
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

