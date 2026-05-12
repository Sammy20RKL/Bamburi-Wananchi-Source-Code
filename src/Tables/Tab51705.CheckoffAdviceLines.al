#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51705 "Checkoff Advice Lines"
{
    // DrillDownPageID = 50771;
    // LookupPageID = 50771;

    fields
    {
        field(1; "Document No."; Code[15])
        {
        }
        field(2; MemberNo; Code[15])
        {
            TableRelation = Customer;
        }
        field(3; "Employer Code"; Code[20])
        {
            TableRelation = "Sacco Employers";

            trigger OnValidate()
            begin
                if ObjSaccoEmployers.Get("Employer Code") then begin
                    "Employer Name" := ObjSaccoEmployers.Description;
                end;
            end;
        }
        field(4; "Employer Name"; Text[80])
        {
        }
        field(5; "Payroll No."; Code[20])
        {
        }
        field(6; "Deposit Contribution"; Decimal)
        {
        }
        field(7; Repayment; Decimal)
        {
        }
        field(8; "Interest Amount"; Decimal)
        {
        }
        field(9; TotalRepayment; Decimal)
        {
        }
        field(10; "Total Amount"; Decimal)
        {
        }
        field(11; "Insurance Contribution"; Decimal)
        {
        }
        field(12; "Demand Savings"; Decimal)
        {
        }
        field(13; "Share Capital"; Decimal)
        {
        }
        field(14; Stocks; Decimal)
        {
        }
        field(15; ByLaws; Decimal)
        {
        }
        field(16; "Loan Product Type"; Code[30])
        {
        }
        field(17; "Remaining Period"; Integer)
        {
        }
        field(18; Period; Integer)
        {
        }
        field(19; "Approved Amount"; Decimal)
        {
        }
        field(20; "Loan Balance"; Decimal)
        {
        }
        field(21; RegistrationFee; Decimal)
        {
        }
        field(22; "Entry No"; Integer)
        {
        }
        field(23; "Principal Repayment"; Decimal)
        {
        }
        field(24; "Member Name"; Text[70])
        {
        }
        field(25; "Total Interest"; Decimal)
        {
        }
        field(26; TotalRemitance; Decimal)
        {
        }
        field(27; "Principal Amount"; Decimal)
        {
        }
        field(28; "Total Contribution"; Decimal)
        {
        }
        field(29; "Total Loan"; Decimal)
        {
        }
        field(30; "Checkoff Period"; Date)
        {
        }
        field(32; "Rejoining Fee"; Decimal)
        {
        }
        field(33; enumerat; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Document No.", MemberNo, "Employer Code", "Loan Product Type", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjSaccoEmployers: Record "Sacco Employers";
}

