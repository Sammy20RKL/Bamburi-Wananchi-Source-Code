#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50290 "Accounts Applications Details"
{
    Caption = 'Accounts Applications';
    DataCaptionFields = "No.", Name;
    // DrillDownPageID = "Products Applications Master";
    // LookupPageID = "Products Applications Master";


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PurchSetup.Get;
                    NoSeriesMgt.TestManual(PurchSetup."Applicants Nos.");
                    "No. Series" := '';
                end;
                if "Invoice Disc. Code" = '' then
                    "Invoice Disc. Code" := "No.";
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                Name := UpperCase(Name);

                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(3; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(8; Contact; Text[50])
        {
            Caption = 'Contact';
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(14; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
        }
        field(15; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(19; "Budgeted Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Budgeted Amount';
        }
        field(21; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(24; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(26; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
        }
        field(27; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(28; "Fin. Charge Terms Code"; Code[10])
        {
            Caption = 'Fin. Charge Terms Code';
            TableRelation = "Finance Charge Terms";
        }
        field(29; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(30; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(31; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(33; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(38; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const(Vendor),
                                                      "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Payment,All';
            OptionMembers = " ",Payment,All;
        }
        field(45; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            TableRelation = Vendor;
        }
        field(46; Priority; Integer)
        {
            Caption = 'Priority';
        }
        field(47; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(55; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(86; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
                VATRegNoFormat.Test("VAT Registration No.", "Country/Region Code", "No.", Database::Vendor);
            end;
        }
        field(89; Picture; Media)
        {
            Caption = 'Picture';

        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(92; County; Text[30])
        {
            Caption = 'County';
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5701; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(5790; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
        }
        field(7177; "No. of Pstd. Receipts"; Integer)
        {
            CalcFormula = count("Purch. Rcpt. Header" where("Buy-from Vendor No." = field("No.")));
            Caption = 'No. of Pstd. Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7178; "No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = count("Purch. Inv. Header" where("Buy-from Vendor No." = field("No.")));
            Caption = 'No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7179; "No. of Pstd. Return Shipments"; Integer)
        {
            CalcFormula = count("Return Shipment Header" where("Buy-from Vendor No." = field("No.")));
            Caption = 'No. of Pstd. Return Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7180; "No. of Pstd. Credit Memos"; Integer)
        {
            CalcFormula = count("Purch. Cr. Memo Hdr." where("Buy-from Vendor No." = field("No.")));
            Caption = 'No. of Pstd. Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7600; "E-Mail"; Code[10])
        {
        }
        field(55019; "Debtor Type 2"; Option)
        {
            OptionMembers = "Vendor Account","FOSA Account";
        }
        field(68000; "Debtor Type"; Option)
        {
            OptionCaption = 'FOSA Account,Micro Finance';
            OptionMembers = "FOSA Account","Micro Finance";
        }
        field(68001; "Staff No"; Code[20])
        {
        }
        field(68002; "ID No."; Code[50])
        {
        }
        field(68003; "Last Maintenance Date"; Date)
        {
        }
        field(68004; "Activate Sweeping Arrangement"; Boolean)
        {
        }
        field(68005; "Sweeping Balance"; Decimal)
        {
        }
        field(68006; "Sweep To Account"; Code[30])
        {
            TableRelation = Vendor;
        }
        field(68007; "Fixed Deposit Status"; Option)
        {
            OptionCaption = ' ,Active,Matured,Closed,Not Matured';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured";
        }
        field(68008; "Call Deposit"; Boolean)
        {
        }
        field(68009; "Mobile Phone No"; Code[50])
        {

            trigger OnValidate()
            begin

            end;
        }
        field(68010; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Devorced,Widower';
            OptionMembers = " ",Single,Married,Devorced,Widower;
        }
        field(68011; "Registration Date"; Date)
        {
        }
        field(68012; "BOSA Account No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("BOSA Account No") then begin
                    Name := Cust.Name;
                    "Search Name" := Cust."Search Name";
                    Address := Cust.Address;
                    "Address 2" := Cust."Address 2";
                    "Staff No" := Cust."Payroll/Staff No";
                    "Employer Code" := Cust."Employer Code";
                    Section := Cust."Station/Department";
                    "Phone No." := Cust."Phone No.";
                    "Post Code" := Cust."Post Code";
                    "Country/Region Code" := Cust."Country/Region Code";
                    County := Cust.County;
                    "E-Mail" := Cust."E-Mail";
                    "ID No." := Cust."ID No.";
                    Picture := Cust.Image;
                    Signature := Cust.Signature;
                    "Formation/Province" := Cust."Formation/Province";
                    "Division/Department" := Cust."Division/Department";
                    "Station/Sections" := Cust."Station/Section";
                    "Global Dimension 2 Code" := Cust."Global Dimension 2 Code";
                    "Marital Status" := Cust."Marital Status";
                    "Monthly Contribution" := Cust."Monthly Contribution";
                    "Force No." := Cust."Force No.";
                    "Date of Birth" := Cust."Date of Birth";

                    if "Account Type" <> 'CHILDREN' then
                        "Date of Birth" := Cust."Date of Birth";


                    NOKApp.Reset;
                    NOKApp.SetRange(NOKApp."Account No", "No.");
                    if NOKApp.Find('-') then
                        NOKApp.DeleteAll;


                    NOKBOSA.Reset;
                    NOKBOSA.SetRange(NOKBOSA."Account No", "BOSA Account No");
                    if NOKBOSA.Find('-') then begin
                        repeat
                            NOKApp.Init;
                            NOKApp."Account No" := "No.";
                            NOKApp.Name := NOKBOSA.Name;
                            NOKApp.Relationship := NOKBOSA.Relationship;
                            NOKApp."Date of Birth" := NOKBOSA."Date of Birth";
                            NOKApp.Address := NOKBOSA.Address;
                            NOKApp.Telephone := NOKBOSA.Telephone;
                            NOKApp.Fax := NOKBOSA.Fax;
                            NOKApp.Email := NOKBOSA.Email;
                            NOKApp."ID No." := NOKBOSA."ID No.";
                            NOKApp.Insert;

                        until NOKBOSA.Next = 0;
                    end;

                end;


                VendorFDR.Reset;
                VendorFDR.SetRange(VendorFDR."BOSA Account No", "BOSA Account No");
                VendorFDR.SetRange(VendorFDR."Account Type", 'WSS');
                if VendorFDR.Find('-') then
                    "Savings Account No." := VendorFDR."No.";

            end;
        }
        field(68013; Signature; Media)
        {
        }
        field(68014; "Passport No."; Code[50])
        {
        }
        field(68015; "Employer Code"; Code[20])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(68016; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected,Created';
            OptionMembers = Open,Pending,Approved,Rejected,Created;

            trigger OnValidate()
            begin
                if (Status = Status::Open) or (Status = Status::Rejected) then
                    Blocked := Blocked::" "
                else
                    Blocked := Blocked::All
            end;
        }
        field(68017; "Account Type"; Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            begin
                if AccountTypes.Get("Account Type") then begin
                    AccountTypes.TestField(AccountTypes."Posting Group");
                    "Vendor Posting Group" := AccountTypes."Posting Group";
                    // "Allow Multiple Accounts" := AccountTypes."Allow Multiple Accounts";
                    if AccountTypes."Activity Code" = AccountTypes."activity code"::BOSA then
                        "Global Dimension 1 Code" := 'FOSA'
                    else
                        "Global Dimension 1 Code" := 'MICRO';

                    if AccountTypes."Fixed Deposit" = true then begin

                        "Fixed Deposit" := true;

                    end;
                end;

                if "Account Type" = 'JUNIOR' then
                    "Date of Birth" := 0D;
            end;
        }
        field(68018; "Account Category"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group';
            OptionMembers = Single,Joint,Corporate,Group;
        }

        field(68027; "Expected Maturity Date"; Date)
        {
        }
        field(68028; "ATM Transactions"; Decimal)
        {
        }
        field(68029; "Date of Birth"; Date)
        {

            trigger OnValidate()
            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');


                if "Account Type" <> 'JUNIOR' then begin
                    if "Date of Birth" <> 0D then begin
                        if GenSetUp.Get() then begin
                            if CalcDate(GenSetUp."Min. Member Age", "Date of Birth") > Today then
                                Error('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                        end;
                    end;
                end;
            end;
        }
        field(68030; "Application Status"; Option)
        {
            OptionCaption = 'Pending,Approved,Converted,Rejected';
            OptionMembers = Pending,Approved,Converted,Rejected;
        }
        field(68031; "Application Date"; Date)
        {
        }
        field(68032; "E-Mail (Personal)"; Text[50])
        {
        }
        field(68033; Station; Code[50])
        {
        }
        field(68034; "Home Address"; Text[50])
        {
        }
        field(68035; Location; Text[50])
        {
        }
        field(68036; "Sub-Location"; Text[50])
        {
        }
        field(68037; District; Text[50])
        {
        }
        field(68038; "Savings Account No."; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("BOSA Account No"));
        }
        field(68039; "Parent Account No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(68040; "Kin No"; Code[10])
        {
        }
        field(68041; Section; Code[20])
        {
            TableRelation = Stations.Code where("Employer Code" = field("Employer Code"));
        }
        field(68042; "Signing Instructions"; Text[250])
        {
        }
        field(68043; "Fixed Deposit Type"; Code[20])
        {
            TableRelation = "Fixed Deposit Type".Code;

            trigger OnValidate()
            begin
                TestField("Application Date");
                if FDType.Get("Fixed Deposit Type") then begin
                    "FD Maturity Date" := CalcDate(FDType.Duration, "Application Date");

                    "FD Duration" := FDType."No. of Months";
                end;
            end;
        }
        field(68044; "FD Maturity Date"; Date)
        {
        }
        field(68045; "Monthly Contribution"; Decimal)
        {
        }
        field(68046; "Formation/Province"; Code[20])
        {
        }
        field(68047; "Division/Department"; Code[20])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(68048; "Station/Sections"; Code[20])
        {
            TableRelation = "Member Section"."No.";
        }
        field(68120; "Force No."; Code[20])
        {
        }
        field(68121; "Micro Group"; Boolean)
        {

            trigger OnValidate()
            begin
                if ("Micro Single" = true) then // OR ("BOSA Account No" <> '') THEN
                    Error('You cannot select both Micro Single and Micro Group');

            end;
        }
        field(68122; "Micro Single"; Boolean)
        {

            trigger OnValidate()
            begin
                if ("Micro Group" = true) then //OR ("BOSA Account No" <> '') THEN
                    Error('You cannot select both Micro Single and Micro Group');
            end;
        }
        field(68123; "Group Code"; Code[10])
        {
            TableRelation = Vendor."No." where("Group Account" = const(true));

            trigger OnValidate()
            begin
                if "Micro Single" <> true then
                    Error('Can only be used with Micro Credit individual accounts');

                "Global Dimension 1 Code" := 'MICRO';
            end;
        }
        field(68124; "ContactPerson Relation"; Code[20])
        {
        }
        field(68125; "ContacPerson Occupation"; Code[20])
        {
        }
        field(68126; "ContacPerson Phone"; Text[30])
        {
        }
        field(68127; "Recruited By"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(68128; "Fixed Deposit"; Boolean)
        {
        }
        field(68129; "Neg. Interest Rate"; Decimal)
        {
        }
        field(68130; "FD Duration"; Integer)
        {

            trigger OnValidate()
            begin

                "FD Maturity Date" := "Application Date" + ("FD Duration" * 30);
                Modify;
            end;
        }
        field(68131; "FD Maturity Instructions"; Option)
        {
            OptionCaption = ' ,Transfer to Savings,Transfer Interest & Renew,Renew';
            OptionMembers = " ","Transfer to Savings","Transfer Interest & Renew",Renew;
        }
        field(68132; "Allow Multiple Accounts"; Boolean)
        {
        }
        field(68133; "Sms Notification"; Boolean)
        {
        }
        field(68134; "Created By"; Code[20])
        {
        }
        field(68135; "Time Created"; Time)
        {
        }
        field(68136; "Date Created"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; "Vendor Posting Group")
        {
        }
        key(Key4; "Currency Code")
        {
        }
        key(Key5; Priority)
        {
        }
        key(Key6; "Country/Region Code")
        {
        }
        key(Key8; "VAT Registration No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var

    begin

    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PurchSetup.Get;
            PurchSetup.TestField(PurchSetup."Applicants Nos.");
            // NoSeriesMgt.InitSeries(PurchSetup."Applicants Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            "Application Date" := today;
            "Created By" := UserId;
        end;


    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;

    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    var
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor.';
        Text002: label 'You have set %1 to %2. Do you want to update the %3 price list accordingly?';
        Text003: label 'Do you wish to create a contact for %1 %2?';
        PurchSetup: Record "Sacco No. Series";
        CommentLine: Record "Comment Line";
        PurchOrderLine: Record "Purchase Line";
        PostCode: Record "Post Code";
        VendBankAcc: Record "Vendor Bank Account";
        OrderAddr: Record "Order Address";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ItemCrossReference: Record "Item Reference";
        RMSetup: Record "Marketing Setup";
        ServiceItem: Record "Service Item";
        NoSeriesMgt: Codeunit "No. Series";
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromVend: Codeunit "VendCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        Text004: label 'Contact %1 %2 is not related to vendor %3 %4.';
        Text005: label 'post';
        Text006: label 'create';
        Text007: label 'You cannot %1 this type of document when Vendor %2 is blocked with type %3';
        Text008: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3.';
        Text009: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text010: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        AccountTypes: Record "Account Types-Saving Products";
        UsersID: Record User;
        FDType: Record "Fixed Deposit Type";
        Cust: Record Customer;
        NOKBOSA: Record "Members Next Kin Details";
        NOKApp: Record "Member App Next Of kin";// "Accounts App Kin Details";
        GenSetUp: Record "Sacco General Set-Up";
        VendorFDR: Record Vendor;



}

