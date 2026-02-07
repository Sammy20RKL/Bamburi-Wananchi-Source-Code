tableextension 52054 ApprovalEntryTableExt extends "Approval Entry"
{
    fields
    {
        field(50001; "Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }


}