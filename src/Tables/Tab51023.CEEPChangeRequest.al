#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51023 "CEEP Change Request"
{

    DrillDownPageId = "CEEP Change Request List";
    LookupPageId = "CEEP Change Request List";
    fields
    {
        field(1; No; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Change Request No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Microfinance Change';
            OptionMembers = " ","Microfinance Change";

            trigger OnValidate()
            begin

            end;
        }
        field(3; "Account No"; Code[50])
        {
            TableRelation =
            if (Type = filter("Microfinance Change")) Customer."No." where("Customer Posting Group" = filter('MICRO'));

            trigger OnValidate()
            begin
            end;
        }
        field(6; "No. Series"; Code[30])
        {
        }
        field(8; Branch; Code[30])
        {
        }
        field(17; Status; enum "Record Status")
        {
        }

        field(27; "Reason for change"; Text[50])
        {
        }

        field(42; "Monthly Contributions"; Decimal)
        {
        }
        field(43; "Captured by"; Code[50])
        {
            Editable = false;
        }
        field(44; "Capture Date"; Date)
        {
            Editable = false;
        }
        field(46; "Approved by"; Code[50])
        {
            Editable = false;
        }
        field(47; "Approval Date"; Date)
        {
            Editable = false;
        }
        field(48; Changed; Boolean)
        {
            Editable = false;
        }
        field(52; "Group Account No"; Code[30])
        {
            TableRelation = Customer."No." where("Group Account" = filter(true));
        }
        field(119; "Micro Finance Change Type"; Option)
        {
            OptionCaption = ' ,CEEP Member,CEEP Group,Signatories';
            OptionMembers = " ","CEEP Member","CEEP Group",Signatories;
        }
        //.............................Ceep member details that could be changed
        field(120; "CEEP Member No"; code[50])
        {
            TableRelation = Customer."No." where("Customer Posting Group" = const('MICRO'), "Group Account" = const(false));
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                Cust.Reset();
                Cust.SetRange(Cust."No.", "CEEP Member No");
                if Cust.find('-') then begin
                    "CEEP Member Name" := cust.Name;
                    "CEEP Member Group Account" := cust."Group Account No";
                    "CEEP Member Group Name" := cust."Group Account Name";
                    "CEEP Member ID" := cust."ID No.";
                    "CEEP Member Phone No" := cust."Phone No.";
                end;
            end;
        }
        field(121; "CEEP Member Name"; text[100])
        {
            Editable = false;
        }
        field(1000; "CEEP Member Name(New)"; text[100])
        {

        }
        field(122; "CEEP Member Group Account"; code[50])
        {

        }
        field(123; "CEEP Member Group Account(New)"; code[50])
        {
            TableRelation = Customer."No." where("Account Category" = filter(Group | Joint), "Customer Posting Group" = const('MICRO'));
            trigger OnValidate()
            var
                cust: Record Customer;
            begin
                Cust.Reset();
                Cust.SetRange(Cust."No.", "CEEP Member Group Account(New)");
                if Cust.find('-') then begin
                    "CEEP Member Group Name(New)" := cust."Group Account Name";
                end;
            end;
        }
        field(124; "CEEP Member Group Name"; text[100])
        {
        }
        field(125; "CEEP Member Group Name(New)"; text[100])
        {

        }
        field(1001; "CEEP Member ID(New)"; code[50])
        {

        }
        field(1002; "CEEP Member ID"; code[50])
        {

        }
        field(1003; "CEEP Member Phone No(New)"; Text[50])
        {

        }
        field(1004; "CEEP Member Phone No"; text[50])
        {

        }
        //.............................Ceep Group details that could be changed
        field(126; "CEEP Group No"; code[50])
        {
            Enabled = true;
            TableRelation = Customer."No." where("Account Category" = filter(Group | Joint), "Customer Posting Group" = const('MICRO'));
            trigger OnValidate()
            var
                cust: Record Customer;
            begin
                Cust.Reset();
                Cust.SetRange(Cust."No.", "CEEP Group No");
                if Cust.find('-') then begin
                    "CEEP Group Name" := cust."Group Account Name";
                    "CEEP Group Officer" := cust."Loan Officer Name";
                    "CEEP Branch" := cust."Global Dimension 2 Code";
                    "CEEP Certificate" := cust."ID No.";
                end;
            end;
        }
        field(127; "CEEP Group Name"; text[100])
        {
            Editable = false;
        }
        field(128; "CEEP Group Officer"; code[50])
        {
            Editable = false;
        }
        field(129; "CEEP Group Officer(New)"; code[50])
        {
            TableRelation = "Loan Officers Details";
            trigger OnValidate()
            var
                LoanOfficer: record "Loan Officers Details";
            begin
                LoanOfficer.Reset();
                LoanOfficer.SetRange(LoanOfficer."Account No.", "CEEP Group Officer(New)");
                if LoanOfficer.Find('-') then begin
                    "CEEP Group Officer Name(New)" := LoanOfficer.Name;
                end;
            end;
        }
        field(1050; "CEEP Group Officer Name(New)"; text[100])
        {
        }
        field(130; "CEEP Certificate"; code[50])
        {
            Editable = false;
        }
        field(131; "CEEP Certificate(New)"; code[50])
        {

        }
        field(133; "CEEP Branch"; code[50])
        {
            Editable = false;
        }
        field(132; "CEEP Branch(New)"; code[50])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
            end;
        }
        //.............................Ceep Group Signatories that could be changed
        field(1051; "Group Accounts No"; code[50])
        {
            TableRelation = customer."No.";
            trigger OnValidate()
            var
                CustTable: Record Customer;
            begin
                CustTable.Reset();
                CustTable.SetRange(CustTable."No.", "Group Accounts No");
                if CustTable.Find('-') then begin
                    "Group Accounts Name" := CustTable.Name;
                end;
            end;
        }
        field(1052; "Group Accounts Name"; Text[150])
        {
            Editable = false;
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

    trigger OnInsert()
    begin


        if No = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Change Request No");
            // NoSeriesMgt.InitSeries(SalesSetup."Change Request No", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Captured by" := UserId;
        "Capture Date" := Today;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        vend: Record Vendor;
        Memb: Record Customer;
        MemberCell: Record "Hexa Binary";
        SFactory: Codeunit "Swizzsoft Factory";
        MediaId: Guid;
        Dates: Codeunit "Dates Calculation";
        MemmberExit: Record "Membership Withdrawals";
        Bankbranch: Record "Bank Branch";
        PostCodes: Record "Post Code";
}

