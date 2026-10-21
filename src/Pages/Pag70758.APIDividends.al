page 70758 "API Dividends"
{
    PageType = API;
    APIPublisher = 'swizzsoft';
    APIGroup = 'bamburi';
    APIVersion = 'v1.0';
    EntityName = 'dividend';
    EntitySetName = 'dividends';
    SourceTable = "Dividends Header";
    SourceTableView = where(Posted = const(true));
    DelayedInsert = true;
    ODataKeyFields = "No";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No") { }
                field(description; Rec.Description) { }
                field(year; Rec.Year) { }
                field(posted; Rec.Posted) { }
                field(deposits; Rec.Deposits) { }
                field(earnedAmount; Rec."Earned Amount") { }
                field(withholdingTax; Rec."Withholding Tax(Share&Depo)") { }
                field(netPay; Rec."Net Pay") { }
                field(postingDate; Rec."Posting Date") { }
                field(documentNo; Rec."Document No") { }
            }
        }
    }
}
