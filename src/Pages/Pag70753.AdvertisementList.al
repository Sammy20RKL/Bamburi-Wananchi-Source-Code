page 70753 "Advertisements List"
{
    PageType = List;
    SourceTable = Advertisements;
    CardPageId = "Advertisements Card";
    Caption = 'Advertisements';

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(No; Rec.No) { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field(Price; Rec.Price) { ApplicationArea = All; }
                field(Category; Rec.Category) { ApplicationArea = All; }
                field(Active; Rec.Active) { ApplicationArea = All; }
                field("Stock Qty"; Rec."Stock Qty") { ApplicationArea = All; }
                field("Start Date"; Rec."Start Date") { ApplicationArea = All; }
                field("End Date"; Rec."End Date") { ApplicationArea = All; }
            }
        }
        area(factboxes)
        {
            part(Control149; "Advertisement Picture")
            {

                ApplicationArea = all;
                SubPageLink = "No" = FIELD("No");
                Enabled = true;

            }
        }
    }
}