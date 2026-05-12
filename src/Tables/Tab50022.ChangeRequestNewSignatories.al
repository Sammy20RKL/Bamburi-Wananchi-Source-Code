#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50022 "Change Request New Signatories"
{
    fields
    {
        field(1; "Document No"; Code[20])
        {
            TableRelation = "CEEP Change Request".No;
        }
        field(2; Names; Text[50])
        {
            NotBlank = true;
        }
        field(3; "Date Of Birth"; Date)
        {
        }
        field(4; "Staff/Payroll"; Code[20])
        {
        }
        field(5; "ID No."; Code[50])
        {

            trigger OnValidate()
            begin
                // "BOSA No." := '';
                // Names := '';
                // "Date Of Birth" := 0D;
                // "Email Address" := '';
                // CUST.Reset;
                // CUST.SetRange(CUST."ID No.", "ID No.");
                // if CUST.Find('-') then begin
                //     "BOSA No." := CUST."No.";
                //     Names := CUST.Name;
                //     "Date Of Birth" := CUST."Date of Birth";
                //     "Email Address" := cust."E-Mail (Personal)";
                // end;
            end;
        }
        field(6; Signatory; Boolean)
        {
        }
        field(7; "Must Sign"; Boolean)
        {
        }
        field(8; "Must be Present"; Boolean)
        {
        }
        field(14; "BOSA No."; Code[30])
        {
            TableRelation = Customer."No.";
        }
        field(15; "Email Address"; Text[50])
        {
        }
        field(16; "Mobile Number"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "ID No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CUST: Record Customer;
}

