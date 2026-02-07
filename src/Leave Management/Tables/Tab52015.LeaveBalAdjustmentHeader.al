table 52015 "Leave Bal Adjustment Header"
{
    DrillDownPageId = "Leave Adjustment List";
    LookupPageId = "Leave Adjustment List";
    //DataClassification = CustomerContent;
    Caption = 'Leave Bal Adjustment Header';
    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = false;
            Caption = 'Code';
        }
        field(3; "Maturity Date"; Date)
        {
            Editable = false;
            Caption = 'Maturity Date';
        }
        field(4; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(5; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(6; "Posted By"; Code[50])
        {
            Editable = false;
            Caption = 'Posted By';
        }
        field(7; "Posted Date"; Date)
        {
            Editable = false;
            Caption = 'Posted Date';
        }
        field(8; EnteredBy; Code[50])
        {
            Editable = false;
            Caption = 'EnteredBy';

            trigger OnValidate()
            begin

                if EnteredBy = '' then
                    EnteredBy := UserId;
            end;
        }
        field(9; Comments; Text[100])
        {
            Caption = 'Comments';
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(11; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Leave Brought Forward,Leave Adjustment';
            OptionMembers = " ","Leave Brought Forward","Leave Adjustment";
            Caption = 'Transaction Type';
        }
        field(12; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open,"Pending Approval",Released,Rejected;
            Caption = 'Status';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Leave Adjustment Nos");
            //NoSeriesMgt.InitSeries(HRSetup."Leave Adjustment Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;

        EnteredBy := UserId;

        AccPeriod.Reset();
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+') then
            MaturityDate := CalcDate('1Y', AccPeriod."Starting Date") - 1;

        "Maturity Date" := MaturityDate;
    end;

    var
        AccPeriod: Record "Accounting Period";
        HRSetup: Record "Human Resources Setup";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        MaturityDate: Date;
}





