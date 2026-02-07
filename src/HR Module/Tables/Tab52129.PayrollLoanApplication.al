table 52129 "Payroll Loan Application"
{
    DataClassification = CustomerContent;
    Caption = 'Payroll Loan Application';
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            Caption = 'Loan No';

            trigger OnValidate()
            begin
                if "Loan No" <> xRec."Loan No" then begin
                    HRsetup.Get();
                    case "Transaction Type" of
                        "Transaction Type"::"Loan Application":
                            begin
                                // NoSeriesMgt.TestManual(HRsetup."Loan App No");
                                "No Series" := '';
                            end;
                        "Transaction Type"::"Loan Settlement":
                            ;
                    //NoSeriesMgt.TestManual(HRsetup."Secondary PAYE %");
                    end;
                end;
            end;
        }
        field(2; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
        field(3; "Loan Product Type"; Code[20])
        {
            TableRelation = "Loan Product Type-Payroll".Code;
            Caption = 'Loan Product Type';

            trigger OnValidate()
            begin

                if LoanType.Get("Loan Product Type") then begin
                    "Interest Deduction Code" := LoanType."Interest Deduction Code";
                    "Deduction Code" := CopyStr(LoanType."Deduction Code", 1, MaxStrLen("Deduction Code"));
                    Description := LoanType.Description;
                    "Interest Rate" := LoanType."Interest Rate";
                    "Interest Calculation Method" := LoanType."Interest Calculation Method";
                    Instalment := LoanType."No of Instalment";
                end;
            end;
        }
        field(4; "Amount Requested"; Decimal)
        {
            Caption = 'Amount Requested';

            trigger OnValidate()
            begin
                "Approved Amount" := "Amount Requested";
                Validate("Approved Amount");
            end;
        }
        field(5; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';

            trigger OnValidate()
            begin


                Installments := Instalment;
                if Installments <= 0 then
                    Error('Number of installments must be greater than Zero!');

                LoanType.Get("Loan Product Type");
                case LoanType.Rounding of
                    LoanType.Rounding::Up:
                        RoundingPrecision := '>';
                    LoanType.Rounding::Nearest:
                        RoundingPrecision := '=';
                    LoanType.Rounding::Down:
                        RoundingPrecision := '<';
                end;

                case "Interest Calculation Method" of
                    "Interest Calculation Method"::"No Interest":
                        Repayment := Round("Approved Amount" / Installments, LoanType."Rounding Precision", RoundingPrecision);

                    "Interest Calculation Method"::"Reducing Balance",
                        "Interest Calculation Method"::Amortised:
                        Repayment := Round(("Interest Rate" / 12 / 100) / (1 - Power((1 + ("Interest Rate" / 12 / 100)),
                                  -Instalment)) * "Approved Amount", LoanType."Rounding Precision", RoundingPrecision);

                    //Sacco Loan Reducing balance
                    //Principal Repayment is calculated as straight line
                    //Monthly Interest is based on the balance
                    //Monthly Repayment is based on the principal repayment + monthly interest
                    "Interest Calculation Method"::"Sacco Reducing Balance":
                        Repayment := Round("Approved Amount" / Installments, LoanType."Rounding Precision", RoundingPrecision);

                    "Interest Calculation Method"::"Flat Rate":
                        begin
                            Repayment := Round(("Approved Amount" / Installments) + FlatRateCalc("Approved Amount", InterestDec), LoanType."Rounding Precision",
                                                                       RoundingPrecision);
                            "Flat Rate Interest" := Round(FlatRateCalc("Approved Amount", "Interest Rate"), LoanType."Rounding Precision", RoundingPrecision);
                            "Flat Rate Principal" := Repayment;
                        end;
                end;

                "Approved Amount" := Abs("Approved Amount");
            end;
        }
        field(6; "Loan Status"; Option)
        {
            OptionCaption = 'Application,Being Processed,Rejected,Approved,Issued,Being Repaid,Repaid';
            OptionMembers = Application,"Being Processed",Rejected,Approved,Issued,"Being Repaid",Repaid;
            Caption = 'Loan Status';
        }
        field(7; "Issued Date"; Date)
        {
            TableRelation = if ("Employee Type" = filter(Parmanent | Partime | Locum),
                                "Loan Customer Type" = const(Staff)) "Payroll Period"
            // else
            // if ("Employee Type" = const(Casual),
            //                              "Loan Customer Type" = const(Staff)) "Payroll Period Casuals"
            else
            if ("Loan Customer Type" = const("External Customer")) "Accounting Period";
            Caption = 'Issued Date';
        }
        field(8; Instalment; Integer)
        {
            Caption = 'Instalment';

            trigger OnValidate()
            begin
                if "Approved Amount" <> 0 then
                    Validate("Approved Amount");
            end;
        }
        field(9; Repayment; Decimal)
        {
            Caption = 'Repayment';
        }
        field(10; "Flat Rate Principal"; Decimal)
        {
            Caption = 'Flat Rate Principal';
        }
        field(11; "Flat Rate Interest"; Decimal)
        {
            Caption = 'Flat Rate Interest';
        }
        field(12; "Interest Rate"; Decimal)
        {
            Caption = 'Interest Rate';
        }
        field(13; "No Series"; Code[10])
        {
            Caption = 'No Series';
        }
        field(14; "Interest Calculation Method"; Enum PayrollLoanInterestCalMethod)
        {
            Caption = 'Interest Calculation Method';

            trigger OnValidate()
            begin
                if "Approved Amount" <> 0 then
                    Validate("Approved Amount");
            end;
        }
        field(15; "Employee No"; Code[20])
        {
            TableRelation = if ("Loan Customer Type" = const(Staff)) Employee."No."
            else
            if ("Loan Customer Type" = const("External Customer")) Customer."No." where("Customer Posting Group" = const('SLOANS'));
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                case "Loan Customer Type" of
                    "Loan Customer Type"::Staff:

                        if EmpRec.Get("Employee No") then begin
                            "Employee Name" := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                            "Payroll Group" := EmpRec."Posting Group";
                            "Employee Type" := EmpRec."Employee Type";
                            EmpRec.TestField("Salary Advance Debtors");
                            "Debtors Code" := EmpRec."Salary Advance Debtors";
                        end;
                    "Loan Customer Type"::"External Customer":

                        if Customer.Get("Employee No") then
                            "Employee Name" := Customer.Name;
                end;

            end;
        }
        field(16; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(17; "Payroll Group"; Code[20])
        {
            // TableRelation = "Employee HR Posting Group".Code;
            Caption = 'Payroll Group';
        }
        field(18; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(19; "Opening Loan"; Boolean)
        {
            Editable = true;
            Caption = 'Opening Loan';
        }
        field(20; "Total Repayment"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("Employee No"),
                                                                  //   Type = const(Deduction),
                                                                  Code = field("Deduction Code"),
                                                                  "Payroll Period" = field(upperlimit("Date filter")),
                                                                  "Reference No" = field("Loan No")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Repayment';
        }
        field(21; "Date filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date filter';
        }
        field(22; "Period Repayment"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("Employee No"),
                                                                  Type = const(Deduction),
                                                                  Code = field("Deduction Code"),
                                                                  "Payroll Period" = field(upperlimit("Date filter")),
                                                                  "Reference No" = field("Loan No")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Period Repayment';
        }
        field(23; Interest; Decimal)
        {
            Caption = 'Interest';
        }
        field(24; "Interest Imported"; Decimal)
        {
            Caption = 'Interest Imported';
        }
        field(25; "principal imported"; Decimal)
        {
            Caption = 'principal imported';
        }
        field(26; "Interest Rate Per"; Option)
        {
            OptionMembers = " ",Annum,Monthly;
            Caption = 'Interest Rate Per';
        }
        field(27; "Reference No"; Code[50])
        {
            Caption = 'Reference No';
        }
        field(28; "Interest Deduction Code"; Code[20])
        {
            TableRelation = Deductions;
            Caption = 'Interest Deduction Code';
        }
        field(29; "Deduction Code"; Code[20])
        {
            TableRelation = Deductions;
            Caption = 'Deduction Code';
        }
        field(30; "Debtors Code"; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Debtors Code';
        }
        field(31; "Interest Amount"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("Employee No"),
                                                                  //   Type = const(Deduction),
                                                                  Code = field("Interest Deduction Code"),
                                                                  "Payroll Period" = field(upperlimit("Date filter")),
                                                                  "Reference No" = field("Loan No")));
            FieldClass = FlowField;
            Caption = 'Interest Amount';
        }
        field(32; "External Document No"; Code[20])
        {
            Caption = 'External Document No';
        }
        field(33; Receipts; Decimal)
        {
            // CalcFormula = sum("Non Payroll Receipts".Amount where("Loan No" = field("Loan No"),
            //                                                        "Receipt Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Receipts';
        }
        field(34; "HELB No."; Code[50])
        {
            Caption = 'HELB No.';
        }
        field(35; "University Name"; Code[100])
        {
            Caption = 'University Name';
        }
        field(36; "Stop Loan"; Boolean)
        {
            Caption = 'Stop Loan';
        }
        field(37; "Interest Repaid"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."Loan Interest" where("Employee No" = field("Employee No"),
                                                                           //    Type = const(Deduction),
                                                                           Code = field("Deduction Code"),
                                                                           "Payroll Period" = field(upperlimit("Date filter")),
                                                                           "Reference No" = field("Loan No")));
            FieldClass = FlowField;
            Caption = 'Interest Repaid';
        }
        field(38; "Employee Type"; Option)
        {
            OptionCaption = 'Parmanent,Partime,Locum,Casual';
            OptionMembers = Parmanent,Partime,Locum,Casual;
            Caption = 'Employee Type';
        }
        field(39; "Paying Bank"; Code[30])
        {
            TableRelation = "Bank Account";
            Caption = 'Paying Bank';

            trigger OnValidate()
            begin
                if Banks.Get("Paying Bank") then
                    "Bank Name" := Banks.Name;
            end;
        }
        field(40; "Bank Name"; Text[100])
        {
            FieldClass = Normal;
            Caption = 'Bank Name';
        }
        field(41; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
        }
        field(42; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(43; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(44; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
        }
        field(45; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(46; "Last Interest Date"; Date)
        {
            Caption = 'Last Interest Date';
        }
        field(47; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Monthly,Quaterly,Semi-Annually,Annually,Biennial';
            OptionMembers = Monthly,Quaterly,"Semi-Annually",Annually,Biennial;
            Caption = 'Repayment Frequency';
        }
        field(48; Rescheduled; Boolean)
        {
            Caption = 'Rescheduled';
        }
        field(49; "Rescheduled By"; Code[50])
        {
            Caption = 'Rescheduled By';
        }
        field(50; "Date Rescheduled"; DateTime)
        {
            Caption = 'Date Rescheduled';
        }
        field(51; "Reschedule Balance"; Decimal)
        {
            Caption = 'Reschedule Balance';
        }
        field(52; "Loan Reschedule Date"; Date)
        {
            Caption = 'Loan Reschedule Date';
        }
        field(53; "Suggested Repayment Amount"; Decimal)
        {
            Caption = 'Suggested Repayment Amount';

            trigger OnValidate()
            begin
                Suggested := false;
                if "Suggest Repayment Amount" then
                    if "Suggested Repayment Amount" <> 0 then
                        "Suggested Installments" := Round(("Amount Requested" / "Suggested Repayment Amount"), 1, '>')
                    else
                        "Suggested Installments" := 0;
            end;
        }
        field(54; "Suggested Installments"; Integer)
        {
            Caption = 'Suggested Installments';

            trigger OnValidate()
            begin
                Suggested := false;
            end;
        }
        field(55; "Suggest Repayment Amount"; Boolean)
        {
            Caption = 'Suggest Repayment Amount';

            trigger OnValidate()
            begin
                Suggested := false;
            end;
        }
        field(56; Suggested; Boolean)
        {
            Caption = 'Suggested';
        }
        field(57; "Reschedule Amount Suggested"; Boolean)
        {
            Caption = 'Reschedule Amount Suggested';
        }
        field(58; "Resch Suggested Instalments"; Integer)
        {
            Caption = 'Resch Suggested Instalments';
        }
        field(59; "Resch Suggested Amount"; Decimal)
        {
            Caption = 'Resch Suggested Amount';
        }
        field(60; "Suggest Reschedule Amount"; Boolean)
        {
            Caption = 'Suggest Reschedule Amount';
        }
        field(61; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Loan Application,Loan Settlement';
            OptionMembers = " ","Loan Application","Loan Settlement";
            Caption = 'Transaction Type';
        }
        field(62; "Loan Balance"; Decimal)
        {
            // CalcFormula = sum("Loan Ledger Entry-Payroll".Amount where("Loan No." = field("Loan No")));
            FieldClass = FlowField;
            Caption = 'Loan Balance';
        }
        field(63; "Loan Repayments"; Decimal)
        {
            // CalcFormula = - sum("Loan Ledger Entry-Payroll".Amount where("Loan No." = field("Loan No"), "Transaction Type" = filter("Principal Repayment" | Settlement)));
            FieldClass = FlowField;
            Caption = 'Loan Repayments';
        }
        field(64; "Settlement Type"; Option)
        {
            OptionCaption = ' ,Partial Settlement,Full Settlement';
            OptionMembers = " ","Partial Settlement","Full Settlement";
            Caption = 'Settlement Type';

            trigger OnValidate()
            begin
                Validate("Loan Application No.");
            end;
        }
        field(65; "Loan Application No."; Code[30])
        {
            TableRelation = "Payroll Loan Application" where("Transaction Type" = filter("Loan Application"),
                                                      "Employee No" = field("Employee No"));
            Caption = 'Loan Application No.';

            trigger OnValidate()
            begin

                if LoanApp.Get("Loan Application No.") then
                    case "Transaction Type" of
                        "Transaction Type"::"Loan Settlement":
                            begin
                                LoanApp.CalcFields("Loan Balance", "Loan Repayments", "Total Repayment", "Period Repayment");
                                "Approved Amount" := LoanApp."Approved Amount";
                                "Loan Balance" := LoanApp."Approved Amount" + LoanApp."Total Repayment";
                                "Loan Repayments" := LoanApp."Total Repayment";
                                case "Settlement Type" of
                                    "Settlement Type"::"Full Settlement":

                                        "Settlement Amount" := LoanApp."Approved Amount" - LoanApp."Total Repayment";
                                    "Settlement Type"::"Partial Settlement":
                                        ;

                                end;
                            end;
                    end;
            end;
        }
        field(66; "Settlement Amount"; Decimal)
        {
            Caption = 'Settlement Amount';
        }
        field(67; "Payment Method"; Option)
        {
            OptionCaption = 'G/L Account,Bank Account,Cash,Cheque,EFT,RTGS,MPESA,PDQ';
            OptionMembers = "G/L Account","Bank Account",Cash,Cheque,EFT,RTGS,MPESA,PDQ;
            Caption = 'Payment Method';
        }
        field(68; "Payment Refrence No."; Text[100])
        {
            Caption = 'Payment Refrence No.';
        }
        field(69; "Initial Instalments"; Integer)
        {
            Caption = 'Initial Instalments';
        }
        field(70; "Payment Ref No."; Code[100])
        {
            Caption = 'Payment Ref No.';
        }
        field(71; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(72; "Posted By"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup";
            Caption = 'Posted By';
        }
        field(73; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
        }
        field(74; Reversed; Boolean)
        {
            Caption = 'Reversed';
        }
        field(75; "Reversed By"; Code[50])
        {
            Caption = 'Reversed By';
        }
        field(76; "Date-Time Reversed"; DateTime)
        {
            Caption = 'Date-Time Reversed';
        }
        field(77; "Loan Customer Type"; Option)
        {
            OptionCaption = 'Staff,External Customer';
            OptionMembers = Staff,"External Customer";
            Caption = 'Loan Customer Type';
        }
        field(78; "Customer Code"; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Customer Code';

            trigger OnValidate()
            begin
                if Customer.Get("Customer Code") then
                    "Customer Name" := Customer.Name;
            end;
        }
        field(79; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(80; "Schedule Created"; Boolean)
        {
            Caption = 'Schedule Created';
        }
        field(81; "Next Invoice Date"; Date)
        {
            Caption = 'Next Invoice Date';
        }
    }

    keys
    {
        key(Key1; "Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        HRsetup.Get();

        if "Loan No" = '' then
            case "Transaction Type" of
                "Transaction Type"::"Loan Application":
                    begin
                        HRsetup.TestField("Loan App No");
                        // NoSeriesMgt.InitSeries(HRsetup."Loan App No", xRec."No Series", 0D, "Loan No", "No Series");
                        // InsertUserAccount();
                    end;
                "Transaction Type"::"Loan Settlement":

                    HRsetup.TestField("Secondary PAYE %");
            //NoSeriesMgt.InitSeries(HRsetup."Secondary PAYE %",xRec."No Series",TODAY,"Loan No","No Series");
            end;
        "User ID" := CopyStr(UserId, 1, MaxStrLen("User ID"));
        "Application Date" := Today;
    end;

    var
        Banks: Record "Bank Account";
        Customer: Record Customer;
        EmpRec: Record "HR Employees";
        HRsetup: Record "Human Resources Setup";
        LoanType: Record "Loan Product Type-Payroll";
        LoanApp: Record "Payroll Loan Application";
        // NewSchedule: Record "Payroll Repayment Schedule";
        DimMgt: Codeunit DimensionManagement;
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        CalcInterest: Boolean;
        RunningDate: Date;
        FlatPeriodInterest: Decimal;
        Installments: Decimal;
        InterestDec: Decimal;
        RemainingPrincipalAmountDec: Decimal;
        LineNoInt: Integer;
        NoUserAccErr: Label 'You do not have a user account. Please contact the system administrator.';
        RoundingPrecision: Text[30];



    procedure DebtService(Principal: Decimal; Interest: Decimal; PayPeriods: Integer): Decimal
    var
        PeriodInterest: Decimal;
    begin
        //PeriodInterval:=
        //EVALUATE(PeriodInterval,FORMAT("Instalment Period"));
        //1M
        //IF PeriodInterval='1M' THEN

        PeriodInterest := Interest / 12 / 100;

        exit(PeriodInterest / (1 - Power((1 + PeriodInterest), -PayPeriods)) * Principal);
        /*
         //1W
        if PeriodInterval='1W' then
         PeriodInterest:= Interest / 52 / 100;
         //2W
        if PeriodInterval='2W' then
         PeriodInterest:= Interest / 26 / 100;
         //1Q
        if PeriodInterval='1Q' then
         PeriodInterest:= Interest / 4 / 100;
        
        
        */

    end;

    procedure FlatRateCalc(var FlatLoanAmount: Decimal; var FlatInterestRate: Decimal) FlatRateCalc: Decimal
    begin
        //FlatPeriodInterval:=
        //EVALUATE(FlatPeriodInterval,FORMAT("Instalment Period"));
        //1M
        //IF FlatPeriodInterval='1M' THEN

        FlatPeriodInterest := FlatLoanAmount * FlatInterestRate / 100;
        FlatRateCalc := FlatPeriodInterest;

        /*
         //1W
        
        if FlatPeriodInterval='1W' then
         FlatPeriodInterest:= FlatLoanAmount*FlatInterestRate/100*1/52;
         //2W
        if FlatPeriodInterval='2W' then
         FlatPeriodInterest:= FlatLoanAmount*FlatInterestRate/100*1/26;
         //1Q
        if FlatPeriodInterval='1Q' then
         FlatPeriodInterest:= FlatLoanAmount*FlatInterestRate/100*1/4;
        */

    end;

    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Application Date", "Loan No");
        NavigateForm.Run();
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin

        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    local procedure InsertUserAccount()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            Error(NoUserAccErr)
        else begin
            UserSetup.TestField("Employee No.");
            "Employee No" := UserSetup."Employee No.";
            Validate("Employee No");
        end;
    end;
}





