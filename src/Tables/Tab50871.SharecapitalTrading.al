table 50871 SharecapitalTrading
{
    Caption = 'Sharecapital Trading';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Share Capital Trading List";
    LookupPageId = "Share Capital Trading List";

    fields
    {
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Share Capital Transfer No.s");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Name of Seller"; Text[100])
        {
            Caption = 'Name of Seller';
        }
        field(3; "Seller Share Balance"; Decimal)
        {
            Caption = 'Share Balance';
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Seller No"),
            //                                                        "Transaction Type" = filter("Shares Capital"),
            //                                                        "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            // FieldClass = FlowField;
        }
        field(4; "Amount to Sell"; Decimal)
        {
            Caption = 'Amount to Sell';
        }
        field(5; Reason; Text[100])
        {
            Caption = 'Reason';
        }
        field(6; "Selling price"; Decimal)
        {
            Caption = 'Selling price';
        }
        field(7; "Buyer No."; Code[40])
        {
            Caption = 'Buyer No.';
            TableRelation = Customer."No." where("Customer Type" = filter(Member));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if cust.get("Buyer No.") then begin
                    Cust.CalcFields("Share Capital");
                    "Buyer Name" := cust.Name;
                    "Buyer Shares Balance" := cust."Share Capital";
                end;
            end;
        }
        field(8; "Buyer Name"; Text[100])
        {
            Caption = 'Buyer Name';
        }
        field(9; "Buyer Shares Balance"; Decimal)
        {
            Caption = 'Buyer Shares Amount';
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Buyer No."),
            //                                                        "Transaction Type" = filter("Shares Capital"),
            //                                                        "Posting Date" = field("Date Filter"), Reversed = const(false)));
            // FieldClass = FlowField;
        }
        field(10; cashier; Code[30])
        {
            Caption = 'cashier';
        }
        field(11; "Trasaction Date"; Date)
        {
            Caption = 'Trasaction Date';
        }
        field(12; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(13; "No. Series"; Code[10])
        {
        }
        field(14; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected,Closed';
            OptionMembers = Open,Pending,Approved,Rejected,Closed;
        }
        field(16; "Seller No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Customer Type" = filter(Member));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if cust.get("Seller No") then begin
                    cust.CalcFields("Share Capital");
                    "Name of Seller" := cust.Name;
                    "Seller Share Balance" := cust."Share Capital";
                    "Amount to Sell" := cust."Share Capital";
                end;
            end;
        }
        field(17; "Partially Sell"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Share Capital Transfer No.s");
            // NoSeriesMgt.InitSeries(SalesSetup."Share Capital Transfer No.s", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Trasaction Date" := Today;
        cashier := UpperCase(UserId);
    end;

    var
        cust: Record Customer;
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";

}
