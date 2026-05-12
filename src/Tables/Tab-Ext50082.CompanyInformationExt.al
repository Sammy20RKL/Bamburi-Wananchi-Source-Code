tableextension 50082 "CompanyInformationExt" extends "Company Information"
{
    fields
    {
        field(1000; "Company P.I.N"; Code[100])
        {
            Caption = '"Company P.I.N"';
            DataClassification = ToBeClassified;
        }

    }
}
