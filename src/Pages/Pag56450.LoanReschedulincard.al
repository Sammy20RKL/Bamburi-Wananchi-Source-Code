#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56450 "Loan Reschedulin card"
{
    SourceTable = "Loan Rescheduling";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Previous Disbursement Date"; Rec."Previous Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Capture Date"; Rec."Capture Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RepayMethod; Rec.RepayMethod)
                {
                    ApplicationArea = Basic;
                }
                field("Principle Amount"; Rec."Principle Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                }
                field(Interests; Rec.Interests)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reschedule Date (Issue Date)';
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Completion Date"; Rec."Loan Completion Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Rescheduling)
            {
                action("Reschedule Loan")
                {
                    ApplicationArea = Basic;
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField("Loan Disbursement Date");
                        if Confirm('Are you sure you want to reschedule this loan', false) = true then begin
                            FnRescheduleLoan();
                            Message('Loan successfully Rescheduled.');
                            Rec.Rescheduled := true;
                            Rec."Rescheduled By" := UserId;
                            Rec."Posting Date" := Today;
                            Rec.Modify
                        end;
                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Rec.TestField("Loan Disbursement Date");
                        // FnGenerateSchedule();
                        // Loans.RESET;
                        // Loans.SETRANGE(Loans."Loan  No.","Loan No");
                        // IF Loans.FIND('-') THEN
                        //  REPORT.RUN(51516231,TRUE,FALSE,Loans);

                        SFactory.FnGenerateRepaymentSchedule(Rec."Loan No");


                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan No");
                        if LoanApp.Find('-') then
                            Report.Run(50477, true, false, LoanApp);
                    end;
                }
            }
        }
    }

    var
        Loans: Record "Loans Register";
        Reschedule: Record "Loan Rescheduling";
        Rschedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Integer;
        RepayPeriod: Integer;
        InitialInstal: Integer;
        InstalNo: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        LPrincipal: Decimal;
        LInterest: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[30];
        WhichDay: Integer;
        TotalMRepay: Decimal;
        SFactory: Codeunit "Swizzsoft Factory.";
        LoanApp: Record "Loans Register";

    local procedure FnRescheduleLoan()
    begin
        Loans.Reset;
        Loans.SetRange(Loans."Loan  No.", Rec."Loan No");
        if Loans.Find('-') then begin
            Loans."Approved Amount" := Rec."Outstanding Balance";
            Loans."Issued Date" := Rec."Loan Disbursement Date";
            Loans."Repayment Start Date" := Rec."Repayment Start Date";
            Loans."Expected Date of Completion" := Rec."Loan Completion Date";
            Loans.Installments := Rec.Installments;
            Loans.Interest := Rec.Interests;
            Loans."Loan Principle Repayment" := ROUND((Rec."Outstanding Balance" / Rec.Installments), 0.5, '=');
            Loans."Loan Interest Repayment" := ROUND((Rec.Interests * Rec."Outstanding Balance" / 100), 0.5, '=');
            Loans.Rescheduled := true;
            Loans."Reschedule by" := UpperCase(UserId);


            Loans.Modify;
        end;
    end;

    local procedure FnGenerateSchedule()
    begin
        //MESSAGE('repay date is %1',"Repayment Start Date");
        Reschedule.Reset;
        Reschedule.SetRange(Reschedule."No.", Rec."No.");
        Reschedule.SetFilter(Reschedule."Outstanding Balance", '>%1', 0);
        if Reschedule.Find('-') then begin
            if ((Reschedule."Capture Date" <> 0D) and (Reschedule."Repayment Start Date" <> 0D)) then begin
                Reschedule.TestField(Reschedule."Repayment Start Date");
                Reschedule.TestField(Reschedule."Capture Date");

                Rschedule.Reset;
                Rschedule.SetRange(Rschedule."Loan No.", Rec."Loan No");
                Rschedule.DeleteAll;


                LoanAmount := Rec."Outstanding Balance";
                InterestRate := Rec.Interests;
                RepayPeriod := Rec.Installments;
                InitialInstal := Rec.Installments;
                LBalance := Rec."Outstanding Balance";
                RunDate := Rec."Repayment Start Date";
                Message(Format(RunDate));
                InstalNo := 0;

                //Repayment Frequency
                if Reschedule."Repayment Frequency" = Reschedule."repayment frequency"::Monthly then

                    //Repayment Frequency


                    repeat
                        InstalNo := InstalNo + 1;
                        //Repayment Frequency
                        if Reschedule."Repayment Frequency" = Reschedule."repayment frequency"::Daily then
                            RunDate := CalcDate('1D', RunDate)
                        else if Reschedule."Repayment Frequency" = Reschedule."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else if Reschedule."Repayment Frequency" = Reschedule."repayment frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else if Reschedule."Repayment Frequency" = Reschedule."repayment frequency"::Quaterly then
                            RunDate := CalcDate('1Q', RunDate);




                        if InterestRate > 0 then begin
                            if Reschedule.RepayMethod = Reschedule.Repaymethod::Amortised then begin
                                Reschedule.TestField(Installments);
                                TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                                LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                                LPrincipal := TotalMRepay - LInterest;
                            end;

                            if Reschedule.RepayMethod = Reschedule.Repaymethod::"Straight Line" then begin
                                Reschedule.TestField(Interests);
                                Reschedule.TestField(Installments);
                                LPrincipal := LoanAmount / RepayPeriod;
                                ///LInterest:=(InterestRate/12/100)*LoanAmount/RepayPeriod;
                                LInterest := (InterestRate / 12 / 100) * LoanAmount;

                            end;

                            if Reschedule.RepayMethod = Reschedule.Repaymethod::"Reducing Balance" then begin
                                Reschedule.TestField(Interests);
                                Reschedule.TestField(Installments);
                                LPrincipal := LoanAmount / RepayPeriod;
                                LInterest := (InterestRate / 12 / 100) * LBalance;
                            end;
                        end;
                        //IF Reschedule.RepayMethod=Reschedule.RepayMethod::Constants THEN BEGIN
                        //Reschedule.TESTFIELD(r);
                        // IF LBalance < LoansRec.Repayment THEN
                        // LPrincipal:=LBalance
                        // ELSE
                        // LPrincipal:=LoansRec.Repayment;
                        // LInterest:=LoansRec.Interest;
                        // END;
                        // Reschedule.TESTFIELD(Reschedule.Interests);
                        // Reschedule.TESTFIELD(Reschedule.Installments);
                        //
                        // LPrincipal:=ROUND((LoanAmount/Reschedule.Installments),0.05,'>');
                        // LInterest:=(InterestRate/12/100)*LoanAmount/RepayPeriod;




                        //Grace Period
                        if GrPrinciple > 0 then begin
                            LPrincipal := 0
                        end else begin
                            LBalance := LBalance - LPrincipal;

                        end;

                        if GrInterest > 0 then
                            LInterest := 0;

                        GrPrinciple := GrPrinciple - 1;
                        GrInterest := GrInterest - 1;
                        Evaluate(RepayCode, Format(InstalNo));


                        Rschedule.Init;
                        Rschedule."Repayment Code" := RepayCode;
                        Rschedule."Interest Rate" := InterestRate;
                        Rschedule."Loan No." := Rec."Loan No";
                        Rschedule."Loan Amount" := LoanAmount;
                        Rschedule."Instalment No" := InstalNo;
                        Rschedule."Repayment Date" := CalcDate('CM', RunDate);
                        //MESSAGE('rundate is %1',RunDate);

                        Rschedule."Member No." := Rec."Member No";
                        Rschedule."Loan Category" := Rec."Loan Product Type";
                        Rschedule."Monthly Repayment" := LPrincipal + LInterest;

                        Rschedule."Monthly Interest" := LInterest;
                        Rschedule."Principal Repayment" := LPrincipal;
                        Rschedule."Remaining Debt" := LBalance;
                        Rschedule.Insert;
                        WhichDay := Date2dwy(Rschedule."Repayment Date", 1);
                    until LBalance < 1

            end;
        end;

        Commit;
    end;
}

