table 52074 "Job Attachments"
{
    DataClassification = CustomerContent;
    Caption = 'Job Attachments';
    fields
    {
        field(1; "Job ID"; Code[30])
        {
            Caption = 'Job ID';
        }
        field(2; Attachment; Code[20])
        {
            TableRelation = Attachments;
            Caption = 'Attachment';

            trigger OnValidate()
            begin

                // if Attachments.Get(Attachment) then
                //     Description := Attachments.Description;
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Job ID", Attachment)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Attachments: Record Attachments;
}





