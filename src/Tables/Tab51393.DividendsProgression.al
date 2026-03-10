#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51393 "Dividends Progression"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(51516155; Year; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Gross Dividends"; Decimal)
        {
        }
        field(4; "Witholding Tax"; Decimal)
        {
        }
        field(5; "Net Dividends"; Decimal)
        {
        }
        field(6; "Qualifying Shares"; Decimal)
        {
        }
        field(7; Shares; Decimal)
        {
        }
        field(51516150; "Share Capital"; Decimal)
        {
        }
        field(51516151; "Qualifying Share Capital"; Decimal)
        {
        }
        field(51516152; "Gross Interest On Deposit"; Decimal)
        {
        }
        field(51516153; "Gross Interest On Sharecapital"; Decimal)
        {
        }
        field(51516154; "Current Shares"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(51516156; "Savings Types"; Option)
        {
            OptionMembers = Deposits,Shares,Fixed;
            Caption = 'Savings Type';
            OptionCaption = 'Deposits, Shares, Fixed';
            DataClassification = ToBeClassified;
        }
        field(51516157; "Member Name"; Text[250]) { }
    }

    keys
    {
        key(Key1; "Member No", Date)
        {
            Clustered = true;
            SumIndexFields = "Gross Dividends", "Net Dividends", Shares, "Qualifying Shares", "Witholding Tax";
        }
        key(Key2; Date)
        {
        }
    }

    fieldgroups
    {
    }
}

