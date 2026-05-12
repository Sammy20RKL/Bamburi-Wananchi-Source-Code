table 52014 "Leave Planner Header"
{
    Caption = 'Leave Planner Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Leave Period"; Code[20])
        {
            Caption = 'Leave Period';
            DataClassification = CustomerContent;
            TableRelation = "Leave Period"."Leave Period Code";

            trigger OnValidate()
            begin
                LeavePlannerRec.Reset();
                LeavePlannerRec.SetRange("Leave Period", "Leave Period");
                if LeavePlannerRec.FindFirst()
                then
                    Error(LeavePeriodExistsErr, LeavePlannerRec."No.", "Leave Period");
            end;
        }
        field(3; Status; Enum "Approval Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(4; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        HRSetup: Record "Human Resources Setup";
        LeavePlannerRec: Record "Leave Planner Header";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        LeavePeriodExistsErr: Label 'Another Leave Planner Document %1 for %2 Leave Period already exists';

    trigger OnInsert()
    begin
        HRSetup.Get();
        HRSetup.Testfield("Leave Plan Nos");
        //NoSeriesMgt.InitSeries(HRSetup."Leave Plan Nos", xRec."No. Series", 0D, "No.", "No. Series");
    end;
}






