#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 57300 "Checkoff Processing Header-Dp"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "CheckoffHeader-Distribut Nav";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date"; Rec."Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("ALL TOTAL AMOUNT"; Rec."ALL TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Total Amount")
            {
                field("Dev Total Amount"; Rec."Dev Total Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Dev1 Total Amount"; Rec."Dev1 Total Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Norm Total Amount"; Rec."Norm Total Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Norm 1 TOTAL AMOUNT"; Rec."Norm 1 TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("INVEST TOTAL AMOUNT"; Rec."INVEST TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("SUPER SCH TOTAL AMOUNT"; Rec."SUPER SCH TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("EMER TOTAL AMOUNT"; Rec."EMER TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("SCH TOTAL AMOUNT"; Rec."SCH TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("SUPER EMER TOTAL AMOUNT"; Rec."SUPER EMER TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("SUPER QUICK TOTAL AMOUNT"; Rec."SUPER QUICK TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("QUICK TOTAL AMOUNT"; Rec."QUICK TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("DEPOSIT TOTAL AMOUNT"; Rec."DEPOSIT TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("SHARE TOTAL AMOUNT"; Rec."SHARE TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("INSURANCE TOTAL AMOUNT"; Rec."INSURANCE TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("REG TOTAL AMOUNT"; Rec."REG TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("BEVELONANT TOTAL AMOUNT"; Rec."BEVELONANT TOTAL AMOUNT")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Holiday; Rec.Holiday)
                {
                    ApplicationArea = Basic;
                }
                field("Normal2 Total"; Rec."Normal2 Total")
                {
                    ApplicationArea = Basic;
                }
                field("Merch Amount Total"; Rec."Merch Amount Total")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Bosa receipt lines"; "Checkoff Proc Line-D")
            {
                SubPageLink = "Receipt Header No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Checkoff Disstributed")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff Distributed';
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = XMLport "Import Checkoff Distributed";
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Checkoff")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Checkoff';
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ObjCheckOffLines: Record "CheckoffLinesDistributed Nav";
                begin

                    ReceiptsProcessingLines.Reset;
                    ReceiptsProcessingLines.SetRange("Receipt Header No", Rec.No);
                    if ReceiptsProcessingLines.Find('-') then begin
                        repeat
                            // MESSAGE('MEMBER NO IS %1',ReceiptsProcessingLines."Staff/Payroll No");
                            Cust.Reset;
                            Cust.SetRange(Cust."Personal No", ReceiptsProcessingLines."Staff/Payroll No");
                            if Cust.Find('-') then begin
                                repeat
                                    Cust.CalcFields(Cust."Current Shares");
                                    ReceiptsProcessingLines."Member No." := Cust."No.";
                                    ReceiptsProcessingLines.Name := Cust.Name;
                                    ReceiptsProcessingLines."Expected Amount" := Cust."Monthly Contribution";
                                    // ReceiptsProcessingLines. Variance:=Amount-"Expected Amount";
                                    ReceiptsProcessingLines."FOSA Account" := Cust."FOSA Account No.";
                                    ReceiptsProcessingLines.Modify;
                                until Cust.Next = 0;
                            end;



                            //======================================validate development loan start=========================================================================================
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', '20');
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                ReceiptsProcessingLines."Normal Loan No.(20)" := ObjLoans."Loan  No.";

                                ReceiptsProcessingLines.Modify;
                            end;

                            ///....................................................development 1.............................
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', '23');
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                ReceiptsProcessingLines."DEVELOPMENT LOAN 1  No" := ObjLoans."Loan  No.";

                                ReceiptsProcessingLines.Modify;
                            end;

                            //======================================validate development loan end=========================================================================================


                            //======================================validate emergency loan start=========================================================================================
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', '12');
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                ReceiptsProcessingLines."EMERGENCY LOAN No" := ObjLoans."Loan  No.";
                                ReceiptsProcessingLines.Modify;
                            end;



                            //======================================validate emergency loan end=========================================================================================

                            //======================================validate school fees loan start=========================================================================================
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', '17');
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                ReceiptsProcessingLines."SCHOOL FEES LOAN No" := ObjLoans."Loan  No.";
                                ReceiptsProcessingLines.Modify;
                            end;



                            //======================================validate school fees loan end=========================================================================================

                            //======================================validate normal loan start=========================================================================================
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', '21');
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                if ReceiptsProcessingLines."Normal Loan Amount" > 0 then begin
                                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                    ReceiptsProcessingLines."NORMAL LOAN NO" := ObjLoans."Loan  No.";
                                    ReceiptsProcessingLines.Modify;
                                end;
                            end;

                            //======================================validate normal loan end=========================================================================================


                            //======================================validate normal loan  1 start=========================================================================================
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', '22');
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                if ReceiptsProcessingLines."Normal Loan 1 Amount" > 0 then begin
                                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                    ReceiptsProcessingLines."NORMAL LOAN 1 NO" := ObjLoans."Loan  No.";
                                    ReceiptsProcessingLines.Modify;
                                end;
                            end;



                            //======================================validate school fees loan end=========================================================================================


                            //======================================validate super emergency loan start=========================================================================================
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', '13');
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                ReceiptsProcessingLines."Super Emergency Loan No" := ObjLoans."Loan  No.";
                                ReceiptsProcessingLines.Modify;
                            end;



                            //======================================validate super emergency loan loan end=========================================================================================


                            //======================================validate super quick loan start=========================================================================================
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', '16');
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                ReceiptsProcessingLines."Super Quick Loan No" := ObjLoans."Loan  No.";
                                ReceiptsProcessingLines.Modify;
                            end;



                            //======================================validate super quick loan loan end=========================================================================================


                            //======================================validate  quick loan start=========================================================================================
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', '15');
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                //  "CheckoffLinesDistributed poly"."Quick Loan Principal":=Objloans."Loan Principle Repayment";
                                //  "CheckoffLinesDistributed poly"."Quick Loan Int":=Objloans."Oustanding Interest";
                                ReceiptsProcessingLines."Quick Loan No" := ObjLoans."Loan  No.";
                                ReceiptsProcessingLines.Modify;
                            end;



                            //======================================validate  quick loan loan end=========================================================================================


                            //======================================validate  super school fees loan start=========================================================================================
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', '18');
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                //  "CheckoffLinesDistributed poly"."Super School Fees Principal":=Objloans."Loan Principle Repayment";
                                //  "CheckoffLinesDistributed poly"."Super School Fees Int":=Objloans."Oustanding Interest";
                                ReceiptsProcessingLines."Super School Fees Loan No" := ObjLoans."Loan  No.";
                                ReceiptsProcessingLines.Modify;
                            end;



                            //======================================validate  super school fees loan end=========================================================================================




                            //======================================validate  investment fees fees loan start=========================================================================================
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', '19');
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                //  "CheckoffLinesDistributed poly"."Investment  Principal":=Objloans."Loan Principle Repayment";
                                //  "CheckoffLinesDistributed poly"."Investment  Int":=Objloans."Oustanding Interest";
                                ReceiptsProcessingLines."Investment Loan No" := ObjLoans."Loan  No.";
                                ReceiptsProcessingLines.Modify;
                            end;
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', '25');
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                //  "CheckoffLinesDistributed poly"."Investment  Principal":=Objloans."Loan Principle Repayment";
                                //  "CheckoffLinesDistributed poly"."Investment  Int":=Objloans."Oustanding Interest";
                                ReceiptsProcessingLines."DEVELOPMENT LOAN No" := ObjLoans."Loan  No.";
                                ReceiptsProcessingLines.Modify;
                            end;

                            ////*******************************************************************************MERCHANDISE
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Client Code", ReceiptsProcessingLines."Member No.");
                            ObjLoans.SetFilter(ObjLoans."Loan Product Type", '%1', '26');
                            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                ReceiptsProcessingLines."MERCHANDISE Loan No" := ObjLoans."Loan  No.";
                                ReceiptsProcessingLines.Modify;
                            end;



                        until ReceiptsProcessingLines.Next = 0;

                    end;
                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Process Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Process Checkoff Distributed';
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ObjGenBatch: Record "Gen. Journal Batch";
                begin
                    //  IF Amount<> "ALL TOTAL AMOUNT" THEN
                    //  MESSAGE('Amount must equal Group Total');


                    JBatchs := 'CHECKOFF';

                    FnClearBatch();
                    // FnPostPrinciple();
                    // FnPostInterestPaid();

                    FnPostchechoff();


                    // FnPostFOSA();
                    FnPostBENEVOLENT();
                    // FnPostNormalShare();
                    // FnPostShareCapital();
                    // FnPostCapitalReserve();
                    FnPostUnallocated();
                    FnPostBalancing();
                    Message('Processing Complete');
                    CurrPage.Close;
                end;
            }
            action("Mark As posted")
            {
                ApplicationArea = Basic;
                Image = Archive;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Posted.Once Marked as posted it will go to posted. ?', false) = true then begin
                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec."Posting date" := Today;
                        Rec.Modify;
                    end;
                end;
            }
            action("Mark As postedS")
            {
                ApplicationArea = Basic;
                Caption = 'Reflesh';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    //ERROR(FORMAT(Holiday));
                    checkheadreg.Reset;
                    checkheadreg.SetRange(checkheadreg.No, Rec.No);
                    if checkheadreg.Find('-') then
                        //   "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                        //  +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday;
                        Message('Marked');
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Posting date" := Today;
        Rec."Date Entered" := Today;
    end;

    var
        Loans: Record "Loans Register";
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "CheckoffLinesDistributed Nav";
        LineNo: Integer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "CheckoffHeader-Distribut Nav";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "CheckoffLinesDistributed Nav";
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "CheckoffLinesDistributed Nav";
        JBatchs: Code[10];
        VarAmounttodeduct: Decimal;
        VarLoanNo: Code[30];
        ObjLoans: Record "Loans Register";
        VarRunningBalance: Decimal;
        checkheadreg: Record "CheckoffHeader-Distribut Nav";
        LoansApp: Record "Loans Register";
        Varp: Decimal;
        VarINT: Decimal;
        TotalAmt: Decimal;
        InterestBal: Decimal;
        OutBal: Decimal;

    local procedure FnPostPrinciple()
    var
        ObjCheckOffLines: Record "CheckoffLinesDistributed Nav";
    begin


        ObjCheckOffLines.TestField("Loan No.");
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        //ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Utility Type",'REPAYMENT');
        /// ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'380');
        if ObjCheckOffLines.FindSet then begin
            repeat
                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -ObjCheckOffLines.Amount;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := ObjCheckOffLines."Loan No.";
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                //Gnljnline."Shortcut Dimension 1 Code":=FORMAT('%1',ObjCheckOffLines."Unallocated Fund");
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostInterestPaid()
    var
        ObjCheckOffLines: Record "CheckoffLinesDistributed Nav";
    begin
        Rec.TestField("Posting date");
        Rec.TestField("Account No");
        Rec.TestField("Document No");
        Rec.TestField(Remarks);
        Rec.TestField(Amount);

        //================ registration fee contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Registration Fee", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Registration Fee";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Registration Fee";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        genstup.Get;
        //================ Registraation fee contribution end========================



        //================ insurance fund contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Insurance Fee", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Insurance Fee";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Insurance Contribution";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ Insurance fund contribution end========================


        //================ benevolent fund contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Benevolent Fund", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Benevolent Fund";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Benevolent Fund";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ benevolent fund contribution end========================
        //================ share capital contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Share Capital", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Share Capital";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Share Capital";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ share capital contribution end========================


        //================ deposit contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Deposit Contribution", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Deposit Contribution";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ deposit contribution end========================

        //polytech start loans

        //================ development loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."DEVELOPMENT LOAN Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."DEVELOPMENT LOAN Amount";

                // //        ObjLoans.CALCFIELDS("Oustanding Interest");
                // //
                // //        ObjLoans.RESET;
                // //        ObjLoans.SETRANGE("Client Code",ObjCheckOffLines."Member No.");
                // //        ObjLoans.SETFILTER("Loan Product Type",'%1','20');
                // //        //ObjLoans.SETFILTER("Oustanding Interest",'>%1',0);
                // //        IF ObjLoans.FINDSET THEN
                // //          BEGIN
                // //            //VarLoanNo:=ObjLoans."Loan  No.";
                // //            VarLoanNo:=ObjCheckOffLines."DEVELOPMENT LOAN No";
                // //            END;
                // //
                // //        IF ObjCheckOffLines."DEVELOPMENT LOAN Int"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."DEVELOPMENT LOAN Int"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;
                ///..............................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '20');
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."DEVELOPMENT LOAN No");
                LoansApp.SetFilter(LoansApp."Oustanding Interest", '>%1', 0);
                if LoansApp.FindSet then begin

                    LoansApp.CalcFields(LoansApp."Oustanding Interest");
                    InterestBal := LoansApp."Oustanding Interest";
                    VarLoanNo := ObjCheckOffLines."DEVELOPMENT LOAN No";
                end;
                if LoansApp."Oustanding Interest" < VarRunningBalance then begin
                    Varp := VarRunningBalance - InterestBal;
                    VarAmounttodeduct := VarRunningBalance - Varp;
                end else
                    if LoansApp."Oustanding Interest" > VarRunningBalance then begin
                        VarAmounttodeduct := VarRunningBalance;
                    end;


                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                // //        VarAmounttodeduct:=0;
                // //        IF VarRunningBalance>0 THEN
                // //          BEGIN
                // //          IF ObjCheckOffLines."DEVELOPMENT LOAN Principal"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."DEVELOPMENT LOAN Principal"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;

                VarAmounttodeduct := 0;
                VarAmounttodeduct := Varp;
                VarLoanNo := ObjCheckOffLines."DEVELOPMENT LOAN No";

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                //END;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ development loan amount cal end========================

        //................................................................................... Development loan 1
        //================ development loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."DEVELOPMENT LOAN 1 Amount",'>%1',0);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."DEVELOPMENT LOAN 1 Amount", '>%1', 0);

        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."DEVELOPMENT LOAN 1 Amount";

                // // //        ObjLoans.CALCFIELDS("Oustanding Interest");
                // // //
                // // //        ObjLoans.RESET;
                // // //        ObjLoans.SETRANGE("Client Code",ObjCheckOffLines."Member No.");
                // // //        ObjLoans.SETFILTER("Loan Product Type",'%1','20');
                // // //        //ObjLoans.SETFILTER("Oustanding Interest",'>%1',0);
                // // //        IF ObjLoans.FINDSET THEN
                // // //          BEGIN
                // // //            //VarLoanNo:=ObjLoans."Loan  No.";
                // // //            VarLoanNo:=ObjCheckOffLines."DEVELOPMENT LOAN 1  No";
                // // //            END;
                // // //        IF ObjCheckOffLines."DEVELOPMENT LOAN 1  Int"< VarRunningBalance THEN
                // // //          VarAmounttodeduct:=ObjCheckOffLines."DEVELOPMENT LOAN 1  Int"
                // // //        ELSE
                // // //          VarAmounttodeduct:=VarRunningBalance;
                ///.........................................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '23');
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."DEVELOPMENT LOAN 1  No");
                LoansApp.SetFilter(LoansApp."Oustanding Interest", '>%1', 0);
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest");
                    InterestBal := LoansApp."Oustanding Interest";
                    VarLoanNo := ObjCheckOffLines."DEVELOPMENT LOAN 1  No";

                end;
                if LoansApp."Oustanding Interest" < VarRunningBalance then begin
                    Varp := VarRunningBalance - InterestBal;
                    VarAmounttodeduct := VarRunningBalance - Varp;
                end else
                    if LoansApp."Oustanding Interest" > VarRunningBalance then begin
                        VarAmounttodeduct := VarRunningBalance;
                    end;

                //===================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                //        VarAmounttodeduct:=0;
                //        IF VarRunningBalance>0 THEN
                //          BEGIN
                //            IF ObjCheckOffLines."DEVELOPMENT LOAN 1 Principal"< VarRunningBalance THEN
                //              VarAmounttodeduct:=ObjCheckOffLines."DEVELOPMENT LOAN 1 Principal"
                //            ELSE
                //              VarAmounttodeduct:=VarRunningBalance;

                VarAmounttodeduct := 0;
                VarAmounttodeduct := Varp;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                // END;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ emergency loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."EMERGENCY LOAN Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."EMERGENCY LOAN Amount";

                //        ObjLoans.CALCFIELDS("Oustanding Interest");
                //
                //        ObjLoans.RESET;
                //        ObjLoans.SETRANGE("Client Code",ObjCheckOffLines."Member No.");
                //        ObjLoans.SETFILTER("Loan Product Type",'%1','12');
                //        ObjLoans.SETFILTER("Oustanding Interest",'>%1',0);
                //        IF ObjLoans.FINDSET THEN
                //          BEGIN
                //            //VarLoanNo:=ObjLoans."Loan  No.";
                //            VarLoanNo:=ObjCheckOffLines."EMERGENCY LOAN No";
                //            END;
                //
                //        IF ObjCheckOffLines."EMERGENCY LOAN Int"<VarRunningBalance THEN
                //          VarAmounttodeduct:=ObjCheckOffLines."EMERGENCY LOAN Int"
                //         ELSE
                //          VarAmounttodeduct:=VarRunningBalance;
                ///.........................................................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '12');
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."EMERGENCY LOAN No");
                LoansApp.SetFilter(LoansApp."Oustanding Interest", '>%1', 0);
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest");
                    InterestBal := LoansApp."Oustanding Interest";
                    VarLoanNo := ObjCheckOffLines."EMERGENCY LOAN No";
                end;
                // //            Varp:=VarRunningBalance-InterestBal;
                // //            VarAmounttodeduct:=VarRunningBalance-Varp;
                if LoansApp."Oustanding Interest" < VarRunningBalance then begin
                    Varp := VarRunningBalance - InterestBal;
                    VarAmounttodeduct := VarRunningBalance - Varp;
                end else
                    if LoansApp."Oustanding Interest" > VarRunningBalance then begin
                        VarAmounttodeduct := VarRunningBalance;
                    end;
                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                //Gnljnline."Loan No":=VarLoanNo;
                Gnljnline."Loan No" := ObjCheckOffLines."EMERGENCY LOAN No";
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                ////       VarAmounttodeduct:=0;
                // //        IF VarRunningBalance>0 THEN
                // //          BEGIN
                // //          IF ObjCheckOffLines."EMERGENCY LOAN Principal"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."EMERGENCY LOAN Principal"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;
                VarAmounttodeduct := 0;
                VarAmounttodeduct := Varp;
                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                //Gnljnline."Loan No":=VarLoanNo;
                Gnljnline."Loan No" := ObjCheckOffLines."EMERGENCY LOAN No";
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                // END;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ emergency loan amount cal end========================

        //================  school fees loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."SCHOOL FEES LOAN Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."SCHOOL FEES LOAN Amount";

                // //        ObjLoans.CALCFIELDS("Oustanding Interest");
                // //
                // //        ObjLoans.RESET;
                // //        ObjLoans.SETRANGE("Client Code",ObjCheckOffLines."Member No.");
                // //        ObjLoans.SETFILTER("Loan Product Type",'%1','17');
                // //       // ObjLoans.SETFILTER("Oustanding Interest",'>%1',0);
                // //        IF ObjLoans.FINDSET THEN
                // //          BEGIN
                // //            //VarLoanNo:=ObjLoans."Loan  No.";
                // //            VarLoanNo:=ObjCheckOffLines."SCHOOL FEES LOAN No";
                // //            END;
                // //
                // //        IF ObjCheckOffLines."SCHOOL FEES LOAN Int"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."SCHOOL FEES LOAN Int"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;
                ///.............................................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '17');
                LoansApp.SetFilter(LoansApp."Oustanding Interest", '>%1', 0);
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest");
                    InterestBal := LoansApp."Oustanding Interest";
                    VarLoanNo := ObjCheckOffLines."SCHOOL FEES LOAN No";
                end;
                // //            Varp:=VarRunningBalance-InterestBal;
                // //            VarAmounttodeduct:=VarRunningBalance-Varp;

                if LoansApp."Oustanding Interest" < VarRunningBalance then begin
                    Varp := VarRunningBalance - InterestBal;
                    VarAmounttodeduct := VarRunningBalance - Varp;
                end else
                    if LoansApp."Oustanding Interest" > VarRunningBalance then begin
                        VarAmounttodeduct := VarRunningBalance;
                    end;
                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                //Gnljnline."Loan No":=VarLoanNo;
                Gnljnline."Loan No" := ObjCheckOffLines."SCHOOL FEES LOAN No";
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                // //        VarAmounttodeduct:=0;
                // //        IF VarRunningBalance>0 THEN
                // //          BEGIN
                // //          IF ObjCheckOffLines."SCHOOL FEES LOAN Principal"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."SCHOOL FEES LOAN Principal"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;

                VarAmounttodeduct := 0;
                VarAmounttodeduct := Varp;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                //Gnljnline."Loan No":=VarLoanNo;
                Gnljnline."Loan No" := ObjCheckOffLines."SCHOOL FEES LOAN No";
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                // END;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ school fees loan amount cal end========================




        //================  super emergency loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Super Emergency Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Super Emergency Amount";

                // //        ObjLoans.CALCFIELDS("Oustanding Interest");
                // //
                // //        ObjLoans.RESET;
                // //        ObjLoans.SETRANGE("Client Code",ObjCheckOffLines."Member No.");
                // //        ObjLoans.SETFILTER("Loan Product Type",'%1','13');
                // //        ObjLoans.SETFILTER("Oustanding Interest",'>%1',0);
                // //        IF ObjLoans.FINDSET THEN
                // //          BEGIN
                // //            VarLoanNo:=ObjCheckOffLines."Super Emergency Loan No";
                // //            END;
                // //
                // //        IF ObjCheckOffLines."Super Emergency Int"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."Super Emergency Int"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;
                ///...................................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '13');
                LoansApp.SetFilter(LoansApp."Oustanding Interest", '>%1', 0);
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest");
                    InterestBal := LoansApp."Oustanding Interest";
                    VarLoanNo := ObjCheckOffLines."Super Emergency Loan No";
                end;

                if LoansApp."Oustanding Interest" < VarRunningBalance then begin
                    Varp := VarRunningBalance - InterestBal;
                    VarAmounttodeduct := VarRunningBalance - Varp;
                end else
                    if LoansApp."Oustanding Interest" > VarRunningBalance then begin
                        VarAmounttodeduct := VarRunningBalance;
                    end;
                // //     Varp:=VarRunningBalance-InterestBal;
                // //     VarAmounttodeduct:=VarRunningBalance-Varp;
                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                // //        VarAmounttodeduct:=0;
                // //        IF VarRunningBalance>0 THEN
                // //          BEGIN
                // //          IF ObjCheckOffLines."Super Emergency Principal"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."Super Emergency Principal"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;
                VarAmounttodeduct := 0;
                VarAmounttodeduct := Varp;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                //  END;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ super emergency loan amount cal end========================



        //================  super quick loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Super Quick Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Super Quick Amount";

                // //        ObjLoans.CALCFIELDS("Oustanding Interest");
                // //
                // //        ObjLoans.RESET;
                // //        ObjLoans.SETRANGE("Client Code",ObjCheckOffLines."Member No.");
                // //        ObjLoans.SETFILTER("Loan Product Type",'%1','16');
                // //        //ObjLoans.SETFILTER("Oustanding Interest",'>%1',0);
                // //        IF ObjLoans.FINDSET THEN
                // //          BEGIN
                // //            VarLoanNo:=ObjCheckOffLines."Super Quick Loan No";
                // //            END;
                // //
                // //        IF ObjCheckOffLines."Super Quick Int"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."Super Quick Int"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;
                ///.........................................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '16');
                LoansApp.SetFilter(LoansApp."Oustanding Interest", '>%1', 0);

                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest");
                    InterestBal := LoansApp."Oustanding Interest";
                    VarLoanNo := ObjCheckOffLines."Super Quick Loan No";
                end;

                if LoansApp."Oustanding Interest" < VarRunningBalance then begin
                    Varp := VarRunningBalance - InterestBal;
                    VarAmounttodeduct := VarRunningBalance - Varp;
                end else
                    if LoansApp."Oustanding Interest" > VarRunningBalance then begin
                        VarAmounttodeduct := VarRunningBalance;
                    end;
                // //     Varp:=VarRunningBalance-InterestBal;
                // //     VarAmounttodeduct:=VarRunningBalance-Varp;
                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                // //        VarAmounttodeduct:=0;
                // //        IF VarRunningBalance>0 THEN
                // //          BEGIN
                // //          IF ObjCheckOffLines."Super Quick Principal"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."Super Quick Principal"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;

                VarAmounttodeduct := 0;
                VarAmounttodeduct := Varp;


                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                //END;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ super quick loan amount cal end========================



        //================  quick loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Quick Loan Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Quick Loan Amount";

                // //        ObjLoans.CALCFIELDS("Oustanding Interest");
                // //
                // //        ObjLoans.RESET;
                // //        ObjLoans.SETRANGE("Client Code",ObjCheckOffLines."Member No.");
                // //        ObjLoans.SETFILTER("Loan Product Type",'%1','15');
                // //       // ObjLoans.SETFILTER("Oustanding Interest",'>%1',0);
                // //        IF ObjLoans.FINDSET THEN
                // //          BEGIN
                // //            VarLoanNo:=ObjCheckOffLines."Quick Loan No";
                // //            END;
                // //
                // //        IF ObjCheckOffLines."Quick Loan Int"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."Quick Loan Int"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;
                // // ..........................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '15');
                LoansApp.SetFilter(LoansApp."Oustanding Interest", '>%1', 0);
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest");
                    InterestBal := LoansApp."Oustanding Interest";
                    VarLoanNo := ObjCheckOffLines."Quick Loan No";
                end;

                if LoansApp."Oustanding Interest" < VarRunningBalance then begin
                    Varp := VarRunningBalance - InterestBal;
                    VarAmounttodeduct := VarRunningBalance - Varp;
                end else
                    if LoansApp."Oustanding Interest" > VarRunningBalance then begin
                        VarAmounttodeduct := VarRunningBalance;
                    end;
                // //     Varp:=VarRunningBalance-InterestBal;
                // //     VarAmounttodeduct:=VarRunningBalance-Varp;
                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                // // //        VarAmounttodeduct:=0;
                // // //        IF VarRunningBalance>0 THEN
                // // //          BEGIN
                // // //          IF ObjCheckOffLines."Quick Loan Principal"<VarRunningBalance THEN
                // // //          VarAmounttodeduct:=ObjCheckOffLines."Quick Loan Principal"
                // // //         ELSE
                // // //          VarAmounttodeduct:=VarRunningBalance;
                VarAmounttodeduct := 0;
                VarAmounttodeduct := Varp;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                //     END;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ quick loan amount cal end========================


        //================  super school fees loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Super School Fees Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Super School Fees Amount";

                // // //        ObjLoans.CALCFIELDS("Oustanding Interest");
                // // //
                // // //        ObjLoans.RESET;
                // // //        ObjLoans.SETRANGE("Client Code",ObjCheckOffLines."Member No.");
                // // //        ObjLoans.SETFILTER("Loan Product Type",'%1','18');
                // // //        //ObjLoans.SETFILTER("Oustanding Interest",'>%1',0);
                // // //        IF ObjLoans.FINDSET THEN
                // // //          BEGIN
                // // //            VarLoanNo:=ObjCheckOffLines."Super School Fees Loan No";
                // // //            END;
                // // //
                // // //        IF ObjCheckOffLines."Super School Fees Int"<VarRunningBalance THEN
                // // //          VarAmounttodeduct:=ObjCheckOffLines."Super School Fees Int"
                // // //         ELSE
                // // //          VarAmounttodeduct:=VarRunningBalance;
                //........................................................................cj

                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '18');
                LoansApp.SetFilter(LoansApp."Oustanding Interest", '>%1', 0);
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest");
                    InterestBal := LoansApp."Oustanding Interest";
                    VarLoanNo := ObjCheckOffLines."Super School Fees Loan No";
                end;

                if LoansApp."Oustanding Interest" < VarRunningBalance then begin
                    Varp := VarRunningBalance - InterestBal;
                    VarAmounttodeduct := VarRunningBalance - Varp;
                end else
                    if LoansApp."Oustanding Interest" > VarRunningBalance then begin
                        VarAmounttodeduct := VarRunningBalance;
                    end;
                // //     Varp:=VarRunningBalance-InterestBal;
                // //     VarAmounttodeduct:=VarRunningBalance-Varp;
                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                // //        VarAmounttodeduct:=0;
                // //        IF VarRunningBalance>0 THEN
                // //          BEGIN
                // //          IF ObjCheckOffLines."Super School Fees Principal"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."Super School Fees Principal"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;
                ///.........................
                VarAmounttodeduct := 0;
                VarAmounttodeduct := Varp;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                // END;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================  super school fees loan amount cal end========================



        //================  investment loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Investment  Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Investment  Amount";

                // //        ObjLoans.CALCFIELDS("Oustanding Interest");
                // //
                // //        ObjLoans.RESET;
                // //        ObjLoans.SETRANGE("Client Code",ObjCheckOffLines."Member No.");
                // //        ObjLoans.SETFILTER("Loan Product Type",'%1','19');
                // //        //ObjLoans.SETFILTER("Oustanding Interest",'>%1',0);
                // //        IF ObjLoans.FINDSET THEN
                // //          BEGIN
                // //            VarLoanNo:=ObjCheckOffLines."Investment Loan No";
                // //            END;
                // //
                // //        IF ObjCheckOffLines."Investment  Int"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."Investment  Int"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;
                ////..................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '19');
                LoansApp.SetFilter(LoansApp."Oustanding Interest", '>%1', 0);
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest");
                    InterestBal := LoansApp."Oustanding Interest";
                    VarLoanNo := ObjCheckOffLines."Investment Loan No";
                end;

                if LoansApp."Oustanding Interest" < VarRunningBalance then begin
                    Varp := VarRunningBalance - InterestBal;
                    VarAmounttodeduct := VarRunningBalance - Varp;
                end else
                    if LoansApp."Oustanding Interest" > VarRunningBalance then begin
                        VarAmounttodeduct := VarRunningBalance;
                    end;
                //     Varp:=VarRunningBalance-InterestBal;
                //     VarAmounttodeduct:=VarRunningBalance-Varp;

                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                // // //        VarAmounttodeduct:=0;
                // // //        IF VarRunningBalance>0 THEN
                // // //          BEGIN
                // // //          IF ObjCheckOffLines."Investment  Principal"<VarRunningBalance THEN
                // // //          VarAmounttodeduct:=ObjCheckOffLines."Investment  Principal"
                // // //         ELSE
                // // //          VarAmounttodeduct:=VarRunningBalance;
                // // // ................
                VarAmounttodeduct := 0;
                VarAmounttodeduct := Varp;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                //   END;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ investment loan amount cal end========================




        ////////////////////////////////////////kip

        //================  Normal loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Normal Loan Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Normal Loan Amount";

                // // //        ObjLoans.CALCFIELDS("Oustanding Interest");
                // // //
                // // //        ObjLoans.RESET;
                // // //        ObjLoans.SETRANGE("Client Code",ObjCheckOffLines."Member No.");
                // // //        ObjLoans.SETFILTER("Loan Product Type",'%1','21');
                // // //        //ObjLoans.SETFILTER("Oustanding Interest",'>%1',0);
                // // //        IF ObjLoans.FINDSET THEN
                // // //          BEGIN
                // // //            VarLoanNo:=ObjCheckOffLines."NORMAL LOAN NO";
                // // //            END;
                // // //
                // // //        IF ObjCheckOffLines."Normal Loan Int"<VarRunningBalance THEN
                // // //          VarAmounttodeduct:=ObjCheckOffLines."Normal Loan Int"
                // // //         ELSE
                // // //          VarAmounttodeduct:=VarRunningBalance;
                //................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '21');
                LoansApp.SetFilter(LoansApp."Oustanding Interest", '>%1', 0);
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest");
                    InterestBal := LoansApp."Oustanding Interest";
                    VarLoanNo := ObjCheckOffLines."NORMAL LOAN NO";
                end;
                if LoansApp."Oustanding Interest" < VarRunningBalance then begin
                    Varp := VarRunningBalance - InterestBal;
                    VarAmounttodeduct := VarRunningBalance - Varp;
                end else
                    if LoansApp."Oustanding Interest" > VarRunningBalance then begin
                        VarAmounttodeduct := VarRunningBalance;
                    end;
                // //     Varp:=VarRunningBalance-InterestBal;
                // //     VarAmounttodeduct:=VarRunningBalance-Varp;

                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                // //        VarAmounttodeduct:=0;
                // //        IF VarRunningBalance>0 THEN
                // //          BEGIN
                // //          IF ObjCheckOffLines."Normal Loan Principal"<VarRunningBalance THEN
                // //          VarAmounttodeduct:=ObjCheckOffLines."Normal Loan Principal"
                // //         ELSE
                // //          VarAmounttodeduct:=VarRunningBalance;
                VarAmounttodeduct := 0;
                VarAmounttodeduct := Varp;


                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                //  END;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ normal loan amount cal end========================


        //================  Normal  loan 1 amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Normal Loan 1 Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Normal Loan 1 Amount";

                // //           ObjLoans.CALCFIELDS("Oustanding Interest");
                // //
                // //           ObjLoans.RESET;
                // //           ObjLoans.SETRANGE("Client Code",ObjCheckOffLines."Member No.");
                // //           ObjLoans.SETFILTER("Loan Product Type",'%1','22');
                // //           //ObjLoans.SETFILTER("Oustanding Interest",'>%1',0);
                // //           IF ObjLoans.FINDSET THEN
                // //             BEGIN
                // //               VarLoanNo:=ObjCheckOffLines."NORMAL LOAN 1 NO";
                // //               END;
                // //
                // //           IF ObjCheckOffLines."Normal Loan Int"<VarRunningBalance THEN
                // //             VarAmounttodeduct:=ObjCheckOffLines."Normal Loan Int"
                // //            ELSE
                // //             VarAmounttodeduct:=VarRunningBalance;

                //...jo
                // // //             InterestBal:=0;
                // // //     Varp:=0;
                // // //     LoansApp.RESET;
                // // //     LoansApp.SETRANGE("Client Code",ObjCheckOffLines."Member No.");
                // // //     LoansApp.SETFILTER("Loan Product Type",'%1','22');
                // // //     LoansApp.SetFilter(LoansApp."Oustanding Interest",'>%1',0);
                // // //     IF LoansApp.FINDSET THEN
                // // //         BEGIN
                // // //     LoansApp.CalcFields(LoansApp."Oustanding Interest");
                // // //     InterestBal:=LoansApp."Oustanding Interest";
                // // //     VarLoanNo:=ObjCheckOffLines."NORMAL LOAN 1 NO";
                // // //         END;
                // // //
                // // // IF LoansApp."Oustanding Interest" < VarRunningBalance THEN BEGIN
                // // //            Varp:=VarRunningBalance-InterestBal;
                // // //            VarAmounttodeduct:=VarRunningBalance-Varp;
                // // //            END ELSE
                // // //    IF LoansApp."Oustanding Interest" > VarRunningBalance THEN BEGIN
                // // //           VarAmounttodeduct:=VarRunningBalance;
                // // //    END;
                // //     Varp:=VarRunningBalance-InterestBal;
                // //     VarAmounttodeduct:=VarRunningBalance-Varp;

                //=====================================================================================interest paid

                //        LineN:=LineN+10000;
                //        Gnljnline.INIT;
                //        Gnljnline."Journal Template Name":='GENERAL';
                //        Gnljnline."Journal Batch Name":=JBatchs;
                //        Gnljnline."Line No.":=LineN;
                //        Gnljnline."Account Type":=Gnljnline."Account Type"::Member;
                //        Gnljnline."Account No.":=ObjCheckOffLines."Member No.";
                //        Gnljnline.VALIDATE(Gnljnline."Account No.");
                //        Gnljnline."Document No.":="Document No";
                //        Gnljnline."Posting Date":="Posting date";
                //        Gnljnline.Description:=ObjCheckOffLines."Loan Type";
                //        Gnljnline.Amount:=-VarAmounttodeduct;
                //        Gnljnline.VALIDATE(Gnljnline.Amount);
                //        Gnljnline."Loan No":=VarLoanNo;
                //        Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Interest Paid";
                //        Gnljnline.VALIDATE(Gnljnline."Transaction Type");
                //        Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                //        //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                //        IF Gnljnline.Amount<>0 THEN
                //        Gnljnline.INSERT;
                ///       VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;

                //=====================================================================================principal repayment
                // //         VarAmounttodeduct:=0;
                // //         IF VarRunningBalance>0 THEN
                // //           BEGIN
                // //           IF ObjCheckOffLines."Normal Loan 1 Principal"<VarRunningBalance THEN
                // //           VarAmounttodeduct:=ObjCheckOffLines."Normal Loan 1 Principal"
                // //          ELSE
                // //           VarAmounttodeduct:=VarRunningBalance;
                // // VarAmounttodeduct:=0;
                // // VarAmounttodeduct:=Varp;
                ///VarAmounttodeduct := ObjCheckOffLines."Normal Loan 1 Principal";
                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                ///END;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ normal loan 1 loan amount cal end========================




        ///////////////////kip



        //end of loans polytech
    end;

    local procedure FnPostShareCapital()
    var
        ObjCheckOffLines: Record "Checkoff Lines-Distributed";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetRange(ObjCheckOffLines."SUPER EMERGENCY LOAN");
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'229');
        if ObjCheckOffLines.FindSet then begin
            repeat
                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines.Reference;
                Gnljnline.Amount := -ObjCheckOffLines."SUPER EMERGENCY LOAN";
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Share Capital";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostNormalShare()
    var
        ObjCheckOffLines: Record "CheckoffLinesDistributed Nav";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Deposit Contribution");
        if ObjCheckOffLines.FindSet then begin
            repeat
                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                //Gnljnline.Description:=ObjCheckOffLines.Reference;
                // Gnljnline.Amount:=-ObjCheckOffLines."Refinance Loan No";
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostFOSA()
    var
        ObjCheckOffLines: Record "Checkoff Lines-Distributed";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetRange(ObjCheckOffLines."QUICK LOAN");
        if ObjCheckOffLines.FindSet then begin
            repeat
                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := 'Welfare contribution';
                Gnljnline.Amount := -ObjCheckOffLines."QUICK LOAN";
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Benevolent Fund";
                //Gnljnline.VALIDATE(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostBENEVOLENT()
    var
        ObjCheckOffLines: Record "CheckoffLinesDistributed Nav";
    begin
        //=======Welfare contribution
        RcptBufLines.Reset;
        RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
        RcptBufLines.SetFilter(RcptBufLines."Welfare contribution", '>%1', 0);

        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := RcptBufLines."Welfare contribution";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := RcptBufLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := 'wefare contribution for ' + RcptBufLines."Member No.";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Welfare Contribution";
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until RcptBufLines.Next = 0;
        end;

        //===========End of welfare contribution
    end;

    local procedure FnPostBalancing()
    begin
        LineN := LineN + 10000;
        Gnljnline.Init;
        Gnljnline."Journal Template Name" := 'GENERAL';
        Gnljnline."Journal Batch Name" := JBatchs;
        Gnljnline."Line No." := LineN;
        Gnljnline."Account Type" := Gnljnline."account type"::Customer;
        Gnljnline."Account No." := Rec."Account No";
        Gnljnline.Validate(Gnljnline."Account No.");
        Gnljnline."Document No." := Rec."Document No";
        Gnljnline."Posting Date" := Rec."Posting date";
        Gnljnline.Description := Rec.No + '-' + Rec."Document No";
        Gnljnline.Amount := Rec.Amount;
        Gnljnline.Validate(Gnljnline.Amount);
        Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
        //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
        if Gnljnline.Amount <> 0 then
            Gnljnline.Insert;
    end;

    local procedure FnClearBatch()
    var
        ObjGenBatch: Record "Gen. Journal Batch";
    begin
        ObjGenBatch.Reset;
        ObjGenBatch.SetRange(ObjGenBatch."Journal Template Name", 'GENERAL');
        ObjGenBatch.SetRange(ObjGenBatch.Name, JBatchs);
        if ObjGenBatch.Find('-') = false then begin
            ObjGenBatch.Init;
            ObjGenBatch."Journal Template Name" := 'GENERAL';
            ObjGenBatch.Name := JBatchs;
            ObjGenBatch.Description := 'CHECKOFF PROCESSING';
            ObjGenBatch.Validate(ObjGenBatch."Journal Template Name");
            ObjGenBatch.Validate(ObjGenBatch.Name);
            ObjGenBatch.Insert;
        end;

        Gnljnline.Reset;
        Gnljnline.SetRange("Journal Template Name", 'GENERAL');
        Gnljnline.SetRange("Journal Batch Name", JBatchs);
        Gnljnline.DeleteAll;
    end;

    local procedure FnPostShares()
    begin
    end;

    local procedure FnPostLoanFine()
    begin
    end;

    local procedure FnPostCapitalReserve()
    var
        ObjCheckOffLines: Record "Checkoff Lines-Distributed";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Trans Type",'RESERVE');
        ObjCheckOffLines.SetRange(ObjCheckOffLines.Reference, '337');
        if ObjCheckOffLines.FindSet then begin
            repeat
                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines.Reference;
                Gnljnline.Amount := -ObjCheckOffLines.Amount;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Jiokoe Savings";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostUnallocated()
    var
        ObjCheckOffLines: Record "Checkoff Lines-Distributed";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Utility Type", 'UNALLOCATED');
        if ObjCheckOffLines.FindSet then begin
            repeat
                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines.Reference;
                Gnljnline.Amount := -ObjCheckOffLines.Amount;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostchechoff()
    var
        ObjCheckOffLines: Record "CheckoffLinesDistributed Nav";
    begin
        Rec.TestField("Posting date");
        Rec.TestField("Account No");
        Rec.TestField("Document No");
        Rec.TestField(Remarks);
        Rec.TestField(Amount);


        //================ registration fee contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Registration Fee", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Registration Fee";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Registration Fee";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ Registraation fee contribution end========================



        //================ insurance fund contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Insurance Fee", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Insurance Fee";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Insurance Contribution";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ Insurance fund contribution end========================


        //================ benevolent fund contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Benevolent Fund", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Benevolent Fund";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Benevolent Fund";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ benevolent fund contribution end========================
        //================ share capital contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Share Capital", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Share Capital";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Share Capital";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ share capital contribution end========================


        //================ deposit contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Deposit Contribution", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Deposit Contribution";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ deposit contribution end========================

        //***************************************************************************************Holiday savings
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Holiday savings", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Holiday savings";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Holiday savings";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;



        //polytech start loans


        //================ development loan amount cal start========================1


        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."DEVELOPMENT LOAN Amount", '>%1', 0);
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."DEVELOPMENT LOAN Amount";
                Varp := 0;
                InterestBal := 0;
                VarLoanNo := ObjCheckOffLines."DEVELOPMENT LOAN No";
                VarAmounttodeduct := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '25');
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."DEVELOPMENT LOAN No");
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");
                    //MESSAGE('in %1||%2',LoansApp."Oustanding Interest","Posting date");
                    if LoansApp."Oustanding Interest" > 0 then
                        InterestBal := LoansApp."Oustanding Interest";
                end;
                if InterestBal > VarRunningBalance then begin
                    VarAmounttodeduct := VarRunningBalance
                end
                else
                    VarAmounttodeduct := InterestBal;

                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                if LoansApp."Outstanding Balance" > 0 then begin
                    OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;


                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ development loan amount cal end========================

        //................................................................................... Development loan 1
        //================ development loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."DEVELOPMENT LOAN 1 Amount", '>%1', 0);
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."DEVELOPMENT LOAN 1 Amount";
                VarLoanNo := ObjCheckOffLines."DEVELOPMENT LOAN 1  No";
                ///.........................................................................cj


                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '23');
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."DEVELOPMENT LOAN 1  No");
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");
                    if LoansApp."Oustanding Interest" > 0 then
                        InterestBal := LoansApp."Oustanding Interest";

                end;

                if InterestBal > VarRunningBalance then begin

                    VarAmounttodeduct := VarRunningBalance
                end
                else
                    VarAmounttodeduct := InterestBal;

                //===================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                if LoansApp."Outstanding Balance" > 0 then begin
                    OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;


                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;
            // END;

            until ObjCheckOffLines.Next = 0;
        end;


        //================ emergency loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."EMERGENCY LOAN Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."EMERGENCY LOAN Amount";

                VarLoanNo := ObjCheckOffLines."EMERGENCY LOAN No";
                Varp := 0;
                InterestBal := 0;
                VarAmounttodeduct := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '12');
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."EMERGENCY LOAN No");
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");
                    if LoansApp."Oustanding Interest" > 0 then
                        InterestBal := LoansApp."Oustanding Interest";
                end;
                if InterestBal > VarRunningBalance then begin
                    VarAmounttodeduct := VarRunningBalance
                end
                else
                    VarAmounttodeduct := InterestBal;
                ///.........................................................................................cj

                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                //Gnljnline."Loan No":=VarLoanNo;
                Gnljnline."Loan No" := ObjCheckOffLines."EMERGENCY LOAN No";
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                if LoansApp."Outstanding Balance" > 0 then begin
                    OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Loan No" := ObjCheckOffLines."EMERGENCY LOAN No";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ emergency loan amount cal end========================

        //================  school fees loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."SCHOOL FEES LOAN Amount", '>%1', 0);
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."SCHOOL FEES LOAN Amount";
                VarLoanNo := ObjCheckOffLines."SCHOOL FEES LOAN No";

                ///.............................................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."SCHOOL FEES LOAN No");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '17');
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");
                    if LoansApp."Oustanding Interest" > 0 then
                        InterestBal := LoansApp."Oustanding Interest";
                end;
                if InterestBal > VarRunningBalance then begin
                    VarAmounttodeduct := VarRunningBalance
                end else
                    VarAmounttodeduct := InterestBal;

                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                //Gnljnline."Loan No":=VarLoanNo;
                Gnljnline."Loan No" := ObjCheckOffLines."SCHOOL FEES LOAN No";
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                if LoansApp."Outstanding Balance" > 0 then begin
                    OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Loan No" := ObjCheckOffLines."SCHOOL FEES LOAN No";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin
                    VarAmounttodeduct := VarRunningBalance;
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ school fees loan amount cal end========================




        //================  super emergency loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Super Emergency Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Super Emergency Amount";
                VarLoanNo := ObjCheckOffLines."Super Emergency Loan No";

                ///...................................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."Super Emergency Loan No");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '13');
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");
                    if LoansApp."Oustanding Interest" > 0 then
                        InterestBal := LoansApp."Oustanding Interest";
                end;
                if InterestBal > VarRunningBalance then begin
                    VarAmounttodeduct := VarRunningBalance
                end else
                    VarAmounttodeduct := InterestBal;

                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                if LoansApp."Outstanding Balance" > 0 then begin
                    OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ super emergency loan amount cal end========================



        //================  super quick loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Super Quick Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Super Quick Amount";
                VarLoanNo := ObjCheckOffLines."Super Quick Loan No";

                ///.........................................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."Super Quick Loan No");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '16');
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");
                    if LoansApp."Oustanding Interest" > 0 then
                        InterestBal := LoansApp."Oustanding Interest";
                end;
                if InterestBal > VarRunningBalance then begin
                    VarAmounttodeduct := VarRunningBalance
                end else
                    VarAmounttodeduct := InterestBal;
                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                if LoansApp."Outstanding Balance" > 0 then begin
                    OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ super quick loan amount cal end========================



        //================  quick loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Quick Loan Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Quick Loan Amount";
                VarLoanNo := ObjCheckOffLines."Quick Loan No";

                // // ..........................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."Quick Loan No");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '15');
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");
                    if LoansApp."Oustanding Interest" > 0 then
                        InterestBal := LoansApp."Oustanding Interest";
                end;

                if InterestBal > VarRunningBalance then begin
                    VarAmounttodeduct := VarRunningBalance
                end else
                    VarAmounttodeduct := InterestBal;
                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                if LoansApp."Outstanding Balance" > 0 then begin
                    OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;


                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ quick loan amount cal end========================


        //================  super school fees loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Super School Fees Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Super School Fees Amount";
                VarLoanNo := ObjCheckOffLines."Super School Fees Loan No";


                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."Super School Fees Loan No");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '18');
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");
                    if LoansApp."Oustanding Interest" > 0 then
                        InterestBal := LoansApp."Oustanding Interest";
                end;
                if InterestBal > VarRunningBalance then begin
                    VarAmounttodeduct := VarRunningBalance
                end else
                    VarAmounttodeduct := InterestBal;

                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                if LoansApp."Outstanding Balance" > 0 then begin
                    OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================  super school fees loan amount cal end========================



        //================  investment loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Investment  Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Investment  Amount";
                VarLoanNo := ObjCheckOffLines."Investment Loan No";

                ////..................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."Investment Loan No");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '19');
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");
                    if LoansApp."Oustanding Interest" > 0 then
                        InterestBal := LoansApp."Oustanding Interest";
                end;
                if InterestBal > VarRunningBalance then begin
                    VarAmounttodeduct := VarRunningBalance
                end else
                    VarAmounttodeduct := InterestBal;

                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                if LoansApp."Outstanding Balance" > 0 then begin
                    OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin
                    VarAmounttodeduct := VarRunningBalance;
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ investment loan amount cal end========================

        //************************Start of 26****************************************************************************************seph

        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."MERCHANDISE Amount", '>%1', 0);
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."MERCHANDISE Amount";
                VarLoanNo := ObjCheckOffLines."MERCHANDISE Loan No";

                ////..................................................cj
                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."MERCHANDISE Loan No");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '26');
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");
                    if LoansApp."Oustanding Interest" > 0 then
                        InterestBal := LoansApp."Oustanding Interest";
                end;
                if InterestBal > VarRunningBalance then begin
                    VarAmounttodeduct := VarRunningBalance
                end else
                    VarAmounttodeduct := InterestBal;

                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                if LoansApp."Outstanding Balance" > 0 then begin
                    OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin
                    VarAmounttodeduct := VarRunningBalance;
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //***************************************end**********************************************26************************************seph





        //================ normal loan amount cal start========================20


        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Normal Amount 20", '>%1', 0);
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Normal Amount 20";
                Varp := 0;
                InterestBal := 0;
                VarLoanNo := ObjCheckOffLines."Normal Loan No.(20)";
                VarAmounttodeduct := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '20');
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."Normal Loan No.(20)");
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");
                    if LoansApp."Oustanding Interest" > 0 then
                        InterestBal := LoansApp."Oustanding Interest";
                end;
                if InterestBal > VarRunningBalance then begin
                    VarAmounttodeduct := VarRunningBalance
                end
                else
                    VarAmounttodeduct := InterestBal;

                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                if LoansApp."Outstanding Balance" > 0 then begin
                    OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;


                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ normal loan amount cal end========================




        ////////////////////////////////////////kip

        //================  Normal loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Normal Loan Amount", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Normal Loan Amount";
                VarLoanNo := ObjCheckOffLines."NORMAL LOAN NO";

                InterestBal := 0;
                Varp := 0;
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetRange(LoansApp."Loan  No.", ObjCheckOffLines."NORMAL LOAN NO");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '21');
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    // MESSAGE ('loan is %1',LoansApp."Loan  No.");
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");
                    /// MESSAGE('int is %1',LoansApp."Oustanding Interest");
                    if LoansApp."Oustanding Interest" > 0 then
                        InterestBal := LoansApp."Oustanding Interest";
                    // MESSAGE('here %1',InterestBal);
                end;
                if InterestBal > VarRunningBalance then begin
                    VarAmounttodeduct := VarRunningBalance
                end else
                    VarAmounttodeduct := InterestBal;
                //=====================================================================================interest paid

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := ObjCheckOffLines."Loan Type";
                Gnljnline.Amount := -VarAmounttodeduct;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := VarLoanNo;
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                VarRunningBalance := VarRunningBalance - VarAmounttodeduct;

                //=====================================================================================principal repayment
                if LoansApp."Outstanding Balance" > 0 then begin
                    OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;


                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin
                    VarAmounttodeduct := VarRunningBalance;
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ normal loan amount cal end========================


        //================  Normal  loan 1 amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", Rec.No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Normal Loan 1 Amount", '>%1', 0);
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Normal Loan 1 Amount";
                VarLoanNo := ObjCheckOffLines."NORMAL LOAN 1 NO";
                LoansApp.Reset;
                LoansApp.SetRange(LoansApp."Client Code", ObjCheckOffLines."Member No.");
                LoansApp.SetFilter(LoansApp."Loan Product Type", '%1', '22');
                LoansApp.SetFilter(LoansApp."Date filter", '..' + Format(Rec."Posting date"));
                if LoansApp.FindSet then begin
                    LoansApp.CalcFields(LoansApp."Oustanding Interest", LoansApp."Outstanding Balance");

                    if LoansApp."Outstanding Balance" > 0 then
                        OutBal := LoansApp."Outstanding Balance";

                    if OutBal < VarRunningBalance then
                        VarAmounttodeduct := LoansApp."Outstanding Balance"
                    else
                        VarAmounttodeduct := VarRunningBalance;



                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarAmounttodeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    VarRunningBalance := VarRunningBalance - VarAmounttodeduct;
                end;

                //=====================================================================================unallocated funds

                if VarRunningBalance > 0 then begin
                    VarAmounttodeduct := VarRunningBalance;
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ normal loan 1 loan amount cal end========================

    end;
}

