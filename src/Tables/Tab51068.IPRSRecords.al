Table 51068 "IPRS Records"
{
    Caption = 'IPRS Records';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; "Application No"; Code[25])
        {
        }
        field(3; Result; Enum "IPRS Verifications Status's")
        {
        }
        field(4; "Significance(%)"; Integer)
        {
            Caption = 'Significance(%)';
        }
        field(5; "Applicant Full Name"; Text[200])
        {
        }
        field(6; Date; Date)
        {
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
