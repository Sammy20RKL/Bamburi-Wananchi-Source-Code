#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51481 "Checkoff Header-Distributed2"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Checkoff-Proc Distributed Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
        }
        field(3; Posted; Boolean)
        {
            Editable = true;
        }
        field(6; "Posted By"; Code[60])
        {
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
        }
        field(9; "Entered By"; Text[60])
        {
        }
        field(10; Remarks; Text[150])
        {
        }
        field(19; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Time Entered"; Time)
        {
        }
        field(21; "Posting date"; Date)
        {

            trigger OnValidate()
            begin
                Remarks := FnGetCheckOffDescription();
            end;
        }
        field(22; "Account Type"; Option)
        {
            OptionCaption = 'Employer';
            OptionMembers = Customer;
        }
        field(23; "Account No"; Code[30])
        {
            TableRelation = Customer."No." where("Customer Posting Group" = const('EMPLOYER'));

            trigger OnValidate()
            begin
                // if "Account Type"="account type"::"1" then begin
                // CustDeb.Reset;
                // CustDeb.SetRange(CustDeb."No.","Account No");
                // if CustDeb.Find('-') then begin
                // "Employer Name":=CustDeb.Name;
                // "Account No":=CustDeb."No.";
                // end;
                // end;

                if "Account Type" = "account type"::Customer then begin
                    "GL Account".Reset;
                    "GL Account".SetRange("GL Account"."No.", "Account No");
                    if "GL Account".Find('-') then begin
                        "Account Name" := "GL Account".Name;
                    end;
                end;

                // if "Account Type" = "account type"::"3" then begin
                //     BANKACC.Reset;
                //     BANKACC.SetRange(BANKACC."No.", "Account No");
                //     if BANKACC.Find('-') then begin
                //         "Account Name" := BANKACC.Name;

                //     end;
                // end;
            end;
        }
        field(24; "Document No"; Code[20])
        {
        }
        field(25; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                /*
              IF Amount<>"Scheduled Amount" THEN
              ERROR('The Amount must be equal to the Scheduled Amount');
                  */

            end;
        }
        field(27; "Total Count"; Integer)
        {
            CalcFormula = count("Checkoff Lines-Distributed2" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;
        }
        field(28; "Account Name"; Code[50])
        {
        }
        field(29; "Employer Code"; Code[30])
        {
            TableRelation = "Sacco Employers".Code;

            trigger OnValidate()
            begin
                SaccoEmployers.Reset;
                SaccoEmployers.SetRange(Code, "Employer Code");
                if SaccoEmployers.Find('-') then
                    "Employer Name" := SaccoEmployers.Description;
            end;
        }
        field(30; "Un Allocated amount-surplus"; Decimal)
        {
        }
        field(31; "Employer Name"; Text[100])
        {
        }
        field(32; "Loan CutOff Date"; Date)
        {
        }
        field(34; "Employer No.(Old)"; Code[20])
        {
            TableRelation = if ("Account Type" = const(Customer)) Customer."Our Account No.";
        }
        field(35; "Total Scheduled"; Decimal)
        {
            CalcFormula = sum("Checkoff Lines-Distributed2".Amount where("Receipt Header No" = field(No)));
            FieldClass = FlowField;
        }
        field(36; "CheckOff Period"; Date)
        {
            TableRelation = "Checkoff Calender."."Date Opened";

            trigger OnValidate()
            begin
                ObjReceiptLines.Reset;
                ObjReceiptLines.SetRange(ObjReceiptLines."Account Code", "Account No");
                ObjReceiptLines.SetRange(ObjReceiptLines."Employer Remmitance", true);
                ObjReceiptLines.SetRange(ObjReceiptLines."Checkoff Period", "CheckOff Period");
                if ObjReceiptLines.Find('-') then begin
                    Amount := ObjReceiptLines.Amount;
                    Modify(true);
                end else
                    Message('No remmitence bellonging to this employer has been posted')
            end;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted = true then
            Error('You cannot delete a Posted Check Off');
    end;

    trigger OnInsert()
    begin

        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Checkoff-Proc Distributed Nos");
            //  NoSeriesMgt.InitSeries(NoSetup."Checkoff-Proc Distributed Nos", xRec."No. Series", 0D, No, "No. Series");
        end;
        "Account Type" := "account type"::Customer;
        "Date Entered" := Today;
        "Posting date" := Today;
        "Time Entered" := Time;
        "Entered By" := UpperCase(UserId);
        FnGetCheckOffDescription();
    end;

    trigger OnModify()
    begin

        if Posted = true then
            Error('You cannot modify a Posted Check Off');
    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('You cannot modify a Posted Check Off');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        cust: Record Customer;
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
        CustDeb: Record Customer;
        ObjReceiptLines: Record "Receipt Line";
        SaccoEmployers: Record "Sacco Employers";

    local procedure FnGetCheckOffDescription() rtVal: Text
    begin
        case Date2dmy("Posting date", 2) of
            1:
                rtVal := 'JAN';
            2:
                rtVal := 'FEB';
            3:
                rtVal := 'MAR';
            4:
                rtVal := 'APR';
            5:
                rtVal := 'MAY';
            6:
                rtVal := 'JUNE';
            7:
                rtVal := 'JULY';
            8:
                rtVal := 'AUG';
            9:
                rtVal := 'SEPT';
            10:
                rtVal := 'OCT';
            11:
                rtVal := 'NOV';
            12:
                rtVal := 'DEC';

        end;
        exit('CKF' + rtVal + '-' + Format(Date2dmy("Posting date", 3)));
    end;
}

