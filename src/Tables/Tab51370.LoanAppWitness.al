#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51370 "Loan App Witness"
{
    Caption = 'Member App Witness Details';
    DrillDownPageID = "Loan Application Witness";
    LookupPageID = "Loan Application Witness";

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Witness No"; Code[30])
        {
            NotBlank = true;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Witness No") then
                    "Witness Name" := Cust.Name;
                "Date Captured" := Today;

                if LoansRegister.Get("Loan No") then
                    "Member No" := LoansRegister."Client Code";
            end;
        }
        field(3; "Witness Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Member No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(6; "Date Captured"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        LoansRegister: Record "Loans Register";
}

