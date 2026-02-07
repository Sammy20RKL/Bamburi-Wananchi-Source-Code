#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50056 "loans Cuess"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
        }
        field(2; "Applied Loans"; Integer)
        {
            CalcFormula = COUNT("Loans Register" WHERE("Approval Status" = CONST(Open), "Approved Amount" = filter(> 0), "Loan Status" = const(Application), Source = const(BOSA)));
            FieldClass = FlowField;

        }
        field(3; "Active Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), Source = const(BOSA)));
            FieldClass = FlowField;
        }
        field(4; "Pending Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Pending), "Approved Amount" = filter(> 0), "Loan Status" = const(Appraisal), Source = const(BOSA)));
            FieldClass = FlowField;
        }


        field(8; "EMERGENCY LOAN"; Integer)
        {
            CalcFormula = COUNT("Loans Register" WHERE("Approval Status" = CONST(Approved), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), "Loan Product Type" = filter(12)));
            FieldClass = FlowField;

        }
        field(9; "SUPER EMERGENCY LOAN"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), "Loan Product Type" = filter(13)));
            FieldClass = FlowField;
        }
        field(10; "DEBOOSTER"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Issued), "Loan Product Type" = filter('DEBOOSTER')));
            FieldClass = FlowField;

        }
        field(11; "SCHOOL FEES"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Loan Status" = const(Issued), "Outstanding Balance" = filter(> 0), "Loan Product Type" = filter(17)));
            FieldClass = FlowField;
        }
        field(12; "FURNITURE"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Loan Status" = const(Issued), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('FURNITURE')));
            FieldClass = FlowField;
        }
        field(13; "HOUSEHOLD"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Loan Status" = const(Issued), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('HOUSEHOLD')));
            FieldClass = FlowField;
        }
        field(14; "IPF"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('IPF')));
            FieldClass = FlowField;
        }
        field(15; "SUPER SCHOOL FEES"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = filter(18)));
            FieldClass = FlowField;
        }
        field(16; "M-POLYTECH"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = filter(24)));
            FieldClass = FlowField;
        }
        field(17; "DEVELOPMENT LOAN"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = filter(25)));
            FieldClass = FlowField;
        }
        field(18; "NORMAL LOAN"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = filter(20)));
            FieldClass = FlowField;
        }
        field(19; "DEVELOPMENT LOAN 1"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = filter(23)));
            FieldClass = FlowField;
        }
        field(20; "QUICK LOAN"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = filter(15)));
            FieldClass = FlowField;
        }
        field(21; "SUPER QUICK"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Product Type" = filter(16)));
            FieldClass = FlowField;
        }
        field(22; "Cleared Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(<= 0), "Loan Status" = const(Issued), Source = const(BOSA)));
            FieldClass = FlowField;
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


