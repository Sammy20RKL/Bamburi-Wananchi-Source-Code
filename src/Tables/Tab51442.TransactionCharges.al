#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51442 "Transaction Charges"
{
    DrillDownPageID = 50488;
    LookupPageID = 50488;

    fields
    {
        field(1; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types";
        }
        field(2; "Charge Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Charges;

            trigger OnValidate()
            begin
                if Charges.Get("Charge Code") then begin
                    Description := Charges.Description;
                    "Charge Amount" := Charges."Charge Amount";
                    "Percentage of Amount" := Charges."Percentage of Amount";
                    "Use Percentage" := Charges."Use Percentage";
                    //"Minimum Amount":=Charges."Minimum Amount";
                    //"Maximum Amount":=Charges."Maximum Amount";
                    "G/L Account" := Charges."GL Account";
                end;
            end;
        }
        field(3; Description; Text[150])
        {
        }
        field(4; "Charge Amount"; Decimal)
        {
        }
        field(62; "Charge Type"; Option)
        {
            OptionCaption = 'Flat Amount,Percentage of Amount,Staggered';
            OptionMembers = "Flat Amount","Percentage of Amount",Staggered;
        }
        field(5; "Percentage of Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Percentage of Amount" > 100 then
                    Error('You cannot exceed 100. Please enter a valid number.');
            end;
        }
        field(6; "Use Percentage"; Boolean)
        {
        }
        field(7; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(8; "Minimum Amount"; Decimal)
        {
        }
        field(9; "Maximum Amount"; Decimal)
        {
        }
        field(10; "Due Amount"; Decimal)
        {
        }
        field(11; "Due to Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(12; "Charges 1-999"; Decimal)
        {
        }
        field(13; "Charges 1000-19999"; Decimal)
        {
        }
        field(14; "Charges 20000-49999"; Decimal)
        {
        }
        field(15; "Charges 50000-99999"; Decimal)
        {
        }
        field(16; "Charges 100000"; Decimal)
        {
        }
        field(17; "PayOut 50-100"; Decimal)
        {
        }
        field(18; "PayOut 100-200"; Decimal)
        {
        }
        field(19; "PayOut 201-300"; Decimal)
        {
        }
        field(20; "PayOut 301-400"; Decimal)
        {
        }
        field(21; "PayOut 401-500"; Decimal)
        {
        }
        field(22; "PayOut 501-600"; Decimal)
        {
        }
        field(23; "PayOut 601  &  Above"; Decimal)
        {
        }
        field(24; "Total Charges"; Decimal)
        {
            CalcFormula = sum("Transaction Charges"."Charge Amount" where("Transaction Type" = field("Transaction Type")));
            FieldClass = FlowField;
        }
        field(25; "Include Excise Duty"; Boolean)
        {
        }
        field(26; "Excise Duty (10%)"; Decimal)
        {
        }
        field(27; "Transaction Code"; Code[20])
        {
        }
        field(28; "Charge Excise Duty"; Boolean)
        {
        }
        field(29; "Staggered Charge Code"; Code[20])
        {
            TableRelation = "Tarrif Header".Code;
        }
    }

    keys
    {
        key(Key1; "Transaction Type", "Charge Code", "Transaction Code", "Minimum Amount", "Maximum Amount")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Charges: Record Charges;
}

