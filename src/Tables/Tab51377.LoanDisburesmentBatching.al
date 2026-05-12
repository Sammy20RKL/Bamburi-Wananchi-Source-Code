#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51377 "Loan Disburesment-Batching"
{
    DrillDownPageID = "Loans Disbursment Batch List";
    LookupPageID = "Loans Disbursment Batch List";

    fields
    {
        field(1; "Batch No."; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                if "Batch No." <> xRec."Batch No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loans Batch Nos");
                    "No. Series" := '';
                end;
                //FnValidateAmount("Batch No.");
            end;
        }
        field(2; "Description/Remarks"; Text[150])
        {
        }
        field(3; Posted; Boolean)
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",,Approved,Rejected;
        }
        field(5; "Date Created"; Date)
        {
        }
        field(6; "Posting Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Batch No." <> '' then begin
                    LoanApps.Reset;
                    LoanApps.SetRange("Batch No.", "Batch No.");
                    if LoanApps.FindFirst() then begin
                        "Posting Date" := LoanApps."Issued Date";
                        if "Posting Date" = LoanApps."Issued Date" then
                            Error('Posting Date should Be Same As Issue Date');
                    end;
                end;
            end;
        }
        field(7; "Posted By"; Code[20])
        {
        }
        field(8; "Prepared By"; Code[20])
        {
        }
        field(9; Date; Date)
        {
        }
        field(10; "Mode Of Disbursement"; Option)
        {
            OptionCaption = 'Individual Cheques,Cheque,MPESA,EFT,RTGS';
            OptionMembers = "Individual Cheques",Cheque,MPESA,EFT,RTGS;
        }
        field(11; "Document No."; Code[20])
        {
        }
        field(12; "BOSA Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                /* IF ("Mode Of Disbursement"="Mode Of Disbursement"::"FOSA Loans") OR  ("Mode Of Disbursement"="Mode Of Disbursement"::"Transfer to FOSA") THEN
                 ERROR('Cannot be used with this disbursemnt method %1',"Mode Of Disbursement");
                                                                                                 */

            end;
        }
        field(13; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; "Approvals Remarks"; Text[150])
        {
        }
        field(15; "Total Loan Amount"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Approved Amount" where("Batch No." = field("Batch No."),
                                                                        "Loan Status" = filter(<> Rejected),
                                                                        Source = filter(BOSA | " "),
                                                                        "Loan Product Type" = filter(<> 'BRIDGING')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Current Location"; Code[50])
        {
            CalcFormula = max("Movement Tracker".Station where("Document No." = field("Batch No.")));
            Editable = true;
            FieldClass = FlowField;
        }
        field(17; "Cheque No."; Code[20])
        {
        }
        field(18; "Batch Type"; Option)
        {
            OptionMembers = Loans,"Bridging Loans","Personal Loans",Refunds,"Funeral Expenses","Withdrawals - Resignation","Withdrawals - Death","Branch Loans",Journals,"File Movement","Appeal Loans";

            trigger OnValidate()
            begin
                EntryNo := 0;


                /*
                ApprovalsSetup.RESET;
                ApprovalsSetup.SETRANGE(ApprovalsSetup."Approval Type","Batch Type");
                IF ApprovalsSetup.FIND('-') THEN BEGIN
                MovementTracker.INIT;
                MovementTracker."Entry No.":=EntryNo;
                MovementTracker."Document No.":="Batch No.";
                MovementTracker."Approval Type":=ApprovalsSetup."Approval Type";
                MovementTracker.Stage:=ApprovalsSetup.Stage;
                MovementTracker."Current Location":=TRUE;
                MovementTracker.Status:=MovementTracker.Status::"Being Processed";
                MovementTracker.Description:=ApprovalsSetup.Description;
                MovementTracker.Station:=ApprovalsSetup.Station;
                MovementTracker."Date/Time In":=CREATEDATETIME(TODAY,TIME);
                MovementTracker.INSERT(TRUE);*/




                if "Batch Type" = "batch type"::"Bridging Loans" then
                    "Mode Of Disbursement" := "mode of disbursement"::Cheque;

            end;
        }
        field(19; "Special Advance Posted"; Boolean)
        {
        }
        field(20; "FOSA Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(21; "No of Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Batch No." = field("Batch No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Post to Loan Control"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Batch Type" <> "batch type"::"Branch Loans" then
                    Error('Only applicable for branch loans');
            end;
        }
        field(23; "Total Appeal Amount"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Appeal Amount" where("Batch No." = field("Batch No."),
                                                                      "Loan Status" = filter(<> Rejected),
                                                                      Source = const(" ")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; Source; Option)
        {
            OptionCaption = 'BOSA,FOSA,MICRO';
            OptionMembers = BOSA,FOSA,MICRO;
        }
        field(25; Location; Code[50])
        {
            CalcFormula = max("Movement Tracker".Station where("Document No." = field("Batch No."),
                                                                "Current Location" = const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Finance Approval"; Boolean)
        {
        }
        field(27; "Audit Approval"; Boolean)
        {
        }
        field(28; "Cheque Name"; Text[60])
        {
        }
        field(29; "No transfer Fee"; Boolean)
        {
        }
        field(30; "Global Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(31; "Global Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(32; "EFT Fee"; Boolean)
        {
        }
        field(33; "Amount to bank"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Payment Voucher Printed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Partial Disbursement"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
    }

    keys
    {
        key(Key1; "Batch No.")
        {
            Clustered = true;
        }
        key(Key2; "Description/Remarks")
        {
        }
        key(Key3; Date)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*IF Posted = TRUE THEN
        ERROR('You can not delete a posted batch.');
        */

    end;

    trigger OnInsert()
    begin
        if "Batch No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(SalesSetup."Loans Batch Nos");
            // NoSeriesMgt.InitSeries(SalesSetup."Loans Batch Nos", xRec."No. Series", 0D, "Batch No.", "No. Series");
            "Document No." := "Batch No.";
        end;
        //ERROR('You dont have permission to create %1 batches',"Batch Type")
        "Mode Of Disbursement" := "mode of disbursement"::RTGS;
        "Posting Date" := Today;
        "Description/Remarks" := Format(Today);
    end;

    trigger OnModify()
    begin
        /*IF Posted = TRUE THEN
        ERROR('You can not modify a posted batch.');
           */

    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        EntryNo: Integer;
        LoanApps: Record "Loans Register";

    local procedure FnValidateAmount(batchNo: Code[20])
    var
        InsuranceAMt: Decimal;
        LoanApps: Record "Loans Register";
        disAmount: Decimal;
    begin
        // IF "Batch No."<>'' THEN BEGIN
        // LoanApps.RESET;
        // LoanApps.SETRANGE("Batch No.",batchNo);
        // IF LoanApps.FINDFIRST() THEN BEGIN
        //  LoanApps.CALCFIELDS(LoanApps."Top Up Amount",LoanApps."Topup iNTEREST");
        //  IF LoanApps."Top Up Amount" >0 THEN BEGIN
        //     IF LoanApps.Refinancing THEN
        //     disAmount:=LoanApps."Approved Amount"*-1+InsuranceAMt+LoanApps."Boosted Amount"+LoanApps."Boosting Commision"
        //     ELSE
        //      disAmount:=-1*(LoanApps."Approved Amount"-LoanApps."Top Up Amount"-ROUND(InsuranceAMt,0.01,'=')-ROUND(LoanApps."Total TopUp Commission",0.01,'=')-LoanApps."Boosted Amount"-LoanApps."Boosting Commision");
        //     END ELSE BEGIN
        //      disAmount:=LoanApps."Approved Amount"*-1+ROUND(InsuranceAMt,0.01,'=')+ROUND(LoanApps."Topup Commission",0.01,'=')+LoanApps."Boosted Amount"+LoanApps."Boosting Commision";
        //     END;
        //     "Amount to bank":=disAmount;
        // END;
        // END;
    end;
}

