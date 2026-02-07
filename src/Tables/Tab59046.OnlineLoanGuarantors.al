#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 59046 "Online Loan Guarantors"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Loan Application No"; Code[20]) { }
        field(3; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                MembReg: Record Customer;
            begin
                MembReg.Reset;
                MembReg.SetRange(MembReg."No.", "Member No");
                if MembReg.FindFirst() then begin
                    "Names" := MembReg.Name;
                    "Id No" := MembReg."ID No.";
                    "Email Address" := MembReg."E-Mail (Personal)";
                    Telephone := MembReg."Mobile Phone No";
                end;
            end;
        }
        field(4; Names; Code[50]) { Editable = false; }
        field(5; "Email Address"; Code[50]) { Editable = false; }
        field(6; Telephone; Code[20]) { Editable = false; }
        field(7; Amount; Decimal) { }
        field(8; Approved; Option)
        {
            OptionMembers = Pending,Approved,Rejected;
        }
        field(9; "Approval Status"; Boolean) { }
        field(10; ApplicantNo; Code[20]) { }
        field(11; "ID No"; Code[20]) { Editable = false; }
        field(12; ApplicantName; Code[50]) { Editable = false; }
        field(13; "Applicant Mobile"; Code[30]) { }
        field(14; "Loan Type"; Code[30]) { }
    }

    keys
    {
        key(Key1; "Loan Application No", "Member No")
        {
        }
        key(Key2; ApplicantNo, "Member No", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var
        members: Record customer;
}

