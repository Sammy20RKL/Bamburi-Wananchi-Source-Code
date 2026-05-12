table 50801 "Sacco Information"
{
    Caption = 'Sacco Information';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';

        }
        field(2; "Sacco CEO"; Code[50])
        {
            TableRelation = Customer."No.";
            trigger OnValidate()
            begin
                if cust.Get("Sacco CEO") then begin
                    "Sacco CEO Name" := cust.Name;
                end;
            end;
        }
        field(3; "Sacco CEO Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Floor Number"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Building Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Principal Bank Branch"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "P.O Box"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Telephone; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Fax; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "E-Mail"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; IndAuditorBOX; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; PrincipalBankers; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; auditorcerfication; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(15; NoSaccoBraches; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; NoOfEmployees; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "L.R.No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; FloorNo; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Independent Auditor"; Text[50])
        {

        }
        field(21; PrincipalBankBox; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Sacco Principal Activities"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Sacco CEO P.O Box"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Dividends Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Deposits Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Previous Dividends Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Previous Deposits Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    var
        cust: record Customer;
}
