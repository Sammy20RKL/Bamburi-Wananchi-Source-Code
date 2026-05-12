#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51711 "Savings Guarantorship"
{

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Date := Today;

                Cust.Reset;
                Cust.SetRange(Cust."No.", "Member No");
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Jiokoe Savings");
                    SavBal := Cust."Jiokoe Savings";

                end;

                if Cust.Get("Member No") then begin
                    Cust.CalcFields(Cust."Outstanding Balance", Cust."Jiokoe Savings", Cust.TLoansGuaranteed);
                    Name := Cust.Name;
                    "Loan Balance" := Cust."Outstanding Balance";
                    SavBal := Cust."Jiokoe Savings";
                    Amont := 0;
                    Amont := SwizzsoftFactory.FnGetMemberSavingsLiability("Member No");
                    Liability := Liability - Amont;
                end;
            end;
        }
        field(3; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Jiokoe Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Amount Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Liability; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No", "Member No", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        SavBal: Decimal;
        Amont: Decimal;
        SwizzsoftFactory: Codeunit "Swizzsoft Factory.";
}

