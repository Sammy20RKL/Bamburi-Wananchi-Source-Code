table 52007 "Payroll Period"
{
    DataClassification = CustomerContent;
    Caption = 'Payroll Period';
    fields
    {
        field(1; "Starting Date"; Date)
        {
            NotBlank = true;
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                Name := Format("Starting Date", 0, '<Month Text>');
            end;
        }
        field(2; Name; Text[10])
        {
            Caption = 'Name';
        }
        field(3; "New Fiscal Year"; Boolean)
        {
            Caption = 'New Fiscal Year';

            trigger OnValidate()
            begin
                TestField("Date Locked", false);
            end;
        }
        field(4; Closed; Boolean)
        {
            Editable = true;
            Caption = 'Closed';
        }
        field(5; "Date Locked"; Boolean)
        {
            Editable = true;
            Caption = 'Date Locked';
        }
        field(50000; "Pay Date"; Date)
        {
            Caption = 'Pay Date';
        }
        field(50001; "Close Pay"; Boolean)
        {
            Editable = true;
            Caption = 'Close Pay';

            trigger OnValidate()
            begin
                TestField("Close Pay", false);
            end;
        }
        // field(50002; "P.A.Y.E"; Decimal)
        // {
        //     CalcFormula = sum("Assignment Matrix".Amount where("Payroll Period" = field("Starting Date"),
        //                                                           Paye = const(true),
        //                                                           "Employee Type" = filter(<> Trustee)));
        //     FieldClass = FlowField;
        //     Caption = 'P.A.Y.E';
        // }
        // field(50003; "Basic Pay"; Decimal)
        // {
        //     CalcFormula = sum("Assignment Matrix".Amount where("Payroll Period" = field("Starting Date"),
        //                                                           "Basic Salary Code" = const(true),
        //                                                           "Employee Type" = filter(<> Trustee)));
        //     FieldClass = FlowField;
        //     Caption = 'Basic Pay';
        // }
        field(50004; "Market Interest Rate %"; Decimal)
        {
            Caption = 'Market Interest Rate %';
        }
        field(50005; "CMS Starting Date"; Date)
        {
            Caption = 'CMS Starting Date';
        }
        field(50006; "CMS End Date"; Date)
        {
            Caption = 'CMS End Date';
        }
        field(50007; "Earnings Code Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            // TableRelation = Earnings;
            Caption = 'Earnings Code Filter';
        }
        field(50008; "Deductions Code Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //  TableRelation = Deductions;
            Caption = 'Deductions Code Filter';
        }
        field(50009; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
            Caption = 'Pay Period Filter';
        }
        field(50010; "Leave Payment Period"; Boolean)
        {
            Caption = 'Leave Payment Period';
        }
        field(50011; "Approval Status"; Enum "ApprovalStatus")
        {
            Caption = 'Approval Status';
            Editable = false;
        }
        field(50012; "Bank Charges"; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; "Starting Date")
        {
            Clustered = true;
        }
        key(Key2; "New Fiscal Year", "Date Locked")
        {
        }
        key(Key3; Closed)
        {
        }
    }

    fieldgroups
    {
    }
}





