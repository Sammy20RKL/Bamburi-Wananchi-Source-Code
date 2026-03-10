#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
Table 59057 "Dividends Header"
{

    fields
    {
        field(1; "No"; Code[20])
        {
            trigger OnValidate()
            begin
                if No <> xRec.No then
                    SalesSetup.Get();
                NoSeries.TestManual(SalesSetup."Dividend Nos");
                "No_ Series" := '';

            end;
        }
        field(2; "Description"; Text[30])
        {
        }
        field(3; "Year"; Integer)
        {
        }
        field(4; "Posted"; Boolean)
        {

        }
        field(5; "Deposits"; Decimal)
        {
            DecimalPlaces = 2 : 20;
        }
        field(6; "No_ Series"; Code[20])
        {

        }
        field(7; "Earned Amount"; Decimal)
        {
            DecimalPlaces = 2 : 20;
        }
        field(8; "Withholding Tax(Share&Depo)"; Decimal)
        {
            DecimalPlaces = 2 : 20;
        }
        field(9; "Net Pay"; Decimal)
        {
            DecimalPlaces = 2 : 20;
        }
    }

    keys
    {
        key(Key1; "No")
        {
            Clustered = true;
        }
        key(Key2; "Year")
        {
        }
        key(Key3; "Posted")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No", "Description", "Year")
        {
        }
    }
    trigger OnInsert()
    begin
        if No = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(SalesSetup."Dividend Nos");
            "No_ Series" := xRec."No_ Series";
            No := NoSeries.GetNextNo(SalesSetup."Dividend Nos");
        end;
    end;


    var
        SalesSetup: Record "Sacco No. Series";
        NoSeries: Codeunit "No. Series";
}