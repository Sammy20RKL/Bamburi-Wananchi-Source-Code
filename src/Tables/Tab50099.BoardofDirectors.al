table 50099 "Board of Directors"
{
    Caption = 'Board of Directors';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        //Board of Directors
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
            TableRelation = customer."No." where(Board = const(true));
            trigger OnValidate()
            var
            //NewString: text[200];
            begin
                if Cust.Get("No.") then begin
                    Name := Cust.Name;

                end;
            end;
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
        field(6; "Sacco CEO"; Code[30])
        {

        }
        field(7; "Sacco CEO Name"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Designation; Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        Cust: Record Customer;
}
