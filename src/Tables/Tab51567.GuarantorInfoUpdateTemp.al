#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51567 "Guarantor Info Update Temp"
{

    fields
    {
        field(1; LoanNo; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; OrigAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; LoanNo, "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

