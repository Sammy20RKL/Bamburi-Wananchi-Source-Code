#pragma warning disable AA0005, AL0603, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50853 "Loan Application MICRO(Approv)"
{
    // 
    // {GSetUp.GET();
    // 
    // TESTFIELD("Account No");
    // 
    // //Check if a Member has withstanding withdrawal application
    // 
    // 
    // 
    // SalDetails.RESET;
    // SalDetails.SETRANGE(SalDetails."Loan No","Loan  No.");
    // IF SalDetails.FIND('-')=FALSE THEN BEGIN
    // ERROR('Please Insert Loan Appraisal Details Information');
    // END;
    // 
    // Prof.RESET;
    // Prof.SETRANGE(Prof."Loan No.","Loan  No.");
    // Prof.SETRANGE(Prof."Client Code","Client Code");
    // IF Prof.FIND('-')=FALSE THEN BEGIN
    // ERROR('Please Insert Profitability Information');
    // END;
    // 
    // //***Check Appraisal Details
    // AppExp.RESET;
    // AppExp.SETRANGE(AppExp.Loan,"Loan  No.");
    // AppExp.SETRANGE(AppExp."Client Code","Client Code");
    // IF  AppExp.FIND('-')=FALSE THEN BEGIN
    // ERROR('Please Insert Appraisal Expense Detail');
    // END;
    // 
    // 
    // 
    // IF LoanType.GET("Loan Product Type") THEN BEGIN
    // IF LoanType."Appraise Guarantors" = TRUE THEN BEGIN
    // LGuarantors.RESET;
    // LGuarantors.SETRANGE(LGuarantors."Loan No","Loan  No.");
    // IF LGuarantors.FIND('-')=FALSE THEN BEGIN
    // ERROR('Please Insert Loan Applicant Guarantor Information');
    // END;
    // END;
    // END;
    // 
    // LoanSecurities.RESET;
    // LoanSecurities.SETRANGE(LoanSecurities."Loan No","Loan  No.");
    // IF LoanSecurities.FIND('-')= FALSE THEN BEGIN
    // ERROR(Text002);
    // END;
    // 
    // TotalSecurities:=0;
    // LnSecurities.RESET;
    // LnSecurities.SETRANGE(LnSecurities."Loan No","Loan  No.");
    // IF LnSecurities.FIND('-') THEN BEGIN
    // REPEAT
    // TotalSecurities:=TotalSecurities;
    // UNTIL LnSecurities.NEXT=0;
    // END;
    // 
    // IF TotalSecurities < "Approved Amount" THEN
    // ERROR(Text003);
    // 
    // 
    // 
    // TESTFIELD("Approved Amount");
    // TESTFIELD("Loan Product Type");
    // 
    // IF "Mode of Disbursement"<> "Mode of Disbursement"::"Bank Transfer" THEN
    //  ERROR('Mode of disbursement must be Bank Transfer');
    // 
    // {
    // LBatches.RESET;
    // LBatches.SETRANGE(LBatches."Loan  No.","Loan  No.");
    // IF LBatches.FIND('-') THEN BEGIN
    // IF LBatches."Approval Status"<>LBatches."Approval Status"::Open THEN
    // ERROR(Text001);
    // END;
    // }
    // 
    // LoanG.RESET;
    // LoanG.SETRANGE(LoanG."Loan No","Loan  No.");
    // IF LoanG.FIND('-') THEN BEGIN
    // IF LoanG.COUNT < GSetUp."Max Loan Guarantors BLoans" THEN
    //  ERROR(Text006);
    // END;
    // 
    // //===== Tier control
    // {
    // LoanApps.RESET;
    // LoanApps.SETFILTER(LoanApps.Source,'%1',LoanApps.Source::MICRO);
    // LoanApps.SETRANGE(LoanApps."Loan  No.","Loan  No.");
    // IF LoanApps.FIND('-') THEN BEGIN
    // 
    //   LoanTopUp.RESET;
    //   LoanTopUp.SETRANGE(LoanTopUp."Loan No.",LoanApps."Loan  No.");
    //   IF LoanTopUp.FIND('-') THEN BEGIN
    //    REPEAT
    //     IF LoanApp.GET(LoanTopUp."Loan Top Up") THEN BEGIN
    //      IF LoanApps."Loan Product Type" <> LoanApp."Loan Product Type"  THEN
    //       ERROR(Text007);
    //     END;
    //    UNTIL LoanTopUp.NEXT=0;
    //   END;
    // 
    // END;
    // 
    //   LoanTopUp.RESET;
    //   LoanTopUp.SETRANGE(LoanTopUp."Loan No.","Loan  No.");
    //   IF LoanTopUp.FIND('-') THEN BEGIN
    //    REPEAT
    //     IF LoanApp.GET(LoanTopUp."Loan Top Up") THEN BEGIN
    //      IF LoanApps."Loan Product Type" <> LoanApp."Loan Product Type"  THEN
    //       ERROR(Text007);
    //     END;
    //    UNTIL LoanTopUp.NEXT=0;
    //   END;
    // }
    // //=====  Tier control
    // 
    // 
    // //ApprovalMgt.SendBLoanApprRequest(Rec);
    // //ApprovalMgt.SendLoanApprRequest(Rec);
    // }

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = 51371;
    SourceTableView = where(Source = const(MICRO),
                            Posted = const(false),
                            "Loan Status" = const(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member';
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        /*
                        Memb.RESET;
                        Memb.SETRANGE(Memb."No.","Client Code");
                        IF Memb."Customer Posting Group"<>'Micro' THEN
                        ERROR('This Member is NOT Registered under Business Loans');
                        */

                    end;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID NO"; Rec."ID NO")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Group"; Rec."Member Group")
                {
                    ApplicationArea = Basic;
                }
                field("Member Group Name"; Rec."Member Group Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = ApplcDateEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = LProdTypeEditable;
                }
                field("Group Shares"; Rec."Group Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Balance"; Rec."Shares Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Pension No"; Rec."Pension No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                    Editable = InstallmentEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Product Currency Code"; Rec."Product Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = true;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Recommended Amount"; Rec."Recommended Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifying Amount';
                    Enabled = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = ApprovedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Loan Purpose"; Rec."Loan Purpose")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        UpdateControl();

                        /*IF LoanType.GET('DISCOUNT') THEN BEGIN
                        IF (("Approved Amount")-("Special Loan Amount"+"Other Commitments Clearance"+SpecialComm))
                             < 0 THEN
                        ERROR('Bridging amount more than the loans applied/approved.');
                        
                        END;
                        
                        
                        IF "Loan Status" = "Loan Status"::Appraisal THEN BEGIN
                        StatusPermissions.RESET;
                        StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                        StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Bosa Loan Appraisal");
                        IF StatusPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permissions to Appraise this Loan.');
                        
                        END ELSE BEGIN
                        
                        IF "Loan Status" = "Loan Status"::Approved THEN BEGIN
                        StatusPermissions.RESET;
                        StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                        StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Bosa Loan Approval");
                        IF StatusPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permissions to Approve this Loan.');
                        
                        "Date Approved":=TODAY;
                        END;
                        END;
                        //END;
                        
                        
                        {
                        ccEmail:='';
                        
                        LoanG.RESET;
                        LoanG.SETRANGE(LoanG."Loan No","Loan  No.");
                        IF LoanG.FIND('-') THEN BEGIN
                        REPEAT
                        IF CustE.GET(LoanG."Member No") THEN BEGIN
                        IF CustE."E-Mail" <> '' THEN BEGIN
                        IF ccEmail = '' THEN
                        ccEmail:=CustE."E-Mail"
                        ELSE
                        ccEmail:=ccEmail + ';' + CustE."E-Mail";
                        END;
                        END;
                        UNTIL LoanG.NEXT = 0;
                        END;
                        
                        
                        
                        IF "Loan Status"="Loan Status"::Approved THEN BEGIN
                        CLEAR(Notification);
                        IF CustE.GET("Client Code") THEN BEGIN
                        Notification.NewMessage(CustE."E-Mail",ccEmail,'Loan Status',
                        'We are happy to inform you that your ' + "Loan Product Type" + ' loan application of ' + FORMAT("Requested Amount")
                         + ' has been approved.' + ' (Dynamics NAV ERP)','',FALSE);
                        END;
                        
                        
                        END ELSE IF "Loan Status"="Loan Status"::Appraisal THEN BEGIN
                        DocN:='';
                        DocM:='';
                        DocF:='';
                        DNar:='';
                        
                        IF "Copy of ID"= FALSE THEN BEGIN
                        DocN:='Please avail your ';
                        DocM:='Copy of ID.';
                        DocF:=' to facilitate further processing.'
                        END;
                        
                        IF Contract= FALSE THEN BEGIN
                        DocN:='Please avail your ';
                        DocM:=DocM + ' Contract.';
                        DocF:=' to facilitate further processing.'
                        END;
                        
                        IF Payslip= FALSE THEN BEGIN
                        DocN:='Please avail your ';
                        DocM:=DocM + ' Payslip.';
                        DocF:=' to facilitate further processing.'
                        END;
                        
                        DNar:=DocN + DocM + DocF;
                        
                        
                        CLEAR(Notification);
                        IF CustE.GET("Client Code") THEN BEGIN
                        Notification.NewMessage(CustE."E-Mail",ccEmail,'Loan Status',
                        'Your ' + "Loan Product Type" + ' loan application of Ksh.' + FORMAT("Requested Amount")
                        + ' has been received and it is now at the appraisal stage. ' +
                         DNar + ' (Dynamics NAV ERP)'
                        ,'',FALSE);
                        END;
                        
                        
                        END ELSE BEGIN
                        CLEAR(Notification);
                        
                        IF CustE.GET("Client Code") THEN BEGIN
                        Notification.NewMessage(CustE."E-Mail",ccEmail,'Loan Status',
                        'We are sorry to inform you that your ' + "Loan Product Type" + ' loan application of ' + FORMAT("Requested Amount")
                        + ' has been rejected.' + ' (Dynamics NAV ERP)'
                        ,'',FALSE);
                        END;
                        
                        END;
                        
                        }
                          {
                        //SMS Notification
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","Client Code");
                        IF Cust.FIND('-') THEN BEGIN
                        Cust.TESTFIELD(Cust."Phone No.");
                        END;
                        
                        
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","Client Code");
                        IF Cust.FIND('-') THEN BEGIN
                        SMSMessage.INIT;
                        SMSMessage."SMS Message":=Cust."Phone No."+'*'+' Your loan app. of date ' + FORMAT("Application Date")
                        + ' of type ' + "Loan Product Type" +' of amount ' +FORMAT("Approved Amount")+' has been issued. Thank you.';
                        SMSMessage."Date Entered":=TODAY;
                        SMSMessage."Time Entered":=TIME;
                        SMSMessage."SMS Sent":=SMSMessage."SMS Sent"::No;
                        SMSMessage.INSERT;
                        END;
                        //SMS Notification
                        }   */

                    end;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = BatchNoEditable;
                    Visible = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Top Up Amount"; Rec."Top Up Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = ModeofDisburesmentEdit;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if StrLen(Rec."Cheque No.") > 6 then
                            Error('Document No. cannot contain More than 6 Characters.');
                    end;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
                field("External EFT"; Rec."External EFT")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
            }
            part(Control1000000014; "Loan Appraisal Salary Details")
            {
                Caption = 'Salary Details';
                SubPageLink = "Loan No" = field("Loan  No."),
                              "Client Code" = field("Client Code");
                Visible = false;
            }
            part(Control1000000013; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1000000012; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                Image = AnalysisView;
                action("Loan Application Form")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516896, true, false, LoanApp);
                        end;
                    end;
                }
                action("Mark As Posted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark As Posted';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.Posted := true;
                        Rec.Modify;
                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = Aging;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516452, true, false, LoanApp);
                        end;
                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        //IF Posted=TRUE THEN
                        //ERROR('Loan has been posted, Can only preview schedule');

                        if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                            Evaluate(InPeriod, '1D')
                        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                            Evaluate(InPeriod, '1W')
                        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                            Evaluate(InPeriod, '1M')
                        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                            Evaluate(InPeriod, '1Q');


                        QCounter := 0;
                        QCounter := 3;
                        //EVALUATE(InPeriod,'1D');
                        GrPrinciple := Rec."Grace Period - Principle (M)";
                        GrInterest := Rec."Grace Period - Interest (M)";
                        InitialGraceInt := Rec."Grace Period - Interest (M)";

                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", Rec."Loan  No.");
                        if LoansR.Find('-') then begin

                            Rec.TestField("Loan Disbursement Date");
                            Rec.TestField("Repayment Start Date");

                            RSchedule.Reset;
                            RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan  No.");
                            RSchedule.DeleteAll;

                            //LoanAmount:=LoansR."Approved Amount";
                            LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
                            InterestRate := LoansR.Interest;
                            RepayPeriod := LoansR.Installments;
                            InitialInstal := LoansR.Installments + Rec."Grace Period - Principle (M)";
                            //LBalance:=LoansR."Approved Amount";
                            LBalance := LoansR."Approved Amount" + LoansR."Capitalized Charges";
                            RunDate := Rec."Repayment Start Date";//"Loan Disbursement Date";
                                                                  //RunDate:=CALCDATE('-1W',RunDate);
                            InstalNo := 0;
                            //EVALUATE(RepayInterval,'1W');
                            //EVALUATE(RepayInterval,InPeriod);

                            //Repayment Frequency
                            if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                                RunDate := CalcDate('-1D', RunDate)
                            else if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                                RunDate := CalcDate('-1W', RunDate)
                            else if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                                RunDate := CalcDate('-1M', RunDate)
                            else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                            //Repayment Frequency


                            repeat
                                InstalNo := InstalNo + 1;
                                //RunDate:=CALCDATE("Instalment Period",RunDate);
                                //RunDate:=CALCDATE('1W',RunDate);


                                //Repayment Frequency
                                if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                                    RunDate := CalcDate('1D', RunDate)
                                else if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                                    RunDate := CalcDate('1W', RunDate)
                                else if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                                    RunDate := CalcDate('1M', RunDate)
                                else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('1Q', RunDate);
                                //Repayment Frequency

                                //kma
                                if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin
                                    Rec.TestField(Interest);
                                    Rec.TestField(Installments);
                                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.05, '>');
                                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                                    LPrincipal := TotalMRepay - LInterest;
                                end;

                                if Rec."Repayment Method" = Rec."repayment method"::"Straight Line" then begin
                                    Rec.TestField(Interest);
                                    Rec.TestField(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    LInterest := ROUND((InterestRate / 1200) * LoanAmount, 0.05, '>');

                                    //Grace Period Interest
                                    LInterest := ROUND((LInterest * InitialInstal) / (InitialInstal - InitialGraceInt), 0.05, '>');

                                end;

                                if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                                    Rec.TestField(Interest);
                                    Rec.TestField(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.05, '>');
                                end;

                                if Rec."Repayment Method" = Rec."repayment method"::Constants then begin
                                    Rec.TestField(Repayment);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    //IF LBalance < Repayment THEN
                                    //LPrincipal:=LBalance
                                    //ELSE
                                    //LPrincipal:=Repayment;
                                    LInterest := Rec.Interest;
                                end;
                                //kma



                                //Grace Period
                                if GrPrinciple > 0 then begin
                                    LPrincipal := 0
                                end else begin
                                    //IF "Instalment Period" <> InPeriod THEN

                                    //LBalance:=LoanAmount;
                                    LBalance := LBalance - LPrincipal;


                                end;

                                if GrInterest > 0 then
                                    LInterest := 0;

                                GrPrinciple := GrPrinciple - 1;
                                GrInterest := GrInterest - 1;
                                //Grace Period


                                Evaluate(RepayCode, Format(InstalNo));


                                RSchedule.Init;
                                RSchedule."Repayment Code" := RepayCode;
                                RSchedule."Loan No." := Rec."Loan  No.";
                                RSchedule."Loan Amount" := LoanAmount;
                                RSchedule."Instalment No" := InstalNo;
                                RSchedule."Repayment Date" := RunDate;
                                RSchedule."Member No." := Rec."Client Code";
                                RSchedule."Loan Category" := Rec."Loan Product Type";
                                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                                RSchedule."Monthly Interest" := LInterest;
                                RSchedule."Principal Repayment" := LPrincipal;
                                RSchedule.Insert;
                                //WhichDay:=(DATE2DMY,RSchedule."Repayment Date",1);
                                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                            //MESSAGE('which day is %1',WhichDay);
                            //BEEP(2,10000);
                            until LBalance < 1

                        end;

                        Commit;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then
                            Report.Run(51516852, true, false, LoanApp);
                    end;
                }
                action("Post Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Loan MICRO';
                    Image = POST;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        if Rec.Posted = true then
                            Error('Loan already posted.');
                        if Rec."Approved Amount" <= 0 then
                            Error('You cannot post this Amount Less or Equal to Zero');
                        if Confirm('Are you sure you want to post this loan?', true) = false then
                            exit;
                        RepaySched.Reset;
                        RepaySched.SetRange(RepaySched."Loan No.", Rec."Loan  No.");
                        if not RepaySched.Find('-') then begin
                            FnGenerateSchedule();
                        end;

                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", Rec."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            repeat
                                Cust.Reset;
                                Cust.SetRange(Cust."No.", LoanGuar."Member No");
                                if Cust.Find('-') then begin
                                    SFactory.FnSendSMS('MCLOANGUARANTORS', 'You have guaranteed an amount of ' + Format(LoanGuar."Amont Guaranteed")
                                   + ' to ' + Rec."Client Name" + ' Staff No:-' + Rec."Staff No" + ' ' +
                                   'Loan Type ' + Rec."Loan Product Type" + ' of ' + Format(Rec."Requested Amount") + ' at Nafaka Sacco Ltd.', Cust."FOSA Account No.", Cust."Phone No.");
                                end;
                            until LoanGuar.Next = 0;
                        end;
                        SFactory.FnSendSMS('LOAN ISSUE', 'Your loan application of KSHs.' + Format(Rec."Approved Amount") + ' has been issued.', Cust."FOSA Account No.", Cust."Phone No.");

                        Rec."Loan Disbursement Date" := Today;
                        Rec.TestField("Loan Disbursement Date");
                        // "Posting Date" := Rec."Loan Disbursement Date";
                        BATCH_TEMPLATE := 'PAYMENTS';
                        BATCH_NAME := 'LOANS';
                        DOCUMENT_NO := Rec."Loan  No.";
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;

                        if Rec."Mode of Disbursement" = Rec."mode of disbursement"::"Bank Transfer" then begin
                            FnDisburseToCurrentAccount(Rec);

                            //CU posting
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                            Rec.Posted := true;
                            Rec."Loan Status" := Rec."loan status"::Issued;
                            Rec."Issued Date" := Today;
                            Rec.Modify;
                            Message('Loan Posted successfully. The Member and the attached guarantors will be notified via an SMS.');
                        end;
                    end;
                }
                action(Securities)
                {
                    ApplicationArea = Basic;
                    Caption = 'Securities';
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Collateral Security";
                    RunPageLink = "Loan No" = field("Loan  No.");
                    Visible = true;
                }
                action("Salary Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Appraisal';
                    Enabled = true;
                    Image = StatisticsGroup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Appraisal Salary Details";
                    RunPageLink = "Loan No" = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                    Visible = true;
                }
                action("Profitability Analysis")
                {
                    ApplicationArea = Basic;
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Profitability Analysis";
                    RunPageLink = "Client Code" = field("Client Code"),
                                  "Loan No." = field("Loan  No.");
                }
                action("Appraisal Expenses")
                {
                    ApplicationArea = Basic;
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Appraisal Expense";
                    RunPageLink = Loan = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                action(Guarantors)
                {
                    ApplicationArea = Basic;
                    Caption = 'Guarantors';
                    Image = ItemGroup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loans Guarantee Details";
                    // RunPageLink = "Loan No" = field("Loan  No."),
                    //               "Member Cell" = field(Discard);
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        OpenApprovalsEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowExist := true;
        if Rec."Loan Status" = Rec."loan status"::Approved then begin
            OpenApprovalsEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowExist := false;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        LnLoans.Reset;
        LnLoans.SetRange(LnLoans.Posted, false);
        LnLoans.SetRange(LnLoans."Approval Status", LnLoans."approval status"::Open);
        LnLoans.SetRange(LnLoans."Captured By", UserId);
        if LnLoans."Requested Amount" = 0 then begin
            if LnLoans.Count > 0 then begin
                //ERROR(Text008,LnLoans."Approval Status");
            end;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Source := Rec.Source::MICRO;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        if Rec."Loan Status" = Rec."loan status"::Approved then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange(Posted, false);
    end;

    var
        i: Integer;
        LoanType: Record 51381;
        PeriodDueDate: Date;
        ScheduleRep: Record 51375;
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record 51375;
        RSchedule: Record 51375;
        GP: Text[30];
        CheckTiersEditable: Boolean;
        ReasonsEditable: Boolean;
        ScheduleCode: Code[20];
        PreviewShedule: Record 51375;
        PeriodInterval: Code[10];
        LnLoans: Record 51371;
        CustomerRecord: Record 51364;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record 51364;
        LoanApp: Record 51371;
        TestAmt: Decimal;
        CustRec: Record 51371;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record 51398;
        PCharges: Record 51383;
        TCharges: Decimal;
        LAppCharges: Record 51373;
        LoansR: Record 51371;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record 51376;
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        TotalTopupComm: Decimal;
        CustE: Record 51364;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record 51372;
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record 51394;
        DiscountingAmount: Decimal;
        StatusPermissions: Record 51452;
        BridgedLoans: Record 51371;
        SMSMessage: Record 51471;
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record 51371;
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record 51377;
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record 51371;
        SalDetails: Record 51373;
        LGuarantors: Record 51372;
        Text001: label 'Status Must Be Open';
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer;
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        Memb: Record 51364;
        LoanSecurities: Record 51372;
        Text002: label 'Please Insert Securities Details';
        LnSecurities: Record 51372;
        TotalSecurities: Decimal;
        Text003: label 'Collateral Value cannot be less than Applied Amount';
        Text004: label 'This Member has a Pending withdrawal application';
        AppSched: Integer;
        Text005: label 'This loan application is not appraised';
        GSetUp: Record 51398;
        Text006: label 'Number of guarantors less than minimum of 4';
        Text007: label 'You already have a similar running loan, please topup to proceed.';
        Text008: label 'There are still pending applications whose status is -%1, Please utilize them first';
        Prof: Record 51287;
        AppExp: Record 51288;
        iEntryNo: Integer;
        LoanAppMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Polytech Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your Loan Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>Polytech Sacco LTD</b></p>';
        OpenApprovalsEntriesExist: Boolean;
        EnabledApprovalWorkflowExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RepaySched: Record 51375;
        LoanReferee1NameEditable: Boolean;
        LoanReferee2NameEditable: Boolean;
        LoanReferee1MobileEditable: Boolean;
        LoanReferee2MobileEditable: Boolean;
        LoanReferee1AddressEditable: Boolean;
        LoanReferee2AddressEditable: Boolean;
        LoanReferee1PhyAddressEditable: Boolean;
        LoanReferee2PhyAddressEditable: Boolean;
        LoanReferee1RelationEditable: Boolean;
        LoanReferee2RelationEditable: Boolean;
        LoanPurposeEditable: Boolean;
        WitnessEditable: Boolean;
        compinfo: Record "Company Information";
        CummulativeGuarantee: Decimal;
        LoansRec: Record 51371;
        RecoveryModeEditable: Boolean;
        RemarksEditable: Boolean;
        CopyofIDEditable: Boolean;
        CopyofPayslipEditable: Boolean;
        ScheduleBal: Decimal;
        SFactory: Codeunit "Swizzsoft Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        ReschedulingFees: Decimal;
        ReschedulingFeeAccount: Code[50];
        LoanProcessingFee: Decimal;
        ExciseDuty: Decimal;
        EditableField: Boolean;
        DOCUMENT_NO: Code[40];
        LNBalance: Decimal;
        LoanGuar: Record 51372;


    procedure UpdateControl()
    begin

        if Rec."Approval Status" = Rec."approval status"::Open then begin
            MNoEditable := true;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := true;
            InstallmentEditable := true;
            AppliedAmountEditable := true;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := true;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
            //WitnessEditable:=TRUE;
            //LoanPurposeEditable:=TRUE;
            //RecoveryModeEditable:=TRUE;
            //RemarksEditable:=TRUE;
            //LoanPurposeEditable:=TRUE;
            //CopyofIDEditable:=TRUE;
            //CopyofPayslipEditable:=TRUE;
        end;

        if Rec."Approval Status" = Rec."approval status"::Pending then begin
            MNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;

        end;

        if Rec."Approval Status" = Rec."approval status"::Rejected then begin
            MNoEditable := false;
            //AccountNoEditable:=FALSE;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := false;
            DisbursementDateEditable := false;

        end;

        if Rec."Approval Status" = Rec."approval status"::Approved then begin
            MNoEditable := false;
            //AccountNoEditable:=FALSE;
            LoanStatusEditable := false;
            ApplcDateEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := true;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := true;

        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;


    procedure FnSendReceivedApplicationSMS()
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := Rec."Batch No.";
        SMSMessage."Document No" := Rec."Loan  No.";
        SMSMessage."Account No" := Rec."Account No";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'LOANAPP';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Loan of amount ' + Format(Rec."Requested Amount") + ' for ' +
       Rec."Client Code" + ' ' + Rec."Client Name" + ' has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", Rec."Client Code");
        if Cust.Find('-') then begin
            SMSMessage."Telephone No" := Cust."Mobile Phone No";
        end;
        if Cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FnSendReceivedLoanApplEmail(LoanNo: Code[20])
    var
        LoanRec: Record 51371;
        // SMTPMail: Codeunit 400;
        // SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        Cust: Record 51364;
        Email: Text[50];
    begin
        // SMTPSetup.Get();

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Loan  No.", LoanNo);
        if LoanRec.Find('-') then begin
            if Cust.Get(LoanRec."Client Code") then begin
                Email := Cust."E-Mail (Personal)";
            end;
            if Email = '' then begin
                Error('Email Address Missing for LoanRecer Application number' + '-' + LoanRec."Loan  No.");
            end;
            // if Email <> '' then
            //     SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Email, 'Loan Application', '', true);
            // SMTPMail.AppendBody(StrSubstNo(LoanAppMessage, LoanRec."Client Name", IDNo, UserId));
            // SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AddAttachment(FileName, Attachment);
            // SMTPMail.Send;
        end;
    end;

    local procedure FnSendGuarantorAppSMS(LoanNo: Code[20])
    var
        Cust: Record 51364;
        Sms: Record 51471;
    begin
        LGuarantors.Reset;
        LGuarantors.SetRange(LGuarantors."Loan No", Rec."Loan  No.");
        if LGuarantors.FindFirst then begin
            repeat
                if Cust.Get(LGuarantors."Member No") then
                    if Cust."Mobile Phone No" <> '' then


                        //SMS MESSAGE
                        SMSMessage.Reset;
                if SMSMessage.Find('+') then begin
                    iEntryNo := SMSMessage."Entry No";
                    iEntryNo := iEntryNo + 1;
                end
                else begin
                    iEntryNo := 1;
                end;


                SMSMessage.Init;
                SMSMessage."Entry No" := iEntryNo;
                SMSMessage."Batch No" := Rec."Batch No.";
                SMSMessage."Document No" := Rec."Loan  No.";
                SMSMessage."Account No" := Rec."Account No";
                SMSMessage."Date Entered" := Today;
                SMSMessage."Time Entered" := Time;
                SMSMessage.Source := 'GUARANTORSHIP';
                SMSMessage."Entered By" := UserId;
                SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                SMSMessage."SMS Message" := 'Dear Member, You have guaranteed ' + Format(Rec."Client Name")
                + ' ' + Rec."Loan Product Type" + ' of KES. ' + Format(Rec."Approved Amount") + ',' + ' ' + 'Call,' + ' ' + compinfo."Phone No." + ',if in dispute .' + ' ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
                Cust.Reset;
                Cust.SetRange(Cust."No.", Rec."Client Code");
                if Cust.Find('-') then begin
                    SMSMessage."Telephone No" := Cust."Mobile Phone No";
                end;
                if Cust."Mobile Phone No" <> '' then
                    SMSMessage.Insert;

            until LGuarantors.Next = 0;
        end
    end;

    local procedure FnGenerateSchedule()
    begin
        if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
            Evaluate(InPeriod, '1D')
        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
            Evaluate(InPeriod, '1W')
        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
            Evaluate(InPeriod, '1M')
        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
            Evaluate(InPeriod, '1Q');


        QCounter := 0;
        QCounter := 3;
        ScheduleBal := 0;
        GrPrinciple := Rec."Grace Period - Principle (M)";
        GrInterest := Rec."Grace Period - Interest (M)";
        InitialGraceInt := Rec."Grace Period - Interest (M)";

        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan  No.", Rec."Loan  No.");
        if LoansR.Find('-') then begin

            Rec.TestField("Loan Disbursement Date");
            Rec.TestField("Repayment Start Date");

            RSchedule.Reset;
            RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan  No.");
            RSchedule.DeleteAll;

            LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            InterestRate := LoansR.Interest;
            RepayPeriod := LoansR.Installments;
            InitialInstal := LoansR.Installments + Rec."Grace Period - Principle (M)";
            LBalance := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            LNBalance := LoansR."Outstanding Balance";
            RunDate := Rec."Repayment Start Date";

            InstalNo := 0;
            Evaluate(RepayInterval, '1W');

            //Repayment Frequency
            if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                RunDate := CalcDate('-1D', RunDate)
            else if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                RunDate := CalcDate('-1W', RunDate)
            else if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                RunDate := CalcDate('-1M', RunDate)
            else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                RunDate := CalcDate('-1Q', RunDate);
            //Repayment Frequency


            repeat
                InstalNo := InstalNo + 1;
                ScheduleBal := LBalance;

                //*************Repayment Frequency***********************//
                if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                    RunDate := CalcDate('1W', RunDate)
                else if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                    RunDate := CalcDate('1M', RunDate)
                else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                    RunDate := CalcDate('1Q', RunDate);






                //*******************If Amortised****************************//
                if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin
                    Rec.TestField(Installments);
                    Rec.TestField(Interest);
                    Rec.TestField(Installments);
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                    TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate);

                    LPrincipal := TotalMRepay - LInterest;
                end;



                if Rec."Repayment Method" = Rec."repayment method"::"Straight Line" then begin
                    Rec.TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    if (Rec."Loan Product Type" = 'INST') or (Rec."Loan Product Type" = 'MAZAO') then begin
                        LInterest := 0;
                    end else begin
                        LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '>');
                    end;

                    Rec.Repayment := LPrincipal + LInterest;
                    Rec."Loan Principle Repayment" := LPrincipal;
                    Rec."Loan Interest Repayment" := LInterest;
                end;


                if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                    Rec.TestField(Interest);
                    Rec.TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');
                end;

                if Rec."Repayment Method" = Rec."repayment method"::Constants then begin
                    Rec.TestField(Repayment);
                    if LBalance < Rec.Repayment then
                        LPrincipal := LBalance
                    else
                        LPrincipal := Rec.Repayment;
                    LInterest := Rec.Interest;
                end;


                //Grace Period
                if GrPrinciple > 0 then begin
                    LPrincipal := 0
                end else begin
                    if Rec."Instalment Period" <> InPeriod then
                        LBalance := LBalance - LPrincipal;
                    ScheduleBal := ScheduleBal - LPrincipal;
                end;

                if GrInterest > 0 then
                    LInterest := 0;

                GrPrinciple := GrPrinciple - 1;
                GrInterest := GrInterest - 1;
                LInterest := ROUND(LoansR."Approved Amount" * LoansR.Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 0.05, '>'); //For Nafaka Only
                                                                                                                                          //Grace Period
                RSchedule.Init;
                RSchedule."Repayment Code" := RepayCode;
                RSchedule."Loan No." := Rec."Loan  No.";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Instalment No" := InstalNo;
                RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                RSchedule."Member No." := Rec."Client Code";
                RSchedule."Loan Category" := Rec."Loan Product Type";
                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                RSchedule."Monthly Interest" := LInterest;
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Loan Balance" := ScheduleBal;
                RSchedule.Insert;
                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


            until LBalance < 1

        end;
        Commit;
    end;

    local procedure FnDisburseToCurrentAccount(LoanApps: Record 51371)
    var
        ProcessingFees: Decimal;
        ProcessingFeesAcc: Code[50];
        PChargeAmount: Decimal;
        BLoan: Code[30];
    begin
        /*
        NoTemplateNameText
        NoBatchNameText
        NoDocumentNoCode30
        NoLineNoInteger
        NoTransactionTypeOption
        NoAccountTypeOption
        NoAccountNoCode50
        NoTransactionDateDate
        NoTransactionAmountDecimal
        NoDimensionActivityCode40
        NoExternalDocumentNoCode50
        NoTransactionDescriptionText
        NoLoanNumberCode50
        */
        if (SFactory.FnGetFosaAccount(LoanApps."Client Code") = '') then
            Error('Member must be assigned the ordinary Account.');

        GenSetUp.Get();
        LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
        TCharges := 0;
        TopUpComm := 0;
        TotalTopupComm := LoanApps."Top Up Amount";

        //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
        GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", LoanApps."Approved Amount", Format(LoanApps.Source), LoanApps."Loan  No.",
        'Loan principle- ' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
        //--------------------------------(Debit Member Loan Account)---------------------------------------------

        //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", LoanApps."Approved Amount" * -1, 'BOSA', LoanApps."Loan  No.",
        'Loan Issued- ' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.");
        //----------------------------------(Credit Member Fosa Account)------------------------------------------------

        //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
        if PCharges.Find('-') then begin
            repeat
                PCharges.TestField(PCharges."G/L Account");
                GenSetUp.TestField(GenSetUp."Excise Duty Account");
                PChargeAmount := PCharges.Amount;
                if PCharges."Use Perc" = true then
                    PChargeAmount := (LoanDisbAmount * PCharges.Percentage / 100);
                //-------------------EARN CHARGE-------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", Rec."Posting Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
                //-------------------RECOVER-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", PChargeAmount, 'BOSA', LoanApps."Loan  No.",
                PCharges.Description + '-' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.");

                //------------------10% EXCISE DUTY----------------------------------------
                if SFactory.FnChargeExcise(PCharges.Code) then begin
                    //-------------------Earn---------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", Rec."Posting Date", (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.");
                    //-----------------Recover---------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", PChargeAmount * 0.1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Loan Product Type Name" + ' - Excise(10%)', LoanApps."Loan  No.");
                end
            //----------------END 10% EXCISE--------------------------------------------
            until PCharges.Next = 0;
        end;


        //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------
        if LoanApps."Top Up Amount" > 0 then begin
            LoanTopUp.Reset;
            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
            if LoanTopUp.Find('-') then begin
                repeat
                    //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
                    //------------------------------------Principal---------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                    'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //------------------------------------Outstanding Interest----------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                    'Interest Due Paid on top up - ' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //-------------------------------------Levy--------------------------
                    LineNo := LineNo + 10000;
                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", LoanType."Top Up Commision Account", Rec."Posting Date", LoanTopUp.Commision * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Levy on Bridging -' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    end;

                    //-------------------------------------RECOVER-------------------------------------------------------------------------------------------------------
                    //-------------------------------------Principal-----------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", LoanTopUp."Principle Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                    'Loan Offset  - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up");
                    //-------------------------------------Outstanding Interest-------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", LoanTopUp."Interest Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                    'Interest Due Paid on top up - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up");
                    //--------------------------------------Levies--------------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", LoanTopUp.Commision, 'BOSA', LoanTopUp."Loan Top Up",
                        'Levy on Bridging - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up");
                    end;
                until LoanTopUp.Next = 0;
            end;
        end;







        //-----------------------------------------5. BOOST DEPOSITS / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
        if LoanApps."Boost this Loan" then begin
            //---------------------------------------BOOST-----------------------------------------------
            LineNo := LineNo + 10000;
            BLoan := Rec."Booster Loan No";
            if BLoan = '' then begin
                BLoan := FnBoosterLoansDisbursement(Rec, LineNo); //Issue Loan
                Rec."Booster Loan No" := BLoan;
            end;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
            GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", LoanApps."Boosted Amount", 'BOSA', BLoan,
            'Deposits Booster for ' + LoanApps."Loan  No.", BLoan);

            //----------------------Credit FOSA a/c-----------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", LoanApps."Boosted Amount" * -1, 'BOSA', BLoan,
            'Deposits Booster Loan-Booster Loan', BLoan);


            //------------------------------Boost Deposits-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Customer, Rec."Client Code", Rec."Posting Date", LoanApps."Boosted Amount" * -1, 'BOSA', BLoan,
            'Deposits Booster Loan', BLoan);

            //--------------------------------------RECOVER-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", LoanApps."Boosted Amount", 'BOSA', BLoan,
            'Deposits Booster Loan Recov.', BLoan);
        end;







        //-----------------------------------------6. EARN/RECOVER BOOSTING COMMISSION--------------------------------------------------------------------------------------------
        if LoanApps."Boosting Commision" > 0 then begin
            //---------------------------------------EARN-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", GenSetUp."Boosting Fees Account", Rec."Posting Date", LoanApps."Boosting Commision" * -1, 'BOSA', BLoan,
            'Boosting Commision- ' + LoanApps."Client Code" + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
            //--------------------------------------RECOVER-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", LoanApps."Boosting Commision", 'BOSA', BLoan,
            'Deposits Booster Comm. Recov.', LoanApps."Loan  No.");
        end;

        //-----------------------------------------7. EARN/RECOVER BOOSTER LOAN PRINCIPAL--------------------------------------------------------------------------------------------
        if LoanApps."Boosting Commision" > 0 then begin
            //---------------------------------------PAY-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
            GenJournalLine."account type"::Customer, Rec."Client Code", Rec."Posting Date", LoanApps."Boosted Amount" * -1, 'BOSA', BLoan,
            'Deposits Booster Repayment-' + LoanApps."Client Code" + LoanApps."Loan Product Type Name", BLoan);
            //--------------------------------------RECOVER-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", LoanApps."Boosted Amount", 'BOSA', BLoan,
            'Deposits Booster Loan Recov.', BLoan);
        end;

        //-----------------------------------------8. EARN/RECOVER BOOSTER LOAN INTEREST--------------------------------------------------------------------------------------------
        if LoanApps."Boosting Commision" > 0 then begin
            //---------------------------------------PAY-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
            GenJournalLine."account type"::Customer, Rec."Client Code", Rec."Posting Date", LoanApps."Boosted Amount Interest" * -1, 'BOSA', BLoan,
            'Deposits Booster Int - ' + LoanApps."Client Code" + LoanApps."Loan Product Type Name", BLoan);
            //--------------------------------------RECOVER-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", LoanApps."Boosted Amount Interest", 'BOSA', BLoan,
            'Deposits Booster Int Recov.', BLoan);
        end;

        LoanApps."Net Payment to FOSA" := LoanApps."Approved Amount";
        LoanApps."Processed Payment" := true;
        Rec.Modify;

    end;

    local procedure FnBoosterLoansDisbursement(ObjLoanDetails: Record 51371; LineNo: Integer): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit "No. Series";
        DocNumber: Code[100];
        loanTypes: Record 51381;
        ObjLoanX: Record 51371;
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'BLOAN');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            LoansRec.Insert;

            if LoansRec.Get(LoansRec."Loan  No.") then begin
                LoansRec."Client Code" := ObjLoanDetails."Client Code";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'BLOAN';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Loan Status" := LoansRec."loan status"::Issued;
                LoansRec."Application Date" := ObjLoanDetails."Application Date";
                LoansRec."Issued Date" := ObjLoanDetails."Posting Date";
                LoansRec."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := 'BOSA';
                LoansRec."Global Dimension 2 Code" := SFactory.FnGetUserBranch();
                LoansRec.Source := ObjLoanDetails.Source;
                LoansRec."Approval Status" := ObjLoanDetails."Approval Status";
                LoansRec.Repayment := ObjLoanDetails."Boosted Amount";
                LoansRec."Requested Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec."Approved Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;
}

