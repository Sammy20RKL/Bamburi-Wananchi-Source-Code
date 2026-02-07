#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50519 "SMS Messages"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "SMS Messages";
    UsageCategory = Lists;
    SourceTableView =
        sorting("Entry No.")
        order(descending);

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
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Message"; Rec."SMS Message")
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field("Sent To Server"; Rec."Sent To Server")
                {
                    ApplicationArea = Basic;

                }
                field("System Date"; Rec."System Date")
                {
                    ApplicationArea = Basic;

                }
                field("System Time"; Rec."System Time")
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

