table 52003 "Leave Period"
{
    DrillDownPageID = "Leave Periods";
    LookupPageID = "Leave Periods";
    DataClassification = CustomerContent;
    Caption = 'Leave Period';
    fields
    {
        field(1; "Leave Period Code"; Code[20])
        {
            Caption = 'Leave Period Code';
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(4; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Leave Period Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Leave Period Code", Description) { }
    }

    trigger OnDelete()
    var
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries Lv";
        LeaveLedgerEntriesWarningMsg: Label 'There are leave ledger entries associated with this leave period. Do you want to delete the leave period and its associated leave ledger entries?';
        CannotDeleteLeavePeriodErr: Label 'You cannot delete this leave period because it has associated leave ledger entries.';
    begin
        HRLeaveLedgerEntries.Reset();
        HRLeaveLedgerEntries.SetRange("Leave Period Code", Rec."Leave Period Code");
        if not HRLeaveLedgerEntries.IsEmpty() then begin
            if Confirm(LeaveLedgerEntriesWarningMsg, false) then
                HRLeaveLedgerEntries.DeleteAll()
            else
                Error(CannotDeleteLeavePeriodErr);
        end;
    end;
}





