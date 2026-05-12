#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51706 "Checkoff Advice"
{
    // DrillDownPageID = 50769;
    // LookupPageID = 50769;

    fields
    {
        field(1; No; Code[40])
        {
        }
        field(2; "Approved By"; Code[40])
        {
        }
        field(3; "Captured By"; Code[40])
        {
        }
        field(4; "Date Captured"; Date)
        {
        }
        field(5; "Checkoff Period"; Date)
        {
            TableRelation = "Discounting Ledger Entry"."Fosa Account";

            trigger OnValidate()
            begin
                TestField("Employer Code");
                CheckOffAdvice.Reset;
                CheckOffAdvice.SetRange(CheckOffAdvice."Employer Code", "Employer Code");
                CheckOffAdvice.SetRange(CheckOffAdvice."Checkoff Period", "Checkoff Period");
                CheckOffAdvice.SetRange(CheckOffAdvice.Status, CheckOffAdvice.Status::Approved);
                if CheckOffAdvice.Find('-') then
                    Error('Advice for this employer has already been generated');

                CheckOffAdvice.Reset;
                CheckOffAdvice.SetRange(CheckOffAdvice."Employer Code", "Employer Code");
                CheckOffAdvice.SetRange(CheckOffAdvice."Checkoff Period", "Checkoff Period");
                CheckOffAdvice.SetRange(CheckOffAdvice.Status, CheckOffAdvice.Status::Approved);
                if CheckOffAdvice.Find('-') then begin
                    CheckOffAdvice.SetFilter(CheckOffAdvice."Checkoff Period", '<%1', "Checkoff Period");
                    if not CheckOffAdvice.Find('-') then
                        Error('Advice for this employer for previous month has not been generated');
                end;
            end;
        }
        field(6; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(8; "Employer Code"; Code[30])
        {
            TableRelation = "Sacco Employers".Code;

            trigger OnValidate()
            begin
                SaccoEmployers.Reset;
                SaccoEmployers.SetRange(SaccoEmployers.Code, "Employer Code");
                if SaccoEmployers.Find('-') then
                    "Employer Name" := SaccoEmployers.Description;
            end;
        }
        field(9; "Employer Name"; Code[100])
        {
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
        "Captured By" := UserId;
        "Date Captured" := Today;

        if No = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Safe Custody Agent Nos");
            //   NoSeriesMgt.InitSeries(SalesSetup."Safe Custody Agent Nos", xRec."No. Series", 0D, No, "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        SaccoEmployers: Record "Sacco Employers";
        CheckOffAdvice: Record "Checkoff Advice";
        CheckoffCalender: Record "Discounting Ledger Entry";
}

