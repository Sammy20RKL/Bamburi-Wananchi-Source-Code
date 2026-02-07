table 50144 "Dividends Register Flat Rate"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
        }
        field(2; "Date Processed"; Date)
        {
        }
        field(6; "Current Shares"; Decimal)
        {
        }
        field(7; "Qualifying Current Shares"; Decimal)
        {
        }
        field(3; "Gross Interest -Current Shares"; Decimal)
        {
        }
        field(16; "WTX -Current Shares"; Decimal)
        {
        }
        field(17; "Net Interest -Current Shares"; Decimal)
        {
        }
        field(20; "FOSA Shares"; Decimal)
        {
        }
        field(21; "Qualifying FOSA Shares"; Decimal)
        {
        }
        field(22; "Gross Interest -FOSA Shares"; Decimal)
        {
        }
        field(23; "WTX -FOSA Shares"; Decimal)
        {
        }
        field(4; "Net Interest -FOSA Shares"; Decimal)
        {
        }
        field(25; "Computer Shares"; Decimal)
        {
        }
        field(26; "Qualifying Computer Shares"; Decimal)
        {
        }
        field(27; "Gross Interest-Computer Shares"; Decimal)
        {
        }
        field(28; "WTX -Computer Shares"; Decimal)
        {
        }
        field(29; "Net Interest -Computer Shares"; Decimal)
        {
        }
        field(30; "Van Shares"; Decimal)
        {
        }
        field(31; "Qualifying Van Shares"; Decimal)
        {
        }
        field(32; "Gross Interest-Van Shares"; Decimal)
        {
        }
        field(33; "WTX -Van Shares"; Decimal)
        {
        }
        field(34; "Net Interest -Van Shares"; Decimal)
        {
        }
        field(35; "Preferential Shares"; Decimal)
        {
        }
        field(36; "Qualifying Preferential Shares"; Decimal)
        {
        }
        field(37; "Gross Int-Preferential Shares"; Decimal)
        {
        }
        field(38; "WTX -Preferential Shares"; Decimal)
        {
        }
        field(39; "Net Int-Preferential Shares"; Decimal)
        {
        }
        field(40; "Lift Shares"; Decimal)
        {
        }
        field(41; "Qualifying Lift Shares"; Decimal)
        {
        }
        field(42; "Gross Int-Lift Shares"; Decimal)
        {
        }
        field(43; "WTX -Lift Shares"; Decimal)
        {
        }
        field(44; "Net Int-Lift Shares"; Decimal)
        {
        }
        field(45; "Tambaa Shares"; Decimal)
        {
        }
        field(46; "Qualifying Tambaa Shares"; Decimal)
        {
        }
        field(47; "Gross Int-Tambaa Shares"; Decimal)
        {
        }
        field(48; "WTX -Tambaa Shares"; Decimal)
        {
        }
        field(49; "Net Int-Tambaa Shares"; Decimal)
        {
        }
        field(50; "Pepea Shares"; Decimal)
        {
        }
        field(51; "Qualifying Pepea Shares"; Decimal)
        {
        }
        field(52; "Gross Int-Pepea Shares"; Decimal)
        {
        }
        field(53; "WTX -Pepea Shares"; Decimal)
        {
        }
        field(54; "Net Int-Pepea Shares"; Decimal)
        {
        }
        field(55; "Housing Shares"; Decimal)
        {
        }
        field(56; "Qualifying Housing Shares"; Decimal)
        {
        }
        field(57; "Gross Int-Housing Shares"; Decimal)
        {
        }
        field(58; "WTX -Housing Shares"; Decimal)
        {
        }
        field(59; "Net Int-Housing Shares"; Decimal)
        {
        }
        field(60; "Capitalized Amount"; Decimal)
        {
        }
        field(61; "Net Pay To FOSA"; Decimal)
        {
        }
        field(5; "Witholding Tax"; Decimal)
        {
        }

        field(8; Shares; Decimal)
        {
        }
        field(9; "Share Capital"; Decimal)
        {
        }
        field(10; "Gross Dividend/Rebates"; Decimal)
        {
        }
        field(12; "Interest From FOSA Shares"; Decimal)
        {
        }
        field(13; Balance; Decimal)
        {
        }
        field(14; "Dividend Year"; Code[20])
        {
        }
        field(15; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }

    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
            // SumIndexFields = "Gross Dividends", "Witholding Tax", "Qualifying Shares", "Net Dividends/Rebates", "Gross Rebates";
        }
    }

    fieldgroups
    {
    }
}

