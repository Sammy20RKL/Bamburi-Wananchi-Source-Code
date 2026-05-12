Report 50327 FixeAssetbookValueReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Layouts/FixedAssetBookValue.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")

        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "FA Class Code";
            column(No_; "No.") { }
            column(FA_Class_Code; "FA Class Code") { }
            column(Description; "Description") { }
            column(Amount; Amount) { }
        }
    }



    var
        myInt: Integer;
}