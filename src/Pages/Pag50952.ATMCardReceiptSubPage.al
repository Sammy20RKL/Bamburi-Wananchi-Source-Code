#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50952 "ATM Card Receipt SubPage"
{
    PageType = ListPart;
    SourceTable = 51912;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ATM Application No"; Rec."ATM Application No")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Account No"; Rec."ATM Card Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Application Date"; Rec."ATM Card Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card No"; Rec."ATM Card No")
                {
                    ApplicationArea = Basic;
                }
                field(Received; Rec.Received)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received On"; Rec."Received On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

