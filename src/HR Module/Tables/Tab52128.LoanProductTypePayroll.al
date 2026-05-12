table 52128 "Loan Product Type-Payroll"
{
    DataClassification = CustomerContent;
    Caption = 'Loan Product Type-Payroll';
    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(3; "Interest Rate"; Decimal)
        {
            Caption = 'Interest Rate (Annual)';
            DecimalPlaces = 2 : 10;
        }
        field(4; "Interest Calculation Method"; Enum PayrollLoanInterestCalMethod)
        {
            Caption = 'Interest Calculation Method';
        }
        field(5; "No Series"; Code[10])
        {
            Caption = 'No Series';
        }
        field(6; "No of Instalment"; Integer)
        {
            Caption = 'No of Instalment';
        }
        field(7; "Loan No Series"; Code[10])
        {
            TableRelation = "No. Series".Code;
            Caption = 'Loan No Series';
        }
        field(8; Rounding; Option)
        {
            OptionCaption = 'Nearest,Down,Up';
            OptionMembers = Nearest,Down,Up;
            Caption = 'Rounding';
        }
        field(28; "Rounding Precision"; Decimal)
        {
            MaxValue = 1;
            MinValue = 0.01;
            Caption = 'Rounding Precision';
        }
        field(29; "Loan Category"; Option)
        {
            OptionMembers = " ",Advance,"Bisco Loan","Other Loan";
            Caption = 'Loan Category';
        }
        field(30; "Calculate Interest"; Boolean)
        {
            Caption = 'Calculate Interest';
        }
        field(31; "Interest Deduction Code"; Code[20])
        {
            TableRelation = Deductions;
            Caption = 'Interest Deduction Code';
        }
        field(32; "Deduction Code"; Code[50])
        {
            TableRelation = Deductions;
            Caption = 'Deduction Code';
        }
        field(33; Internal; Boolean)
        {
            Caption = 'Internal';
        }
        field(34; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
            Caption = 'Pay Period Filter';
        }
        field(35; "Interest Receivable Account"; Code[50])
        {
            TableRelation = "G/L Account";
            Caption = 'Interest Receivable Account';
        }
        field(36; TPS; Boolean)
        {
            Caption = 'TPS';
        }
        field(37; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Monthly,Quaterly,Semi-Annually,Annually,Biennial';
            OptionMembers = Monthly,Quaterly,"Semi-Annually",Annually,Biennial;
            Caption = 'Repayment Frequency';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Loan Category")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if not TPS then begin
            HRsetup.Get();
            HRsetup.TestField("Loan Product Type Nos.");
            //NoSeriesMgt.InitSeries(HRsetup."Loan Product Type Nos.", xRec."No Series", 0D, Code, "No Series");
        end;
    end;

    var
        HRsetup: Record "Human Resources Setup";
    //NoSeriesMgt: Codeunit NoSeriesManagement;
}





