page 70752 "Advertisements Card"
{
    PageType = Card;
    SourceTable = Advertisements;
    Caption = 'Advertisement Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; Rec."No") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field(Price; Rec.Price) { ApplicationArea = All; }
                field(Active; Rec.Active) { ApplicationArea = All; }
                field("Start Date"; Rec."Start Date") { ApplicationArea = All; }
                field("End Date"; Rec."End Date") { ApplicationArea = All; }
                field("Stock Qty"; Rec."Stock Qty") { ApplicationArea = All; }
                field(Category; Rec.Category) { ApplicationArea = All; }
            }
        }

        area(factboxes)
        {
            part(PicturePart; "Advertisement Picture")
            {
                ApplicationArea = All;
                visible = true;
                SubPageLink = "No" = field("No");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.PicturePart.Page.SetRecordOpen(true);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CurrPage.PicturePart.Page.SetRecordOpen(false);
    end;
}