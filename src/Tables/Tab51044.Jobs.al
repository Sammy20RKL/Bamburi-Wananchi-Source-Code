#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51044 Jobs
{
    Caption = 'Job';


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin

            end;
        }
        field(2; "Search Description"; Code[250])
        {
            Caption = 'Search Description';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
            end;
        }
        field(4; "Description 2"; Text[80])
        {
            Caption = 'Description 2';
        }
        field(5; "Bill-to Partner No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            //TableRelation = Customer."No." where ("Account Type"=filter(Donor));

            trigger OnValidate()
            begin
            end;
        }
        field(12; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(13; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                //CheckDate;
            end;
        }
        field(14; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
            end;
        }
        field(19; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Concept Formulation,Proposal,Contract,Project,Completed';
            OptionMembers = "Concept Formulation",Proposal,Contract,Project,Completed;

            trigger OnValidate()
            var
                JobPlanningLine: Record "Job-Planning Line";
            begin
            end;
        }
        field(20; "Person Responsible"; Code[20])
        {
            Caption = 'Person Responsible';
            TableRelation = Resource;
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
            end;
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
            end;
        }
        field(23; "Job Posting Group"; Code[10])
        {
            Caption = 'Kind of Program';
        }
        field(24; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Posting,All';
            OptionMembers = " ",Posting,All;
        }
        field(29; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(30; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
        }
        field(31; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(32; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(49; "Scheduled Res. Qty."; Decimal)
        {

        }
        field(50; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource;
        }
        field(51; "Posting Date Filter"; Date)
        {
            Caption = 'Posting Date Filter';
            FieldClass = FlowFilter;
        }
        field(55; "Resource Gr. Filter"; Code[20])
        {
            Caption = 'Resource Gr. Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
    }
}
