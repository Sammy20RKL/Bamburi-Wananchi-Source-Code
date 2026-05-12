#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51295 "Loans Interest"
{
    // DrillDownPageID = 50755;
    // LookupPageID = 50755;

    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;
        }
        field(2; "Account No"; Code[20])
        {
            Editable = false;
        }
        field(3; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit,Member';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit,Member;
        }
        field(4; "Interest Date"; Date)
        {
        }
        field(5; "Interest Amount"; Decimal)
        {
        }
        field(6; "User ID"; Code[100])
        {
        }
        field(8; "Account Matured"; Boolean)
        {
        }
        field(9; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; "Late Interest"; Boolean)
        {
        }
        field(11; Transferred; Boolean)
        {
        }
        field(12; "Mark For Deletion"; Boolean)
        {
        }
        field(13; Description; Text[80])
        {
        }
        field(14; Posted; Boolean)
        {
        }
        field(15; "Loan No."; Code[50])
        {
            Editable = false;
            TableRelation = "Loans Register";
        }
        field(16; "Loan Product type"; Code[10])
        {
            Editable = false;
            TableRelation = "Loan Products Setup";
        }
        field(17; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,None,Staff';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None",Staff;
        }
        field(18; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(19; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(20; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            Editable = false;
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else if ("Bal. Account Type" = const(Customer)) Customer
            else if ("Bal. Account Type" = const(Vendor)) Vendor
            else if ("Bal. Account Type" = const("Bank Account")) "Bank Account"
            else if ("Bal. Account Type" = const("IC Partner")) "IC Partner"
            else if ("Bal. Account Type" = const(Member)) "Membership Applications";
        }
        field(21; Blocked; Option)
        {
            Caption = 'Blocked';
            Editable = false;
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(22; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Apportioned,Suspended,Awaiting Verdict,New';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Apportioned,Suspended,"Awaiting Verdict",New;
        }
        field(23; "Issued Date"; Date)
        {
            Editable = false;
        }
        field(24; "Bill Loan"; Boolean)
        {
        }
        field(25; "Charge Interest"; Boolean)
        {
        }
        field(26; "Repayment Amount"; Decimal)
        {
        }
        field(27; "Monthly Repayment"; Decimal)
        {
        }
        field(28; "Bill Account"; Code[20])
        {
            Caption = 'Bill Account';
            Editable = false;
            TableRelation = "G/L Account"."No.";
        }
        field(31; "Repayment Bill"; Decimal)
        {
            Description = 'a';
        }
        field(32; "Interest Bill"; Decimal)
        {
        }
        field(33; "Outstanding Interest"; Decimal)
        {
            Editable = false;
        }
        field(34; "Outstanding Balance"; Decimal)
        {
            Editable = false;
        }
        field(35; "Appraisal Amount"; Decimal)
        {
        }
        field(36; "Date Captured"; Date)
        {
        }
        field(37; "Bal. Account No.(Suspended)"; Code[100])
        {
            Caption = 'Bal. Account No.';
            Editable = false;
            TableRelation = "G/L Account"."No.";
        }
        field(38; "Auto Billing"; Boolean)
        {
        }
        field(39; "Auto Interest"; Boolean)
        {
        }
        field(40; Reversed; Boolean)
        {
        }
        field(41; "Interest Rate"; Decimal)
        {
            CalcFormula = lookup("Loans Register".Interest where("Loan  No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(42; "Bosa No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No, "Loan No.", "Interest Date")
        {
            Clustered = true;
        }
        key(Key2; "Interest Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
          IF No = '' THEN BEGIN
          NoSetup.GET(0);
          NoSetup.TESTFIELD(NoSetup."Interest Buffer No");
          NoSeriesMgt.InitSeries(NoSetup."Interest Buffer No",xRec."No. Series",0D,No,"No. Series");
          END;
        */

    end;

    var
        NoSetup: Record "Purchases & Payables Setup";
    //NoSeriesMgt: Codeunit NoSeriesManagement;
}

