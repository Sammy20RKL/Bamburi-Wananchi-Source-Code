Page 56018 "Board of Directors Lists"
{
    ApplicationArea = All;
    Caption = 'Board of Directors List';
    PageType = ListPart;
    SourceTable = "Board of Directors";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = all;
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Active; Rec.Active)
                {
                }
            }
        }
    }
}
