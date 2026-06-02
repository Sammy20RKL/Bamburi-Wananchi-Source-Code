xmlport 50107 "Bulk SMS Phones"
{
    Format = VariableText;
    Direction = Import;

    schema
    {
        textelement(Root)
        {
            tableelement(BulkSMSLines; "Bulk SMS Lines")
            {
                AutoSave = false;

                fieldelement(TelephoneNo; BulkSMSLines.Code)
                {
                }


            }
        }
    }

    var
        BatchNo: Code[20];


}