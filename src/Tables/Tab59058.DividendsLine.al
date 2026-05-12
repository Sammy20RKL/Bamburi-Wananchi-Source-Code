#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
table 59058 "Dividends Lines"
{

    fields
    {
        field(1; "No"; Code[20])
        {

            TableRelation = "Dividends Header"."No";
            Editable = false;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if "Member No" = '' then begin
                    "Member Name" := '';
                    exit;
                end;

                if Customer.Get("Member No") then begin
                    "Member Name" := Customer.Name;
                    "Staff No" := Customer."Personal No";
                    "ID No" := Customer."ID No."
                end else begin
                    "Member Name" := '';
                    "Staff No" := '';
                    "ID No" := '';
                    Error('Customer %1 does not exist.', "Member No");
                end;
            end;

        }
        field(3; "Member Name"; Text[50])
        {
            Editable = false;

        }
        field(4; "Employer Code"; Code[20])
        {
            TableRelation = "Sacco Employers".Code;

        }
        field(5; "Staff No"; Code[20])
        {

        }
        field(6; "Status"; Integer)
        {
        }
        field(7; "Blocked"; Integer)
        {

        }
        field(8; "Loan Recovered Deposits"; Decimal)
        {
            DecimalPlaces = 2 : 20;
        }
        field(9; "Loan Recovered Dividend"; Decimal)
        {

            DecimalPlaces = 2 : 20;
        }
        field(10; "Member Status"; Integer)
        {
        }
        field(11; "Member Blocked"; Integer)
        {

        }
        field(12; "Earned Amount"; Decimal)
        {
            DecimalPlaces = 2 : 20;
        }
        field(13; "Withholding Tax(Share&Depo)"; Decimal)
        {
            DecimalPlaces = 2 : 20;
        }
        field(14; "Net Pay"; Decimal)
        {
            DecimalPlaces = 2 : 20;
        }
        field(15; "ID No"; Text[50])
        {
        }
        field(16; "Qualifying Amount"; Decimal)
        {
            DecimalPlaces = 2 : 20;
        }
    }

    keys
    {
        key(Key1; "No", "Member No")
        {
            Clustered = true;
        }
        key(Key2; "Member No")
        {
        }
        key(Key3; "Employer Code")
        {
        }
        key(Key4; "Status")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No", "Member No", "Member Name")
        {
        }
    }
}