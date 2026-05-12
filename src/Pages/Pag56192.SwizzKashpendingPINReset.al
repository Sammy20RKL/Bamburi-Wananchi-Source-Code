#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56192 "SwizzKash pending PIN Reset"
{
    ApplicationArea = Basic;
    Editable = false;
    PageType = List;
    SourceTable = "SwizzKash Applications";
    SourceTableView = sorting("No.")
                      order(ascending)
                      ;
    UsageCategory = Lists;

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(SentToServer; Rec.SentToServer)
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
                field("PIN Requested"; Rec."PIN Requested")
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

