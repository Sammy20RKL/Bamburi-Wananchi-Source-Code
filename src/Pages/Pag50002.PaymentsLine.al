#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50002 "Payments Line"
{
    PageType = ListPart;
    SourceTable = "Payment Line New";// "Payments Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field("Member Type"; Rec."Member Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Board Member No';
                }
                field("Board Member Name"; Rec."Board Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Control1102760017; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField("Shortcut Dimension 2 Code");

                        //check if the payment reference is for farmer purchase
                        if Rec."Payment Reference" = Rec."payment reference"::"Farmer Purchase" then begin
                            if Rec.Amount <> xRec.Amount then begin
                                Error('Amount cannot be modified');
                            end;
                        end;

                        Rec."Amount With VAT" := Rec.Amount;

                    end;
                }
                field("Travel Destination"; Rec."Travel Destination")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = Basic;
                }
                field("W/Tax Rate"; Rec."W/Tax Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Refund Charge"; Rec."Refund Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        if Rec."Applies-to Doc. Type" <> Rec."Applies-to Doc. Type"::Invoice then
                            Error('Only Purchase Invoices are allowed.');
                    end;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = Basic;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = Basic;
                }
                field("Board Net Amount"; Rec."Board Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Borad"; Rec."Amount Borad")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        FundsTypes: Record "Funds Transaction Types";
        PHeader: Record "Payments Header";
        "G/L Account": Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Investor: Record "Profitability Set up-Micro";
        FundsTaxCodes: Record "Funds Tax Codes";
        CurrExchRate: Record "Currency Exchange Rate";
        Loans: Record "Loans Register";
        Cust: Record Customer;
    //         InvestorAmounts: Record "Investor Amounts";
    //         InterestCodes: Record "Interest Rates";
}

