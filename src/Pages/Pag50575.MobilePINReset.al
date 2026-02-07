#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50575 "Mobile PIN Reset"
{
    CardPageID = "SwizzKash PIN Reset Card";
    DelayedInsert = true;
    DeleteAllowed = true;
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
                    Editable = false;
                    Enabled = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SentToServer; Rec.SentToServer)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reset PIN';
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Last PIN Reset"; Rec."Last PIN Reset")
                {
                    ApplicationArea = Basic;
                }
                field("Reset By"; Rec."Reset By")
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

