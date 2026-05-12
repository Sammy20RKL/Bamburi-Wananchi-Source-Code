#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51430 "Product Applications Details"
{
    Caption = 'Product Applications Details';
    DataCaptionFields = "No.", Name;
    // DrillDownPageID = "Product Applications List";
    // LookupPageID = "Product Applications List";
    Permissions = TableData "Vendor Ledger Entry" = r;

    fields
    {
        field(1; "No."; Code[50])
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
        field(7; City; Text[31])
        {
            Caption = 'City';
            TableRelation = "Post Code".City;

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(8; Contact; Text[50])
        {
            Caption = 'Contact';
        }
        field(9; "Phone No."; Text[31])
        {
            Caption = 'Phone No.';
        }
        field(10; "Telex No."; Text[50])
        {
            Caption = 'Telex No.';
        }
        field(14; "Our Account No."; Text[50])
        {
            Caption = 'Our Account No.';
        }
        field(15; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(16; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(17; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Global Dimension 2 Code");
                if DimValue.Find('-') then begin
                    "Member Branch Code" := DimValue."Dimension Code";
                end;
            end;
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
        field(33; "Invoice Disc. Code"; Code[50])
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
        field(45; "Pay-to Vendor No."; Code[50])
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
        field(56; "Global Dimension 1 Filter"; Code[50])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[50])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(58; Balance; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("No."),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           "Currency Code" = field("Currency Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("No."),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = field("Currency Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Net Change"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("No."),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Currency Code" = field("Currency Filter")));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Net Change (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("No."),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = field("Date Filter"),
                                                                                   "Currency Code" = field("Currency Filter")));
            Caption = 'Net Change (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Purchases (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Vendor Ledger Entry"."Purchase (LCY)" where("Vendor No." = field("No."),
                                                                             "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                             "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                             "Posting Date" = field("Date Filter"),
                                                                             "Currency Code" = field("Currency Filter")));
            Caption = 'Purchases (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Inv. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Vendor Ledger Entry"."Inv. Discount (LCY)" where("Vendor No." = field("No."),
                                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Inv. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Pmt. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("No."),
                                                                                  "Entry Type" = filter("Payment Discount" .. "Payment Discount (VAT Adjustment)"),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Balance Due"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("No."),
                                                                           "Posting Date" = field(upperlimit("Date Filter")),
                                                                           "Initial Entry Due Date" = field("Date Filter"),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           "Currency Code" = field("Currency Filter")));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(67; "Balance Due (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("No."),
                                                                                   "Posting Date" = field(upperlimit("Date Filter")),
                                                                                   "Initial Entry Due Date" = field("Date Filter"),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = field("Currency Filter")));
            Caption = 'Balance Due (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; Payments; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Initial Document Type" = const(Payment),
                                                                          "Entry Type" = const("Initial Entry"),
                                                                          "Vendor No." = field("No."),
                                                                          "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Currency Code" = field("Currency Filter")));
            Caption = 'Payments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "Invoice Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Initial Document Type" = const(Invoice),
                                                                           "Entry Type" = const("Initial Entry"),
                                                                           "Vendor No." = field("No."),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Currency Code" = field("Currency Filter")));
            Caption = 'Invoice Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(71; "Cr. Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Initial Document Type" = const("Credit Memo"),
                                                                          "Entry Type" = const("Initial Entry"),
                                                                          "Vendor No." = field("No."),
                                                                          "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Currency Code" = field("Currency Filter")));
            Caption = 'Cr. Memo Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "Finance Charge Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Initial Document Type" = const("Finance Charge Memo"),
                                                                           "Entry Type" = const("Initial Entry"),
                                                                           "Vendor No." = field("No."),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Currency Code" = field("Currency Filter")));
            Caption = 'Finance Charge Memo Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(74; "Payments (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Payment),
                                                                                  "Entry Type" = const("Initial Entry"),
                                                                                  "Vendor No." = field("No."),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Payments (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(75; "Inv. Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Invoice),
                                                                                   "Entry Type" = const("Initial Entry"),
                                                                                   "Vendor No." = field("No."),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = field("Date Filter"),
                                                                                   "Currency Code" = field("Currency Filter")));
            Caption = 'Inv. Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(76; "Cr. Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const("Credit Memo"),
                                                                                  "Entry Type" = const("Initial Entry"),
                                                                                  "Vendor No." = field("No."),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Cr. Memo Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(77; "Fin. Charge Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const("Finance Charge Memo"),
                                                                                   "Entry Type" = const("Initial Entry"),
                                                                                   "Vendor No." = field("No."),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = field("Date Filter"),
                                                                                   "Currency Code" = field("Currency Filter")));
            Caption = 'Fin. Charge Memo Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(78; "Outstanding Orders"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Outstanding Amount" where("Document Type" = const(Order),
                                                                          "Pay-to Vendor No." = field("No."),
                                                                          "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                          "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                          "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(79; "Amt. Rcd. Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Amt. Rcd. Not Invoiced" where("Document Type" = const(Order),
                                                                              "Pay-to Vendor No." = field("No."),
                                                                              "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                              "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                              "Currency Code" = field("Currency Filter")));
            Caption = 'Amt. Rcd. Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Application Method"; Option)
        {
            Caption = 'Application Method';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(82; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';

            trigger OnValidate()
            var
            begin
            end;
        }
        field(84; "Fax No."; Text[32])
        {
            Caption = 'Fax No.';
        }
        field(85; "Telex Answer Back"; Text[50])
        {
            Caption = 'Telex Answer Back';
        }
        field(86; "VAT Registration No."; Text[50])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
                VATRegNoFormat.Test("VAT Registration No.", "Country/Region Code", "No.", Database::Vendor);
            end;
        }
        field(88; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                        Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(89; Picture; Media)
        {
            Caption = 'Picture';
        }
        field(91; "Post Code"; Code[50])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code");
            end;
        }
        field(92; County; Text[31])
        {
            Caption = 'County';
        }
        field(97; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Debit Amount" where("Vendor No." = field("No."),
                                                                                  "Entry Type" = filter(<> Application),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(98; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Credit Amount" where("Vendor No." = field("No."),
                                                                                   "Entry Type" = filter(<> Application),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = field("Date Filter"),
                                                                                   "Currency Code" = field("Currency Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)" where("Vendor No." = field("No."),
                                                                                        "Entry Type" = filter(<> Application),
                                                                                        "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                        "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                        "Posting Date" = field("Date Filter"),
                                                                                        "Currency Code" = field("Currency Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Credit Amount (LCY)" where("Vendor No." = field("No."),
                                                                                         "Entry Type" = filter(<> Application),
                                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                         "Posting Date" = field("Date Filter"),
                                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(103; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
        }
        field(104; "Reminder Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Initial Document Type" = const(Reminder),
                                                                           "Entry Type" = const("Initial Entry"),
                                                                           "Vendor No." = field("No."),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Currency Code" = field("Currency Filter")));
            Caption = 'Reminder Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(105; "Reminder Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Reminder),
                                                                                   "Entry Type" = const("Initial Entry"),
                                                                                   "Vendor No." = field("No."),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = field("Date Filter"),
                                                                                   "Currency Code" = field("Currency Filter")));
            Caption = 'Reminder Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Tax Area Code"; Code[50])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(109; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(110; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(111; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(113; "Outstanding Orders (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Outstanding Amount (LCY)" where("Document Type" = const(Order),
                                                                                "Pay-to Vendor No." = field("No."),
                                                                                "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Orders (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(114; "Amt. Rcd. Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Amt. Rcd. Not Invoiced (LCY)" where("Document Type" = const(Order),
                                                                                    "Pay-to Vendor No." = field("No."),
                                                                                    "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                    "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                    "Currency Code" = field("Currency Filter")));
            Caption = 'Amt. Rcd. Not Invoiced (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(116; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance';
        }
        field(117; "Pmt. Disc. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("No."),
                                                                                  "Entry Type" = filter("Payment Discount Tolerance" | "Payment Discount Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)"),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Disc. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(118; "Pmt. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("No."),
                                                                                  "Entry Type" = filter("Payment Tolerance" | "Payment Tolerance (VAT Adjustment)" | "Payment Tolerance (VAT Excl.)"),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(119; "IC Partner Code"; Code[50])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";

            trigger OnValidate()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
                AccountingPeriod: Record "Accounting Period";
                ICPartner: Record "IC Partner";
            begin
                if xRec."IC Partner Code" <> "IC Partner Code" then begin
                    VendLedgEntry.SetCurrentkey("Vendor No.", "Posting Date");
                    VendLedgEntry.SetRange("Vendor No.", "No.");
                    AccountingPeriod.SetRange(Closed, false);
                    if AccountingPeriod.Find('-') then
                        VendLedgEntry.SetFilter("Posting Date", '>=%1', AccountingPeriod."Starting Date");
                    if VendLedgEntry.Find('-') then
                        if not Confirm(Text009, false, TableCaption) then
                            "IC Partner Code" := xRec."IC Partner Code";

                    VendLedgEntry.Reset;
                    if not VendLedgEntry.SetCurrentkey("Vendor No.", Open) then
                        VendLedgEntry.SetCurrentkey("Vendor No.");
                    VendLedgEntry.SetRange("Vendor No.", "No.");
                    VendLedgEntry.SetRange(Open, true);
                    if VendLedgEntry.Find('+') then
                        Error(Text010, FieldCaption("IC Partner Code"), TableCaption);
                end;

                if "IC Partner Code" <> '' then begin
                    ICPartner.Get("IC Partner Code");
                    if (ICPartner."Vendor No." <> '') and (ICPartner."Vendor No." <> "No.") then
                        Error(Text008, FieldCaption("IC Partner Code"), "IC Partner Code", TableCaption, ICPartner."Vendor No.");
                    ICPartner."Vendor No." := "No.";
                    ICPartner.Modify;
                end;

                if (xRec."IC Partner Code" <> "IC Partner Code") and ICPartner.Get(xRec."IC Partner Code") then begin
                    ICPartner."Vendor No." := '';
                    ICPartner.Modify;
                end;
            end;
        }
        field(120; Refunds; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Initial Document Type" = const(Refund),
                                                                           "Entry Type" = const("Initial Entry"),
                                                                           "Vendor No." = field("No."),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Currency Code" = field("Currency Filter")));
            Caption = 'Refunds';
            FieldClass = FlowField;
        }
        field(121; "Refunds (LCY)"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Refund),
                                                                                   "Entry Type" = const("Initial Entry"),
                                                                                   "Vendor No." = field("No."),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = field("Date Filter"),
                                                                                   "Currency Code" = field("Currency Filter")));
            Caption = 'Refunds (LCY)';
            FieldClass = FlowField;
        }
        field(122; "Other Amounts"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount where("Initial Document Type" = const(" "),
                                                                           "Entry Type" = const("Initial Entry"),
                                                                           "Vendor No." = field("No."),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Currency Code" = field("Currency Filter")));
            Caption = 'Other Amounts';
            FieldClass = FlowField;
        }
        field(123; "Other Amounts (LCY)"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(" "),
                                                                                   "Entry Type" = const("Initial Entry"),
                                                                                   "Vendor No." = field("No."),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = field("Date Filter"),
                                                                                   "Currency Code" = field("Currency Filter")));
            Caption = 'Other Amounts (LCY)';
            FieldClass = FlowField;
        }
        field(124; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(125; "Outstanding Invoices"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Outstanding Amount" where("Document Type" = const(Invoice),
                                                                          "Pay-to Vendor No." = field("No."),
                                                                          "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                          "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                          "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(126; "Outstanding Invoices (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Outstanding Amount (LCY)" where("Document Type" = const(Invoice),
                                                                                "Pay-to Vendor No." = field("No."),
                                                                                "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Invoices (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5049; "Primary Contact No."; Code[50])
        {
            Caption = 'Primary Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                ContBusRel.SetCurrentkey("Link to Table", "No.");
                ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Vendor);
                ContBusRel.SetRange("No.", "No.");
                if ContBusRel.Find('-') then
                    Cont.SetRange("Company No.", ContBusRel."Contact No.");

                if "Primary Contact No." <> '' then
                    if Cont.Get("Primary Contact No.") then;
                if Page.RunModal(0, Cont) = Action::LookupOK then
                    Validate("Primary Contact No.", Cont."No.");
            end;

            trigger OnValidate()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                Contact := '';
                if "Primary Contact No." <> '' then begin
                    Cont.Get("Primary Contact No.");

                    ContBusRel.SetCurrentkey("Link to Table", "No.");
                    ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Vendor);
                    ContBusRel.SetRange("No.", "No.");
                    ContBusRel.Find('-');

                    if Cont."Company No." <> ContBusRel."Contact No." then
                        Error(Text004, Cont."No.", Cont.Name, "No.", Name);

                    if Cont.Type = Cont.Type::Person then
                        Contact := Cont.Name
                end;
            end;
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
        field(7600; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
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
        field(68001; "Staff No"; Code[50])
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
        field(68006; "Sweep To Account"; Code[31])
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
                /*
                Vend.RESET;
                Vend.SETRANGE(Vend."Staff No","Staff No");
                IF Vend.FIND('-') THEN
                Vend.MODIFYALL(Vend."Mobile Phone No","Mobile Phone No");
                
                Cust.RESET;
                Cust.SETRANGE(Cust."Staff No","Staff No");
                IF Cust.FIND('-') THEN
                Cust.MODIFYALL(Cust."Mobile Phone No","Mobile Phone No");
                */

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
        field(68012; "BOSA Account No"; Code[50])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin

                if Cust.Get("BOSA Account No") then begin
                    Name := Cust.Name;
                    "Search Name" := Cust."Search Name";
                    Address := Cust.Address;
                    "Address 2" := Cust."Home Address";
                    // "Staff No" := Cust.staff "Personal No";
                    City := Cust.City;
                    "Employer Code" := Cust."Employer Code";
                    Section := Cust."Station/Department";
                    "Phone No." := Cust."Mobile No. 2";
                    "Mobile Phone No" := Cust."Mobile Phone No";
                    "Fax No." := Cust."Fax No.";
                    "Post Code" := Cust."Post Code";
                    "Country/Region Code" := Cust."Country/Region Code";
                    County := Cust.County;
                    "Country/Region Code" := Cust."Country/Region Code";
                    "E-Mail" := Cust."E-Mail";
                    "ID No." := Cust."ID No.";
                    Picture := Cust.Image;
                    "Marital Status" := Cust."Marital Status";
                    Signature := Cust.Signature;
                    "Formation/Province" := Cust."Formation/Province";
                    "Division/Department" := Cust."Division/Department";
                    "Station/Sections" := Cust."Station/Section";
                    Contact := Cust."Contact Person";
                    "ContactPerson Relation" := Cust."ContactPerson Relation";
                    "ContacPerson Occupation" := Cust."ContactPerson Occupation";
                    "ContacPerson Phone" := Cust."Contact Person Phone";
                    "Global Dimension 1 Code" := cust."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := cust."Global Dimension 2 Code";


                    "Date of Birth" := Cust."Date of Birth";


                    NOKApp.Reset;
                    NOKApp.SetRange(NOKApp."Account No", "No.");
                    if NOKApp.Find('-') then
                        NOKApp.DeleteAll;


                    NOKBOSA.Reset;
                    NOKBOSA.SetRange(NOKBOSA."Account No", "BOSA Account No");
                    if NOKBOSA.Find('-') then begin
                        repeat
                        // NOKApp.Init;
                        // NOKApp."Account No" := "No.";
                        // NOKApp.Name := NOKBOSA.Name;
                        // NOKApp.Relationship := NOKBOSA.Relationship;
                        // NOKApp."Date of Birth" := NOKBOSA."Date of Birth";
                        // NOKApp.Address := NOKBOSA.Address;
                        // NOKApp.Telephone := NOKBOSA.Telephone;
                        // //NOKApp.Fax:=NOKBOSA.Fax;
                        // NOKApp.Email := NOKBOSA.Email;
                        // NOKApp."ID No." := NOKBOSA."ID No.";
                        // NOKApp.Insert;

                        until NOKBOSA.Next = 0;
                    end;

                end;
            end;
        }
        field(68013; Signature; Media)
        {
        }
        field(68014; "Passport No."; Code[50])
        {
        }
        field(68015; "Employer Code"; Code[50])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(68016; Status; Enum "Record Status")
        {

        }
        field(68017; "Account Type"; Code[50])
        {
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            begin
                // if AccountTypes.Get("Account Type") then begin
                //     AccountTypes.TestField(AccountTypes."Posting Group");
                //     "Vendor Posting Group" := AccountTypes."Posting Group";
                //     if AccountTypes."Activity Code" = AccountTypes."activity code"::FOSA then
                //         "Global Dimension 1 Code" := 'FOSA'
                //     else
                //         "Global Dimension 1 Code" := 'MICRO';
                // end;

                if "Account Type" = 'JUNIOR' then
                    "Date of Birth" := 0D;


                //FIXED/CALL  DEPOSIT
                if ("Account Type" = 'FIXED') or ("Account Type" = 'CALLDEPOSIT') then begin
                    VendorFDR.Reset;
                    VendorFDR.SetRange(VendorFDR."BOSA Account No", "BOSA Account No");
                    VendorFDR.SetRange(VendorFDR."Account Type", 'CURRENT');
                    if VendorFDR.Find('-') then begin
                        "Savings Account No." := VendorFDR."No.";
                    end;
                end;

                Account.Reset;
                Account.SetRange(Account."ID No.", "ID No.");
                Account.SetRange(Account."Account Type", "Account Type");
                if Account.Find('-') then begin
                    //IF (Account."Account Type"<>'FD201') OR (Account."Account Type"<>'FS152') OR (Account."Account Type"<>'FS155')  THEN  BEGIN
                    //ERROR('The Member has an Existing %1',"Account Type");
                    //END;
                end;
            end;
        }
        field(68018; "Account Category"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group';
            OptionMembers = Single,Joint,Corporate,Group;
        }
        field(68019; "FD Marked for Closure"; Boolean)
        {
        }
        field(68020; "Last Withdrawal Date"; Date)
        {
        }
        field(68021; "Last Overdraft Date"; Date)
        {
        }
        field(68022; "Last Min. Balance Date"; Date)
        {
        }
        field(68023; "Last Deposit Date"; Date)
        {
        }
        field(68024; "Last Transaction Date"; Date)
        {
        }
        field(68025; "Date Closed"; Date)
        {
        }
        field(68026; "Uncleared Cheques"; Decimal)
        {
            CalcFormula = sum(Transactions.Amount where("Account No" = field("No."),
                                                         Deposited = const(true),
                                                         "Cheque Processed" = const(false)));
            FieldClass = FlowField;
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

                /*
                IF "Account Type"<>'JUNIOR' THEN BEGIN
                IF "Date of Birth" <> 0D THEN BEGIN
                IF GenSetUp.GET() THEN BEGIN
                IF CALCDATE(GenSetUp."Min. Member Age","Date of Birth") > TODAY THEN
                ERROR('Applicant bellow the mininmum membership age of %1',GenSetUp."Min. Member Age");
                END;
                END;
                END;
                */

            end;
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
        field(68038; "Savings Account No."; Code[50])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                /*VendorFDR.RESET;
                VendorFDR.SETRANGE(VendorFDR."ID No.","ID No.");
                VendorFDR.SETRANGE(VendorFDR."Creditor Type",VendorFDR."Creditor Type"::"1");
                VendorFDR.SETRANGE(VendorFDR."Account Type",'SAVINGS');
                IF VendorFDR.FIND('-') THEN BEGIN
                ERROR('You Can Only link this FDR Account to the respective Members Savings Account,Please Make sure you are picking the correct Account.');
                END;
                 */

            end;
        }
        field(68039; "Parent Account No."; Code[50])
        {
            TableRelation = Vendor."No.";
        }
        field(68040; "Kin No"; Code[2])
        {
        }
        field(68041; Section; Code[50])
        {

        }
        field(68042; "Signing Instructions"; Text[250])
        {
        }
        field(68043; "Fixed Deposit Type"; Code[50])
        {
            TableRelation = "Fixed Deposit Type".Code;

            trigger OnValidate()
            begin
                TestField("Application Date");
                if FDType.Get("Fixed Deposit Type") then
                    "FD Maturity Date" := CalcDate(FDType.Duration, "Application Date");
            end;
        }
        field(68044; "FD Maturity Date"; Date)
        {
        }
        field(68045; "Monthly Contribution"; Decimal)
        {
        }
        field(68046; "Formation/Province"; Code[50])
        {
        }
        field(68047; "Division/Department"; Code[50])
        {

        }
        field(68048; "Station/Sections"; Code[50])
        {

        }
        field(68120; "Force No."; Code[50])
        {
        }
        field(68121; "Micro Group"; Boolean)
        {

            trigger OnValidate()
            begin
                if ("Micro Single" = true) then // OR ("BOSA Account No" <> '') THEN
                    Error('You cannot select both Micro Single and Micro Group');
                //"Debtor Type":="Debtor Type"::"Micro Finance"
                //END;

                //IF "Micro Group"=FALSE THEN
                //"Debtor Type":="Debtor Type"::"FOSA Account";
            end;
        }
        field(68122; "Micro Single"; Boolean)
        {

            trigger OnValidate()
            begin
                if ("Micro Group" = true) then //OR ("BOSA Account No" <> '') THEN
                    Error('You cannot select both Micro Single and Micro Group');

                //"Debtor Type":="Debtor Type"::"Micro Finance";

                //IF "Micro Single"=FALSE THEN
                //"Debtor Type":="Debtor Type"::"FOSA Account";
            end;
        }
        field(68123; "Group Code"; Code[10])
        {

            trigger OnValidate()
            begin
                if "Micro Single" <> true then
                    Error('Can only be used with Micro Credit individual accounts');

                "Global Dimension 1 Code" := 'MICRO';
            end;
        }
        field(68124; "ContactPerson Relation"; Code[50])
        {
        }
        field(68125; "ContacPerson Occupation"; Code[50])
        {
        }
        field(68126; "ContacPerson Phone"; Text[32])
        {
        }
        field(68127; "Recruited By"; Code[50])
        {
            TableRelation = Vendor."No.";
        }
        field(68128; Diocese; Code[50])
        {
        }
        field(68129; "Created By"; Code[50])
        {
        }
        field(68130; "Captured By"; Code[50])
        {
        }
        field(68131; "Member Branch Code"; Code[50])
        {
        }
        field(68132; "Sent for Approval By"; Code[50])
        {
        }
        field(68133; "Approved By"; Code[50])
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
        key(Key7; "Gen. Bus. Posting Group")
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
            //NoSeriesMgt.InitSeries(PurchSetup."Applicants Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Created By" := UserId;
        "Captured By" := UserId;
    end;

    trigger OnModify()
    begin
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        if ("Created By" <> UpperCase(UserId)) and (Status = Status::Open) then
            Error('Cannot modify an application being processed by %1', "Created By");
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
        NOKBOSA: Record "Members Next Kin Details";// "Members NOK Details";
        NOKApp: Record "Member App Next Of kin";//"Product App Kin Details";
        GenSetUp: Record "Sacco General Set-Up";
        VendorFDR: Record Vendor;
        ParentEditable: Boolean;
        SavingsEditable: Boolean;
        Account: Record Vendor;
        DimValue: Record "Dimension Value";


    procedure AssistEdit(OldVend: Record Vendor): Boolean
    var
        Vend: Record Vendor;
    begin
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[50])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Vendor, "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[50])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Vendor, "No.", FieldNumber, ShortcutDimCode);
    end;


    procedure ShowContact()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
    end;


    procedure SetInsertFromContact(FromContact: Boolean)
    begin
        InsertFromContact := FromContact;
    end;


    procedure CheckBlockedVendOnDocs(Vend2: Record Vendor; Transaction: Boolean)
    begin
        if Vend2.Blocked = Vend2.Blocked::All then
            VendBlockedErrorMessage(Vend2, Transaction);
    end;


    procedure CheckBlockedVendOnJnls(Vend2: Record Vendor; DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge",Reminder,Refund; Transaction: Boolean)
    begin
        if (Vend2.Blocked = Vend2.Blocked::All) or
   (Vend2.Blocked = Vend2.Blocked::Payment) and (DocType = Doctype::Payment)
then
            Vend2.VendBlockedErrorMessage(Vend2, Transaction);
    end;


    procedure VendBlockedErrorMessage(Vend2: Record Vendor; Transaction: Boolean)
    var
        "Action": Text[30];
    begin
        if Transaction then
            Action := Text005
        else
            Action := Text006;
        Error(Text007, Action, Vend2."No.", Vend2.Blocked);
    end;
}

