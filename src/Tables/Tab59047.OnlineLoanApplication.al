#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 59047 "Online Loan Application"
{

    fields
    {
        field(1; "Application No"; Code[20])
        {
            Editable = false;
            trigger OnValidate()
            begin
                if "Application No" <> xRec."Application No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Portal Loan Nos");
                    "No. Series" := '';
                end;
            end;

        }
        field(2; "Loan Type"; Code[50])
        {
            Editable = true;
            TableRelation = "Loan Products Setup".Code where(Source = const(BOSA));
            trigger OnValidate()
            var
                LoanBal_: Decimal;
            begin
                if LoanType.Get("Loan Type") then begin
                    "Loan Product Type Name" := LoanType."Product Description";
                    "Interest Rate" := LoanType."Interest rate";
                    "Interest Calculation Method" := LoanType."Interest Calculation Method";
                end;
            end;
        }
        field(24; "Loan Product Type Name"; Code[20]) { Editable = false; }
        field(3; "BOSA No"; Code[20])
        {
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                RefDate: Date;
                MembReg: Record Customer;
            begin
                MembReg.Reset;
                MembReg.SetRange(MembReg."No.", "BOSA No");
                if MembReg.FindFirst() then begin
                    "Member Names" := MembReg.Name;
                    "Id No" := MembReg."ID No.";
                    "Employment No" := MembReg."Payroll/Staff No";
                    "Date of Birth" := MembReg."Date of Birth";
                    "Membership No" := MembReg."No.";
                    Email := MembReg."E-Mail (Personal)";
                    Telephone := MembReg."Mobile Phone No";
                    "Home Address" := MembReg.Address;
                    Station := MembReg."Station/Department";
                end;
            end;
        }
        field(4; "Id No"; Code[20]) { Editable = false; }
        field(5; "Employment No"; Code[20]) { Editable = false; }
        field(6; "Member Names"; Code[50]) { Editable = false; }
        field(7; "Date of Birth"; Date) { Editable = false; }
        field(8; "Membership No"; Code[20]) { TableRelation = Customer."No."; }
        field(9; "Application Date"; Date) { Editable = false; }
        field(10; Email; Code[20]) { Editable = false; }
        field(11; Telephone; Code[20]) { Editable = false; }
        field(12; "Home Address"; Code[20]) { Editable = false; }
        field(13; Station; Code[20]) { Editable = false; }
        field(14; "Loan Amount"; Decimal) { }
        field(15; "Repayment Period"; Integer) { Editable = false; }
        field(16; Source; Option)
        {
            OptionCaption = ' ,BOSA,FOSA,Investment,MICRO';
            OptionMembers = " ",BOSA,FOSA,Investment,MICRO;
        }
        field(17; "Interest Rate"; Decimal) { Editable = false; }
        field(18; "Loan Purpose"; Code[50]) { }
        field(19; "Sent To Bosa Loans"; Boolean) { }
        field(20; submitted; Boolean) { }
        field(21; Posted; Boolean) { }
        field(22; Refno; Code[20]) { }
        field(23; "Loan No"; Code[20]) { Editable = false; }
        field(25; "Interest Calculation Method"; Option)
        {
            Editable = false;
            OptionMembers = ,"No Interest","Flat Rate","Reducing Balances";
            // OptionCaption = '" ","No Interest","Flat Rate","Reducing Balances"';
        }
        field(26; "Captured By"; Code[50]) { }
        field(27; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(28; Installments; Integer) { }
        field(29; "Application Status"; Option)
        {
            OptionMembers = Application,Submitted,Deleted;
        }
        // field(7; Email; Code[20]) { }
    }

    keys
    {
        key(Key1; "Application No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Application No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Portal Loan Nos");
            "Application No" := NoSeriesMgt.GetNextNo(SalesSetup."Portal Loan Nos")

            //NoSeriesMgt.InitSeries(SalesSetup."Portal Loan Nos", xRec."No. Series", 0D, "Application No", "No. Series");
        end;

        "Application Date" := Today;
        "Captured By" := UpperCase(UserId);
    end;

    var
        MyRecRef: RecordRef;
        OnlineLoanTable: Record "Online Loan Application";
        RecordLink: Record "Record Link";
        LoanType: Record "Loan Products Setup";
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
}


