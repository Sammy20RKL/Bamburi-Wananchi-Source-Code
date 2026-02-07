table 52061 "HR Leave Ledger Entries New"
{
    DrillDownPageId = "HR Leave Ledger Entries";
    LookupPageId = "HR Leave Ledger Entries";
    DataClassification = CustomerContent;
    Caption = 'HR Leave Ledger Entries';
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Leave Period"; Date)
        {
            Caption = 'Leave Period';
        }
        field(3; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(4; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            Editable = false;
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin

                if Employee.Get("Staff No.") then begin
                    "Staff Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                end;
            end;
        }
        field(5; "Staff Name"; Text[70])
        {
            Caption = 'Staff Name';
        }
        field(6; "Leave Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(7; "Leave Entry Type"; Option)
        {
            Caption = 'Leave Entry Type';
            OptionCaption = 'Positive,Negative';
            OptionMembers = Positive,Negative;

            trigger OnValidate()
            begin

                if "Leave Entry Type" = "Leave Entry Type"::Negative then
                    "No. of days" := -"No. of days"
                else
                    "No. of days" := "No. of days";
            end;
        }
        field(8; "Leave Approval Date"; Date)
        {
            Caption = 'Leave Approval Date';
        }
        field(9; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(10; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(11; "Job ID"; Code[70])
        {
            Caption = 'Job ID';
        }
        field(12; "Job Group"; Code[20])
        {
            Caption = 'Job Group';
        }
        field(13; "Contract Type"; Code[20])
        {
            Caption = 'Contract Type';
        }
        field(14; "No. of days"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'No. of days';
        }
        field(15; "Leave Start Date"; Date)
        {
            Caption = 'Leave Start Date';
        }
        field(16; "Leave Posting Description"; Text[50])
        {
            Caption = 'Leave Posting Description';
        }
        field(17; "Leave End Date"; Date)
        {
            Caption = 'Leave End Date';
        }
        field(18; "Leave Return Date"; Date)
        {
            Caption = 'Leave Return Date';
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(21; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(22; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(23; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User;

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            begin
                //LoginMgt.LookupUserID("User ID");
            end;
        }
        field(24; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(25; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(26; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(27; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry';
        }
        field(28; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(29; "Leave Recalled No."; Code[20])
        {
            Caption = 'Leave Application No.';
            TableRelation = "Leave Application"."Employee No" where("Employee No" = field("Staff No."),
                                                                     Status = const(Released));
        }
        field(30; "Leave Type"; Code[20])
        {
            TableRelation = "Leave Type".Code;
            Caption = 'Leave Type';

            trigger OnValidate()
            begin

                if LeaveType.Get("Leave Type") then;

            end;
        }
        field(31; "Transaction Type"; Enum "Leave Transaction Type")
        {
            Caption = 'Transaction Type';
        }
        field(33; "Leave Application No."; Code[20])
        {
            Caption = 'Leave Application No.';
            TableRelation = "Leave Application"."Application No";

            trigger OnValidate()
            begin

                /*
                
                if "Leave Application No." = '' then begin
                  CreateDim(Database::Insurance,"Leave Application No.");
                  exit;
                end;
                LeaveApplic.Reset();
                LeaveApplic.SetRange(LeaveApplic."Application No","Leave Application No.");
                if LeaveApplic.Find('-')then begin
                //LeaveApplic.GET("Leave Application No.");
                //LeaveApplic.TESTFIELD(Blocked,FALSE);
                "Leave Posting Description":= LeaveApplic.Comments;
                "Leave Approval Date":=LeaveApplic."Start Date";
                "No. of days":=LeaveApplic."Approved Days";
                "Leave Type":=LeaveApplic."Leave Code";
                end;
                CreateDim(Database::"Leave Application","Leave Application No.");
                
                */

            end;
        }
        field(34; Entitlement; Decimal)
        {
            Caption = 'Entitlement';
        }
        field(35; "Balance Brought Forward"; Decimal)
        {
            Caption = 'Balance Brought Forward';
        }
        field(36; "Leave Assignment"; Boolean)
        {
            Caption = 'Leave Assignment';
        }
        field(37; "Leave Period Code"; Code[20])
        {
            TableRelation = "Leave Period";
            Caption = 'Leave Period Code';
        }
        field(38; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region".Code;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Document No.", "Staff No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HR Employees";
        LeaveType: Record "Leave Type";

    procedure CreateDim(Type1: Integer; No1: Code[20])
    begin
        /*TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        DimMgt.GetDefaultDim(
          TableID,No,"Source Code",
          "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        if "Line No." <> 0 then
          DimMgt.UpdateJnlLineDefaultDim(
            Database::Table5635,
            "Journal Template Name","Journal Batch Name","Line No.",0,
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
          */

    end;

    procedure GetNextEntryNo() EntryNo: Integer
    begin
        LockTable();
        if FindLast() then
            EntryNo := "Entry No." + 1
        else
            EntryNo := 1;
    end;
}





