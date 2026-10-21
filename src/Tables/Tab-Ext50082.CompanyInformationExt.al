tableextension 50082 "CompanyInformationExt" extends "Company Information"
{
    fields
    {
        field(1000; "Company P.I.N"; Code[100])
        {
            Caption = '"Company P.I.N"';
            DataClassification = ToBeClassified;
        }
        field(1001; "Sacco Society CS Number"; Code[20])
        {
            Caption = 'Sacco Society CS Number';
            DataClassification = ToBeClassified;
        }

    }
}
