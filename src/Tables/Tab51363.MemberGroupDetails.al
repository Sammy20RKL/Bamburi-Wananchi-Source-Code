#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51363 "Member Group Details"
{
    Caption = 'Member App Witness Details';
    // DrillDownPageID = 50363;
    // LookupPageID = 50363;

    fields
    {
        field(1; "Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Membership Applications"."No.";
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
            NotBlank = true;
        }
        field(9; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(10; Signature; Blob)
        {
            Caption = 'Signature';
            SubType = Bitmap;
        }
        field(11; Date; Date)
        {
        }
        field(12; "BOSA No."; Code[30])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if Cust.Get("BOSA No.") then begin
                    //Cust.CALCFIELDS(Cust.Picture,Cust.Signature);
                    Names := Cust.Name;
                    "ID No." := Cust."ID No.";
                    "Email Address" := Cust."E-Mail (Personal)";
                    "Date Of Birth" := Cust."Date of Birth";
                    "Staff/Payroll" := Cust."Personal No";
                    Address := Cust.Address;
                    //Picture:=Cust.Picture;
                    //Signature:=Cust.Signature;
                    "Mobile No." := Cust."Mobile Phone No";
                end;
            end;
        }
        field(13; "Email Address"; Text[50])
        {
        }
        field(15; "Mobile No."; Code[20])
        {
            NotBlank = true;
        }
        field(17; Title; Option)
        {
            OptionCaption = 'Member,Chairperson,Secretary,Treasurer';
            OptionMembers = Member,Chairperson,Secretary,Treasurer;
        }
        field(18; Address; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Entry; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(20; Signatory; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Account No", Names)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
}

