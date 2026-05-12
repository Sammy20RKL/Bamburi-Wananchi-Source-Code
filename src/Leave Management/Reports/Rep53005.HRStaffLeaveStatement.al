report 53005 "HR Staff Leave Statement"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './layout/HRStaffLeaveStatement.rdl';
    Caption = 'HR Staff Leave Statement';
    dataset
    {
        dataitem("HR Leave Ledger Entries"; "HR Leave Ledger Entries Lv")
        {
            RequestFilterFields = "Staff No.", "Leave Type", "Leave Date";
            column(Noofdays_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."No. of days")
            {
            }
            column(PostingDate_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Date")
            {
            }
            column(Balance; Balance)
            {
            }
            column(LeaveEntryType_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Entry Type")
            {
            }
            column(LeaveType_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Type")
            {
            }
            column(StaffNo_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Staff No.")
            {
            }
            column(StaffName_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Staff Name")
            {
            }
            column(DocumentNo_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Document No.")
            {
            }
            column(LeavePeriodCode_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Leave Period Code")
            {
            }
            column(TransactionType_HRLeaveLedgerEntries; "HR Leave Ledger Entries"."Transaction Type")
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }

            //RequestFilterFields = "Staff No.", "Leave Type", "Leave Period Code";
            trigger OnAfterGetRecord()
            begin


            end;

            trigger OnPreDataItem()
            begin

                // HREmp.RESET;
                // HREmp.SETRANGE(HREmp."User ID",USERID);
                // IF HREmp.FIND('-') THEN
                // BEGIN
                //    "HR Leave Ledger Entries".SETFILTER("HR Leave Ledger Entries"."Staff No.",HREmp."No.")
                // END ELSE
                // BEGIN
                //    ERROR('UserID %1 not found in employees table',USERID);
                // END;
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }
    labels
    {
    }

    trigger OnPreReport()
    begin
        CI.Reset();
        CI.Get();

        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        Balance: Decimal;
}


