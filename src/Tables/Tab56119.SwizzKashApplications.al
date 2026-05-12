#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 56119 "SwizzKash Applications"
{

    fields
    {
        field(1; "No."; Code[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    SaccoNoSeries.GET;
                    NoSeriesMgt.TestManual(SaccoNoSeries."swizzkash Reg No.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Account No"; Code[50])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            var
                VendorTable: record Vendor;
                MobileApplications: record "SwizzKash Applications";
            begin
                if "Account No" <> '' then begin
                    MobileApplications.Reset();
                    MobileApplications.SetRange(MobileApplications."Account No", "Account No");
                    if MobileApplications.Find('-') then begin
                        error('Account already exists !')
                    end;
                end;

                VendorTable.reset;
                VendorTable.SetRange(VendorTable."No.", "Account No");
                if VendorTable.find('-') then begin
                    Telephone := VendorTable."Mobile Phone No";
                    "Account Name" := VendorTable.Name;
                    "ID No" := VendorTable."ID No.";
                    Gender := VendorTable.Gender;
                end;
            end;
        }
        field(3; Telephone; text[50])
        {
            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(4; status; Option)
        {
            Editable = false;
            Enabled = true;
            OptionCaption = 'Application, Pending Approval,Approved,Rejected';
            OptionMembers = Application,"Pending Approval",Approved,Rejected;
        }
        field(5; "ID No"; code[50])
        {

            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(6; "Date Applied"; Date)
        {

            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(7; "Time Applied"; Time)
        {

            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(8; "Created By"; code[50])
        {

            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(9; Sent; Boolean)
        {

            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(10; "Account Name"; text[50])
        {

            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(11; SentToServer; Boolean)
        {

            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(12; "PIN Requested"; Boolean)
        {

            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(13; "Last PIN Reset"; Date)
        {


            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(14; "Reset By"; Code[50])
        {

            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(15; "No. Series"; Code[50])
        {

            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(16; "ActivationStatus"; enum "Account Activation Status")
        {
            Editable = false;
        }
        field(17; "Mobile Status"; enum "Account Mobile Status")
        {
            Editable = false;
        }
        field(18; "Member No"; Code[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor."BOSA Account No" where("No." = field("Account No"), "Account Type" = filter('M-WALLET')));
        }
        field(19; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        IF "No." = '' THEN BEGIN
            SaccoNoSeries.GET;
            SaccoNoSeries.TESTFIELD(SaccoNoSeries."Swizzkash Reg No.");
            "No." := NoSeriesMgt.GetNextNo(SaccoNoSeries."SwizzKash Reg No.");
            // NoSeriesMgt.InitSeries(SaccoNoSeries."Swizzkash Reg No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;


        "Time Applied" := TIME;
        "Created By" := USERID;
        "Date Applied" := TODAY;
        status := status::Application;
    end;

    var
        SaccoNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        Accounts: Record Vendor;
        cloudapp: Record "SwizzKash Applications";
}

