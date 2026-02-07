table 53012 "Company Job"
{
    DrillDownPageID = "Company Job List";
    LookupPageID = "Company Job List";
    DataClassification = CustomerContent;
    Caption = 'Company Job';
    fields
    {
        field(1; "Job ID"; Code[80])
        {
            NotBlank = true;
            Caption = 'Job ID';
        }
        field(2; "Job Description"; Text[250])
        {
            Caption = 'Job Description';
        }
        field(3; "No of Posts"; Integer)
        {
            Caption = 'No of Posts';

            trigger OnValidate()
            begin
                CalcFields("Occupied Position");
                //IF "No of Posts" <> xRec."No of Posts" THEN
                // Vacancy := "No of Posts" - "Occupied Position";
            end;
        }
        field(4; "Position Reporting to"; Code[20])
        {
            TableRelation = "Company Job"."Job ID";
            Caption = 'Position Reporting to';

            trigger OnValidate()
            begin
                // if "Position Reporting to" = "Job ID" then
                //     Error(Text001)
                // else
                //     if "Position Reporting to" <> '' then begin
                //         JSupervised.Reset();
                //         JSupervised.SetRange("Job ID", "Position Reporting to");
                //     JSupervised.SetRange("Position Supervised", "Job ID");
                //         if not JSupervised.Find('-') then begin
                //             JSupervised.Init();
                //             JSupervised."Job ID" := "Position Reporting to";
                //             JSupervised."Position Supervised" := "Job ID";
                //             JSupervised.Validate("Position Supervised");
                //             if not JSupervised.Get(JSupervised."Job ID", JSupervised."Position Supervised") then
                //                 JSupervised.Insert();
                //         end;
                //     end;
            end;
        }
        field(5; "Occupied Position"; Integer)
        {
            CalcFormula = count(Employee where("Job Position" = field("Job ID")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Occupied Position';

            trigger OnValidate()
            begin
                Vacancy := "No of Posts" - "Occupied Position";
            end;
        }
        field(6; "Vacant Positions"; Integer)
        {
            Description = 'Removed, use vacancy instead';
            Caption = 'Vacant Positions';
        }
        field(7; "Score code"; Code[20])
        {
            Caption = 'Score code';
        }
        field(8; "Dimension 1"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Dimension 1';
        }
        field(9; "Dimension 2"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Dimension 2';

            trigger OnValidate()
            begin

                DimVal.Reset();
                DimVal.SetRange(Code, "Dimension 2");
                if DimVal.Find('-') then
                    "Department Name" := DimVal.Name;
            end;
        }
        field(10; "Dimension 3"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            Caption = 'Dimension 3';
        }
        field(11; "Dimension 4"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            Caption = 'Dimension 4';
        }
        field(12; "Dimension 5"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
            Caption = 'Dimension 5';
        }
        field(13; "Dimension 6"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
            Caption = 'Dimension 6';
        }
        field(14; "Dimension 7"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
            Caption = 'Dimension 7';
        }
        field(15; "Dimension 8"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
            Caption = 'Dimension 8';
        }
        field(17; "Total Score"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
            Caption = 'Total Score';
        }
        field(18; "Stage filter"; Integer)
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value";
            Caption = 'Stage filter';
        }
        field(19; Objective; Text[250])
        {
            Caption = 'Objective';
        }
        field(21; "Key Position"; Boolean)
        {
            Caption = 'Key Position';
        }
        field(22; Category; Code[20])
        {
            Caption = 'Category';
        }
        field(23; Grade; Code[20])
        {
            //  TableRelation = "Salary Scale".Scale;
            Caption = 'Grade';
        }
        field(24; "Primary Skills Category"; Option)
        {
            OptionCaption = 'Auditors,Consultants,Training,Certification,Administration,Marketing,Management,Business Development,Other';
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
            Caption = 'Primary Skills Category';
        }
        field(25; "2nd Skills Category"; Option)
        {
            OptionCaption = 'Auditors,Consultants,Training,Certification,Administration,Marketing,Management,Business Development,Other';
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
            Caption = '2nd Skills Category';
        }
        field(26; "3nd Skills Category"; Option)
        {
            OptionCaption = 'Auditors,Consultants,Training,Certification,Administration,Marketing,Management,Business Development,Other';
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
            Caption = '3nd Skills Category';
        }
        field(27; Management; Boolean)
        {
            Caption = 'Management';
        }
        field(28; Vacancy; Integer)
        {
            Caption = 'Vacancy';
        }
        field(29; "Department Name"; Text[100])
        {
            FieldClass = Normal;
            Caption = 'Department Name';
        }
        field(30; "Oral Interview"; Boolean)
        {
            Caption = 'Oral Interview';
        }
        field(31; "Oral Interview (Board)"; Boolean)
        {
            Caption = 'Oral Interview (Board)';
        }
        field(32; Classroom; Boolean)
        {
            Caption = 'Classroom';
        }
        field(33; Practical; Boolean)
        {
            Caption = 'Practical';
        }
        field(34; Blocked; Boolean)
        {
            Caption = 'Blocked';

        }
    }

    keys
    {
        key(Key1; "Job ID")
        {
            Clustered = true;
        }
        key(Key2; "Vacant Positions")
        {
        }
        key(Key3; "Dimension 1")
        {
        }
        key(Key4; "Dimension 2")
        {
        }
        key(Key5; "Total Score")
        {
            Enabled = false;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Job ID", "Job Description")
        {
        }
    }

    var
        DimVal: Record "Dimension Value";
        //  JSupervised: Record "Positions Supervised";
        Text001: Label 'The Job cannot be supervised by this Position';
}





