table 52017 "Leave Bal Adjustment Lines"
{
    //DataClassification = CustomerContent;
    Caption = 'Leave Bal Adjustment Lines';
    fields
    {
        field(1; "Staff No."; Code[30])
        {
            TableRelation = "HR Employees"."No.";
            Caption = 'Staff No.';

            trigger OnValidate()
            begin
                if Employees.Get("Staff No.") then begin
                    "Employee Name" := Employees.FullName();
                    "Employment Type" := Employees."Employment Type";
                end;
            end;
        }
        field(2; "Header No."; Code[20])
        {
            Caption = 'Header No.';
        }
        field(3; "Maturity Date"; Date)
        {
            Caption = 'Maturity Date';
        }
        field(4; "New Bal. Brought Forward"; Decimal)
        {
            Caption = 'New Bal. Brought Forward';
        }
        field(5; "New Entitlement"; Decimal)
        {
            Caption = 'New Entitlement';

            trigger OnValidate()
            begin
                if "New Entitlement" <> 0 then
                    Validate("Leave Adj Entry Type");
            end;
        }
        field(6; "Employee Name"; Text[150])
        {
            Caption = 'Employee Name';
        }
        field(7; "Leave Code"; Code[50])
        {
            TableRelation = "Leave Type".Code;
            Caption = 'Leave Type';

            trigger OnValidate()
            begin
                LeaveLedger.Reset();
                LeaveLedger.SetRange(LeaveLedger."Staff No.", "Staff No.");
                LeaveLedger.SetRange(LeaveLedger."Leave Type", "Leave Code");
                LeaveLedger.SetRange(LeaveLedger."Leave Period Code", "Leave Period");
                if LeaveLedger.Find('-') then begin
                    LeaveLedger.CalcSums("No. of days", "Balance Brought Forward");
                    CurrentEntitlement := LeaveLedger."No. of days";
                    CurrentBalFoward := LeaveLedger."Balance Brought Forward";
                end;


                AccPeriod.Reset();
                AccPeriod.SetRange(AccPeriod."Starting Date", 0D, Today);
                AccPeriod.SetRange(AccPeriod."New Fiscal Year", true);
                if AccPeriod.Find('+') then
                    MaturityDate := CalcDate('1Y', AccPeriod."Starting Date") - 1;

                "Maturity Date" := MaturityDate;
            end;
        }
        field(8; CurrentEntitlement; Decimal)
        {
            Caption = 'Current Entitlement';
        }
        field(9; CurrentBalFoward; Decimal)
        {
            Caption = 'Current Balance Brought Foward';
        }
        field(10; "Employment Type"; Enum "Employment Type")
        {
            CalcFormula = lookup(Employee."Employment Type" where("No." = field("Staff No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Employment Type';
        }
        field(11; "Leave Period"; Code[20])
        {
            TableRelation = "Leave Period" where(closed = const(false));
            Caption = 'Leave Period';
        }
        field(12; "Leave Adj Entry Type"; Option)
        {
            OptionCaption = 'Positive,Negative';
            OptionMembers = Positive,Negative;
            Caption = 'Leave Adj Entry Type';

            trigger OnValidate()
            begin
                if "Leave Adj Entry Type" = "Leave Adj Entry Type"::Negative then
                    "New Entitlement" := -"New Entitlement"
                else
                    "New Entitlement" := "New Entitlement";
            end;
        }
        field(13; "Transaction Type"; Enum "Leave Transaction Type")
        {
            Caption = 'Transaction Type';

            trigger OnValidate()
            begin
                case "Transaction Type" of
                    "Transaction Type"::Absent,
                "Transaction Type"::"Leave Application":
                        "Leave Adj Entry Type" := "Leave Adj Entry Type"::Negative;
                    "Transaction Type"::"Leave Adjustment",
                "Transaction Type"::"Leave Allocation",
                "Transaction Type"::"Leave B/F",
                "Transaction Type"::"Leave Recall":
                        "Leave Adj Entry Type" := "Leave Adj Entry Type"::Positive;
                    else
                        "Leave Adj Entry Type" := "Leave Adj Entry Type"::Negative;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Header No.", "Staff No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        AccPeriod: Record "Accounting Period";
        Employees: Record Employee;
        LeaveLedger: Record "HR Leave Ledger Entries Lv";
        LeavePeriods: Record "Leave Period";
        MaturityDate: Date;

    trigger OnInsert()
    begin
        LeavePeriods.SetRange(Closed, false);
        if LeavePeriods.FindFirst() then
            "Leave Period" := LeavePeriods."Leave Period Code";
    end;
}





