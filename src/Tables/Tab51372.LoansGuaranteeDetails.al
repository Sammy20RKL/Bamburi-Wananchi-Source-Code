#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51372 "Loans Guarantee Details"
{
    DrillDownPageID = "Loans Guarantee Details";
    LookupPageID = "Loans Guarantee Details";

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; "Member No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Customer."No." where(Status = filter(Active | "Re-instated"));

            trigger OnValidate()
            var
                RefDate: Date;
            begin
                GenSetUp.Get();
                if Cust.Get("Member No") then begin
                    if Cust."Registration Date" <> 0D then
                        RefDate := CalcDate('<' + GenSetUp."Share Capital Period" + '>', Cust."Registration Date");
                    if RefDate > Today then begin
                        Error('Member has not finished 6 Months in the sacco and therefore cannot guarantee any loan!');
                    end;
                end;

                Cust.SetRange(Cust."No.", "Member No");
                if Cust.FindSet then begin
                    if Cust.Status <> Cust.Status::Active then begin
                        Error('Only Active Members can guarantee Loans');
                    end;
                end;

                MemberCust.Reset;
                MemberCust.SetRange(MemberCust."No.", "Member No");
                if MemberCust.Find('-') then begin
                    if MemberCust.Status = MemberCust.Status::Defaulter then
                        Error('THE MEMBER  IS  A  DEFAULTER');
                end;


                LnGuarantor.Reset;
                LnGuarantor.SetRange(LnGuarantor."Loan  No.", "Loan No");
                if LnGuarantor.Find('-') then begin
                    if LnGuarantor."Client Code" = "Member No" then begin

                        "Self Guarantee" := true;
                        Self := true;
                        //MODIFY;
                    end;
                end;
                LoanGuarantors.SetRange(LoanGuarantors."Self Guarantee", true);
                LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No");
                SelfGuaranteedA := 0;
                Date := Date;

                MemberCust.Reset;
                MemberCust.SetRange(MemberCust."No.", "Member No");
                if MemberCust.Find('-') then begin
                    MemberCust.CalcFields(MemberCust.TLoansGuaranteed, MemberCust."Current Savings", MemberCust.TLoansGuaranteedS);
                    "Shares *3" := (MemberCust."Current Savings");
                    "TotalLoan Guaranteed" := MemberCust.TLoansGuaranteed;
                end;

                if Cust.Get("Member No") then begin
                    Cust.CalcFields(Cust."Outstanding Balance", Cust."Current Shares", Cust.TLoansGuaranteed);
                    Name := Cust.Name;
                    "Staff/Payroll No." := Cust."Personal No";
                    // "Employer Code"
                    "Loan Balance" := Cust."Outstanding Balance";
                    Shares := Cust."Current Shares" * 1;
                    Amont := 0;

                    //***********************************************************************************************
                    "Free Shares" := 0;
                    if "Self Guarantee" = true then begin
                        //Amont := SwizzsoftFactory.FnGetMemberSelfLiability("Member No");
                        Amont := SwizzsoftFactory.FnGetMemberLiability("Member No");
                        "TotalLoan Guaranteed" := Cust.TLoansGuaranteedS + Cust.TLoansGuaranteed;
                        "Free Shares" := (Shares) - "TotalLoan Guaranteed";
                        // MESSAGE('Sharesis %1',Shares);

                        //MESSAGE('"Free Shares"is %1....| amont is %2  ',"Free Shares",Amont);

                        // MESSAGE('"Free Shares"is %1',"Free Shares");

                    end else begin
                        if "Self Guarantee" = false then
                            ;//Message('Member Deposits is %1', Shares);
                        Amont := Shares * 1 - SwizzsoftFactory.FnGetMemberLiability("Member No");

                        "TotalLoan Guaranteed" := Cust.TLoansGuaranteed + Cust.TLoansGuaranteedS;

                        "Free Shares" := (Shares * 1) - "TotalLoan Guaranteed";
                    end;
                    "Amont Guaranteed" := "Amont Guaranteed";

                end;

                if "Shares *3" < 1 then
                    Error('Member Must have Deposits');


            end;
        }
        field(3; Name; Text[200])
        {
            Editable = false;
        }
        field(4; "Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(5; Shares; Decimal)
        {
            Editable = false;
        }
        field(6; "No Of Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("Member No"),
                                                                 "Outstanding Balance" = filter(> 1)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Substituted; Boolean)
        {
            trigger OnValidate()
            begin
                TestField("Substituted Guarantor");
            end;
        }
        field(8; Date; Date)
        {
        }
        field(9; "Shares Recovery"; Boolean)
        {
        }
        field(10; "New Upload"; Boolean)
        {
        }
        field(11; "Amont Guaranteed"; Decimal)
        {

            trigger OnValidate()
            var
                guarantorManagement: Codeunit "Guarantor Management";
                memberMaximumAbility: Decimal;
                memberSelfAbility: Decimal;
                memberPerLoanAbility: Decimal;
                offsetSelfGuaranteeAmt: Decimal;
            begin
                memberMaximumAbility := 0;
                memberSelfAbility := 0;
                memberPerLoanAbility := 0;
                offsetSelfGuaranteeAmt := 0;

                //*************************************************************************
                ///Festus - swizzsoft
                /// 1. Calculate members Guarantor Ability 2 times their Shares, minus what they have guaranteed in total
                memberMaximumAbility := guarantorManagement.fnGetMemberGuarantorshipLiability("Member No");

                if memberMaximumAbility < 0 then begin
                    Error('This member cannot Guarantee any Loan');
                end;
                if memberMaximumAbility < "Amont Guaranteed" then begin
                    Error('Maximum the member can Guarantee is ' + Format(memberMaximumAbility));
                end;
                //*************************************************************************
                /// 2. get Members self Ability - 25% of their worth, less what they have already self guaranteed them selves
                if "Self Guarantee" then begin

                    memberSelfAbility := guarantorManagement.fnGetMemberSelfGuarantorshipLiability("Member No");

                    //Confirm if its offset...
                    // ---------- EXTRA LOGIC FOR TOP-UP ----------Festus
                    // Check if this loan is a Top-Up
                    Loans.Reset();
                    Loans.SetRange("Loan  No.", "Loan No");
                    if Loans.Find('-') then begin
                        if Loans."Is Top Up" = true then begin
                            // Get the loan(s) being offset
                            LoanOffsets.Reset();
                            LoanOffsets.SetRange("Loan No.", "Loan No"); // current loan
                            if LoanOffsets.FindSet() then
                                repeat
                                    // For each offset loan, check if this member self-guaranteed it
                                    LoanGuarantors.Reset();
                                    LoanGuarantors.SetRange("Loan No", LoanOffsets."Loan Top Up");// "Loan No.");
                                    LoanGuarantors.SetRange("Member No", "Member No");
                                    LoanGuarantors.SetRange("Self Guarantee", true);
                                    if LoanGuarantors.FindFirst() then
                                        offsetSelfGuaranteeAmt += LoanGuarantors."Committed Shares";
                                until LoanOffsets.Next() = 0;
                        end;
                    end;

                    // Add any offset self-guarantee amount back to their ability
                    memberSelfAbility += offsetSelfGuaranteeAmt;

                    if memberSelfAbility < 0 then begin
                        Error('This member cannot self-Guarantee any Loan');
                    end;
                    if memberSelfAbility < "Amont Guaranteed" then begin
                        Error('Maximum the member can self-Guarantee is ' + Format(memberSelfAbility));
                    end;
                end;
                //*************************************************************************
                /// 3. Get the max they can guarantee 25% of their worth,.... member cannot guarantee the same loan more than 25% of their worth
                memberPerLoanAbility := guarantorManagement.fnGetMemberGuarantorshipLiabilityperLoan("Member No", Rec."Loan No");
                if memberPerLoanAbility < 0 then begin
                    Error('This member cannot Guarantee this Loan');
                end;
                if memberPerLoanAbility < "Amont Guaranteed" then begin
                    Error('Maximum the member can Guarantee this loan is KES' + Format(memberPerLoanAbility));
                end;
                //*************************************************************************
                "Committed Shares" := "Amont Guaranteed";
                "Original Amount" := "Amont Guaranteed";
                Date := Today;
            end;
        }
        field(12; "Staff/Payroll No."; Code[20])
        {

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."Personal No", "Staff/Payroll No.");
                if Cust.Find('-') then begin
                    "Member No" := Cust."No.";
                    Validate("Member No");
                end
                else
                    "Member No" := '';//ERROR('Record not found.')
            end;
        }
        field(13; "Account No."; Code[20])
        {
        }
        field(14; "Self Guarantee"; Boolean)
        {
        }
        field(15; "ID No."; Code[70])
        {
        }
        field(16; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  Reversed = const(false),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(41; "Transferable shares"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Total Loans Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Original Amount" where("Loan No" = field("Loan No"),
                                                                                 Substituted = const(false)));
            FieldClass = FlowField;
        }
        field(18; "Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /*"Total Loans Guaranteed":="Outstanding Balance";
                MODIFY;
                */

            end;
        }
        field(19; "Guarantor Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Member No"),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment")));
            FieldClass = FlowField;
        }
        field(20; "Employer Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(21; "Employer Name"; Text[100])
        {
        }
        field(22; "Substituted Guarantor"; Code[80])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                GenSetUp.Get();
                if LoansG > GenSetUp."Maximum No of Guarantees" then begin
                    Error('Member has guaranteed more than maximum active loans and  can not Guarantee any other Loans');
                    "Member No" := '';
                    "Staff/Payroll No." := '';
                    Name := '';
                    "Loan Balance" := 0;
                    Date := 0D;
                    exit;
                end;


                Loans.Reset;
                Loans.SetRange(Loans."Client Code", "Member No");
                if Loans.Find('-') then begin
                    if LoanGuarantors."Self Guarantee" = true then
                        Error('This Member has Self Guaranteed and Can not Guarantee another Loan');
                end;
            end;
        }
        field(23; "Loanees  No"; Code[30])
        {
            CalcFormula = lookup("Loans Register"."Client Code" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(24; "Loanees  Name"; Text[80])
        {
            CalcFormula = lookup("Loans Register"."Client Name" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(25; "Loan Product"; Code[20])
        {
            CalcFormula = lookup("Loans Register"."Loan Product Type" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(26; "Entry No."; Integer)
        {
        }
        field(27; "Loan Application Date"; Date)
        {
            CalcFormula = lookup("Loans Register"."Application Date" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(28; "Free Shares"; Decimal)
        {
        }
        field(29; "Line No"; Integer)
        {
        }
        field(30; "Member Cell"; Code[10])
        {
        }
        field(31; "Share capital"; Decimal)
        {
        }
        field(32; "TotalLoan Guaranteed"; Decimal)
        {
        }
        field(33; Totals; Decimal)
        {
        }
        field(34; "Shares *3"; Decimal)
        {
        }
        field(35; "Deposits variance"; Decimal)
        {
        }
        field(36; "Defaulter Loan Installments"; Code[10])
        {
        }
        field(37; "Defaulter Loan Repayment"; Decimal)
        {
        }
        field(38; "Exempt Defaulter Loan"; Boolean)
        {
        }
        field(39; "Additional Defaulter Amount"; Decimal)
        {
        }
        field(40; "Total Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Loan Balance" where("Loan No" = field("Loan No"),
                                                                              Substituted = filter(false)));
            Description = '//>Sum total guaranteed amount for each loan';
            FieldClass = FlowField;
        }
        field(69161; "Total Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("Member No")));
            FieldClass = FlowField;
        }
        field(69162; "Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Member No"),
                                                                  "Transaction Type" = filter("Interest Paid"),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(69163; "Guar Sub Doc No."; Code[20])
        {
        }
        field(69164; "Committed Shares"; Decimal)
        {
        }
        field(69165; "Substituted Guarantor Name"; Text[30])
        {
        }
        field(69166; "Member Liability"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69167; "Original Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //  CALCFIELDS("Outstanding Balance","Total Loans Guaranteed");
                //  IF "Total Loans Guaranteed">0 THEN
                //  "Amont Guaranteed":=ROUND((("Original Amount"/"Total Loans Guaranteed")*("Outstanding Balance")),1,'=');
                //  MODIFY();
            end;
        }
        field(69168; LoanCount; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Loanees  No" = field("Loanees  No"),
                                                                 "Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(69169; "Application Statu"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69170; "free Share"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //"free Share" := Amont;
            end;
        }
        field(69171; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }


        field(504; "Loan Outstanding Balance"; Decimal)
        {
            Caption = 'Loan Outstanding Balance';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 20;
        }
    }

    keys
    {
        key(Key1; "Loan No", "Staff/Payroll No.", "Member No", "Entry No.")
        {
        }
        key(Key2; "Loan No", "Member No")
        {
            Clustered = true;
            SumIndexFields = Shares;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Application Statu" := true;
    end;

    var
        AvailableSH: Decimal;
        MemberNo: Text;
        MemberName: Text;
        EmployerCode: Text;
        TotalOutstandingBal: Decimal;
        OutStandingBal: Decimal;
        FNo: Integer;
        // AmountGuar: Decimal;
        OutstandingBAlSt: Decimal;
        Company: Record "Company Information";
        CommittedShares: Decimal;
        ObjLoanGuar: Record "Loans Guarantee Details";
        ApprovedAmt: Decimal;
        LoanProductName: Text[50];
        Loantypes: Record "Loan Products Setup";
        AmountGuarT: Decimal;
        MDeposit: Decimal;
        MAmounttoG: Decimal;
        MLoanReg: Record "Loans Register";
        Cust: Record Customer;
        LoanGuarantors: Record "Loans Guarantee Details";
        Loans: Record "Loans Register";
        LoanOffsets: Record "Loan Offset Details";
        LoansR: Record "Loans Register";
        LoansG: Integer;
        GenSetUp: Record "Sacco General Set-Up";
        SelfGuaranteedA: Decimal;
        StatusPermissions: Record "Status Change Permision";
        Employer: Record "Sacco Employers";
        loanG: Record "Loans Guarantee Details";
        CustomerRecord: Record Customer;
        MemberSaccoAge: Date;
        ComittedShares: Decimal;
        LoanApp: Record "Loans Register";
        DefaultInfo: Text;
        ok: Boolean;
        SharesVariance: Decimal;
        MemberCust: Record Customer;
        LnGuarantor: Record "Loans Register";
        LoanApps: Record "Loans Register";
        Text0001: label 'This Member has an Outstanding Defaulter Loan which has never been serviced';
        freeshares: Decimal;
        loanrec: Record "Loans Guarantee Details";
        ObjWithApp: Record "Membership Exit";
        SwizzsoftFactory: Codeunit "Swizzsoft Factory.";
        Self: Boolean;
        SelfGuaranteeAmount: Decimal;
        Amont: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        AmountGuar: Decimal;
        vardiff: Decimal;
        MemberLiability: Decimal;

    local procedure UPDATEG()
    begin
    end;

}

