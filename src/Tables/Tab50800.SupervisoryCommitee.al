table 50800 "Supervisory Commitee"
{
    Caption = 'Supervisory Commitee';
    DataClassification = ToBeClassified;

    fields
    {
        //Supervisory of Directors
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[120])
        {
            Caption = 'Name';
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(5; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(6; Designation; Text[200]) { }


    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}


