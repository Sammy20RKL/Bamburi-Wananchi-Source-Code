table 57200 "Guarantors Recovery Header"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan PayOff Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Member No") then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Outstanding Balance");
                    "Member Name" := Cust.Name;
                    "Personal No" := Cust."Personal No";
                    "Current Shares" := Cust."Current Shares";
                    "Loan Liabilities" := Cust."Outstanding Balance";
                end;


                //Clear Existing Lines
                LoanDetails.Reset;
                LoanDetails.SetRange(LoanDetails."Document No", "Document No");
                if LoanDetails.FindSet then begin
                    LoanDetails.DeleteAll;
                end;


                //Update Loan Details
                LoanRec.Reset;
                LoanRec.SetRange(LoanRec."Client Code", "Member No");
                if LoanRec.FindSet then begin
                    LoanRec.CalcFields(LoanRec."Outstanding Balance", LoanRec."Oustanding Interest");
                    repeat
                        if (LoanRec."Outstanding Balance" > 0) or (LoanRec."Oustanding Interest" > 0) then begin
                            LoanDetails.Init;
                            LoanDetails."Document No" := "Document No";
                            LoanDetails."Member No" := "Member No";
                            LoanDetails."Loan No." := LoanRec."Loan  No.";
                            LoanDetails."Loan Type" := LoanRec."Loan Product Type";
                            LoanDetails."Approved Loan Amount" := LoanRec."Approved Amount";
                            LoanDetails."Loan Instalments" := LoanRec.Installments;
                            LoanDetails."Interest Rate" := LoanRec.Interest;
                            LoanDetails."Outstanding Balance" := LoanRec."Outstanding Balance";
                            LoanDetails."Outstanding Interest" := LoanRec."Oustanding Interest";
                            LoanDetails.Insert;
                        end;
                    until LoanRec.Next = 0;
                end;
            end;
        }
        field(3; "Member Name"; Code[50])
        {
        }
        field(4; "Application Date"; Date)
        {
        }
        field(7; "Created By"; Code[20])
        {
        }
        field(8; "No. Series"; Code[20])
        {
        }
        field(10; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(12; Posted; Boolean)
        {
        }
        field(13; "Posting Date"; Date)
        {
        }
        field(14; "Posted By"; Code[20])
        {
        }
        field(15; "Personal No"; Code[30])
        {
        }
        field(16; "Recovery Type"; Option)
        {
            OptionCaption = ' ,Recover From Loanee Deposits,Attach Defaulted Loans to Guarantors,Recover From Guarantors Deposits';
            OptionMembers = " ","Recover From Loanee Deposits","Attach Defaulted Loans to Guarantors","Recover From Guarantors Deposits";
        }
        field(17; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(18; "Current Shares"; Decimal)
        {
        }
        field(19; "Loan Liabilities"; Decimal)
        {
        }
        field(20; "Loan to Attach"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"));

            trigger OnValidate()
            begin
                GuarantorAllocation.Reset;
                GuarantorAllocation.SetRange(GuarantorAllocation."Document No", "Document No");
                if GuarantorAllocation.FindSet then begin
                    GuarantorAllocation.DeleteAll;
                end;


                TGrAmount := 0;
                GrAmount := 0;
                FGrAmount := 0;

                LoanGuar.Reset;
                LoanGuar.SetRange(LoanGuar."Loan No", "Loan to Attach");
                if LoanGuar.Find('-') then begin
                    repeat
                        TGrAmount := TGrAmount + GrAmount;
                        GrAmount := LoanGuar."Amont Guaranteed";
                        FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
                    until LoanGuar.Next = 0;
                end;

                if LoansRec.Get("Loan to Attach") then begin
                    //Defaulter loan clear
                    LoansRec.CalcFields(LoansRec."Outstanding Balance", LoansRec."Interest Due");
                    Lbal := ROUND(LoansRec."Outstanding Balance", 1, '=');
                    if LoansRec."Oustanding Interest" > 0 then begin
                        INTBAL := ROUND(LoansRec."Oustanding Interest", 1, '=');
                        COMM := ROUND((LoansRec."Oustanding Interest" * 0.5), 1, '=');
                        LoansRec."Attached Amount" := Lbal;
                        LoansRec.PenaltyAttached := COMM;
                        LoansRec.InDueAttached := INTBAL;
                        Modify;
                    end;
                    LoansRec.Attached := true;

                    GenSetUp.Get();

                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", LoansRec."Loan  No.");
                    if LoanGuar.Find('-') then begin
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", LoansRec."Loan  No.");
                        DLN := 'DLN';
                        repeat
                            LoansRec.Reset;
                            LoansRec.SetRange(LoansRec."Client Code", LoanGuar."Member No");
                            LoansRec.SetRange(LoansRec."Loan Product Type", 'DEFAULTER');
                            if LoansRec.Find('-') then begin
                                LoansRec.CalcFields(LoansRec."Outstanding Balance");
                                if LoansRec."Outstanding Balance" = 0 then
                                    LoansRec.DeleteAll;
                            end;

                            GenSetUp.Get();
                            GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                            GenSetUp.Modify;
                            DLN := 'DLN_' + Format(GenSetUp."Defaulter LN");
                            TGrAmount := TGrAmount + GrAmount;
                            GrAmount := LoanGuar."Amont Guaranteed";
                            Message('Guarnteed Amount %1', FGrAmount);


                            if loanTypes.Get(LoansRec."Loan Product Type") then begin



                                GuarantorAllocation.Init;
                                GuarantorAllocation."Document No" := "Document No";
                                GuarantorAllocation."Member No" := LoanGuar."Member No";
                                GuarantorAllocation."Loan No." := "Loan to Attach";
                                GuarantorAllocation."Amount Allocated" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                                GuarantorAllocation."Posting Date" := Today;
                                GuarantorAllocation.Insert;
                                GuarantorAllocation.Validate(GuarantorAllocation."Member No");
                                GuarantorAllocation.Validate(GuarantorAllocation."Loan No.");
                                GuarantorAllocation.Modify;
                            end;
                        until LoanGuar.Next = 0;
                    end;
                    LoansRec.Posted := true;
                    LoansRec."Attachement Date" := Today;
                    Modify;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Loan PayOff Nos");
            //   NoSeriesMgt.InitSeries(SalesSetup."Loan PayOff Nos", xRec."No. Series", 0D, "Document No", "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        Cust: Record Customer;
        LoanDetails: Record "Guarantors Member Loans";
        LoanRec: Record "Loans Register";
        LoanGuarantors: Record "Loans Guarantee Details";
        PayOffDetails: Record "Loans PayOff Details";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        LoansRec: Record "Loans Register";
        TotalRecovered: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        GLoanDetails: Record "Guarantors Member Loans";
        TotalOustanding: Decimal;
        ClosingDepositBalance: Decimal;
        RemainingAmount: Decimal;
        LoansR: Record "Loans Register";
        AMOUNTTOBERECOVERED: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PDate: Date;
        Interest: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        TextDateFormula2: Text[30];
        TextDateFormula1: Text[30];
        DateFormula2: DateFormula;
        DateFormula1: DateFormula;
        Vend: Record Vendor;
        LoanGuar: Record "Loans Guarantee Details";
        Lbal: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        Hesabu: Integer;
        Loanapp: Record "Loans Register";
        "Loan&int": Decimal;
        TotDed: Decimal;
        Available: Decimal;
        Distributed: Decimal;
        WINDOW: Dialog;
        SHARES: Decimal;
        TOTALLOANS: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        LineN: Integer;
        instlnclr: Decimal;
        appotbal: Decimal;
        LOANAMOUNT: Decimal;
        PRODATA: Decimal;
        LOANAMOUNT2: Decimal;
        TOTALLOANSB: Decimal;
        NETSHARES: Decimal;
        Tinst: Decimal;
        Finst: Decimal;
        Floans: Decimal;
        GrAmount: Decimal;
        TGrAmount: Decimal;
        FGrAmount: Decimal;
        LOANBAL: Decimal;
        Serie: Integer;
        DLN: Code[50];
        "LN Doc": Code[20];
        INTBAL: Decimal;
        COMM: Decimal;
        loanTypes: Record "Loan Products Setup";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        MemberNoEditable: Boolean;
        RecoveryTypeEditable: Boolean;
        Global1Editable: Boolean;
        Global2Editable: Boolean;
        LoantoAttachEditable: Boolean;
        GuarantorLoansDetailsEdit: Boolean;
        GuarantorAllocation: Record "Guarantors Member Loans";
}