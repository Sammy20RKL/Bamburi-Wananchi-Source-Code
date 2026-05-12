#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50004 "Membership Applications NOK"
{

    fields
    {
        field(1; "Account No"; Code[30])
        {
            TableRelation = "Membership Applications"."No.";
        }
        field(1212; "No."; code[20])
        {
            TableRelation = "Membership Applications"."No.";
        }
        field(1213; "Monthly Contribution"; Decimal) { }
        field(2; "Full Names"; Text[200])
        {
            NotBlank = true;
            trigger OnValidate()
            begin
                "Full Names" := UpperCase("Full Names");
            end;
        }
        field(3; Relationship; Text[200])
        {
            NotBlank = true;
            TableRelation = "Relationship Types";
        }
        field(4; Beneficiary; Boolean)
        {
        }
        field(5; "Date of Birth"; Date)
        {

            trigger OnValidate()
            begin

            end;
        }
        field(6; "Identification No."; Text[80])
        {
        }
        field(7; "Phone No"; Code[50])
        {
        }
        field(9; Email; Text[30])
        {
        }
        field(12; "%Allocation"; Decimal)
        {

            trigger OnValidate()
            begin
            end;
        }
        field(4141; "FOSA Account No."; code[20]) { }
        field(13; "Total %Allocation"; Decimal)
        {
            CalcFormula = sum("Membership Applications NOK"."%Allocation" where("Account No" = field("Account No")));
            FieldClass = FlowField;
            Editable = false;
            trigger OnValidate()
            begin
            end;
        }
        field(14; "Registration Fee Paid"; Decimal) { }
    }

    keys
    {
        key(Key1; "Account No", "Full Names")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var

}

