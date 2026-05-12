#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51054 "Job-Planning Line"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(2; "Grant No."; Code[50])
        {
            Caption = 'Grant No.';
            Editable = false;
            TableRelation = Jobs;
        }
        field(3; "Planning Date"; Date)
        {
            Caption = 'Planning Date';

            trigger OnValidate()
            begin

            end;
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account,Text';
            OptionMembers = Resource,Item,"G/L Account",Text;

            trigger OnValidate()
            begin

            end;
        }
    }
}