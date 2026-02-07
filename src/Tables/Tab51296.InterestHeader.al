#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51296 "Interest Header"
{
    // DrillDownPageID = 39004414;
    // LookupPageID = 39004414;

    fields
    {
        field(1; "No."; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin

                if "No." <> xRec."No." then begin
                    NoSetup.Get;
                    NoSeriesMgt.TestManual(NoSetup."Billing Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Document No."; Code[30])
        {
            Editable = true;
        }
        field(4; "Distributed Amount"; Decimal)
        {
            CalcFormula = sum("Loans Interest"."Monthly Repayment" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(7; Cashier; Code[30])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(8; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",,Approved,Rejected;
        }
        field(9; "Posted By"; Code[100])
        {
        }
        field(10; "Time Posted"; Time)
        {
        }
        field(11; Description; Text[30])
        {
        }
        field(12; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(13; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(14; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(15; "Employer Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(16; "loan Issued Date"; Date)
        {
        }
        field(17; "Bill Loan"; Boolean)
        {
            InitValue = true;
        }
        field(18; "Charge Interest"; Boolean)
        {
            InitValue = true;
        }
        field(20; "Interest Due Date"; Date)
        {
            Caption = 'Interest Due Date';
            TableRelation = "Interest Due Period" where(Closed = filter(false));

            trigger OnValidate()
            begin
                //Name := FORMAT("Interest Due Date",0,Text000);
                Description := 'Int Due' + ' ' + CopyStr(Format("Interest Due Date", 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy("Interest Due Date", 3));
                "Document No." := 'IntDue' + '-' + CopyStr(Format("Interest Due Date", 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy("Interest Due Date", 3));
            end;
        }
        field(21; "Charge Penalty"; Boolean)
        {
        }
        field(22; "Start Date"; Date)
        {
        }
        field(23; "End Date"; Date)
        {
        }
        field(24; "Application Type"; Option)
        {
            OptionCaption = ' ,Loan Interest,Transfer Interest(G/L),Transfer Interest(Banking)';
            OptionMembers = " ","Loan Interest","Transfer Interest(G/L)","Transfer Interest(Banking)";
        }
        field(25; "Loan Count"; Integer)
        {
            CalcFormula = count("Loans Interest" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Interest Total"; Decimal)
        {
            CalcFormula = sum("Loans Interest"."Interest Bill" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Posted Loans"; Integer)
        {
            CalcFormula = count("Loans Interest" where(No = field("No."),
                                                        Posted = const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Billing Nos.");
            //  NoSeriesMgt.InitSeries(NoSetup."Billing Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        Cashier := UserId;
        "Document No." := "No.";
        /*
        UserSetup.RESET;
        UserSetup.SETRANGE(UserSetup."User ID",USERID);
        IF UserSetup.FIND('-') THEN BEGIN
        UserSetup.TESTFIELD(UserSetup."Office/Group");
        UserSetup.TESTFIELD(UserSetup."Global Dimension 1 Code");
        UserSetup.TESTFIELD(UserSetup."Shortcut Dimension 2 Code");
        "Responsibility Center":=UserSetup."Office/Group";
        "Acitvity Code":=UserSetup."Global Dimension 1 Code";
        "Branch Code":=UserSetup."Shortcut Dimension 2 Code";
        END;
        */

    end;

    var
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        NoSetup: Record "Sacco No. Series";
        CUST: Record Customer;
}

