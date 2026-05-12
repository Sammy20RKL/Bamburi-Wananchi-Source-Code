XmlPort 50104 "Import BOSA Members"
{
    Caption = 'Import BOSA Members';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(MembersRegister; Customer)
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
