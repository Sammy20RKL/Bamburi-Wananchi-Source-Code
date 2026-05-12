#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50327 "payroll Transaction Code."
{
    PageType = Card;
    SourceTable = "Payroll Transaction Code.";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                label(Control1102756006)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19065628;
                }
                group("Select one")
                {
                    Caption = 'Select one';
                    field("Transaction Type"; Rec."Transaction Type")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(Control1102756039)
                {
                    Caption = 'Select one';
                    field(Frequency; Rec.Frequency)
                    {
                        ApplicationArea = Basic;
                        ValuesAllowed = Fixed, Varied;
                    }
                }
                label(Control1102756010)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19046900;
                }
                group(Control1102756044)
                {
                    Caption = 'Select one';
                    field("Balance Type"; Rec."Balance Type")
                    {
                        ApplicationArea = Basic;
                        ValuesAllowed = None, Increasing, Reducing;
                    }
                }
                field("Transaction Type1"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Preference';
                    ValuesAllowed = Income;
                }
                group(Control1102756049)
                {
                    Caption = 'Select one';
                }
                field("Amount Preference"; Rec."Amount Preference")
                {
                    ApplicationArea = Basic;
                }
                field("Is Cash"; Rec."Is Cash")
                {
                    ApplicationArea = Basic;
                }
                field("Is Formulae"; Rec."Is Formulae")
                {
                    ApplicationArea = Basic;
                    Caption = 'Is Formula';
                }
                field(Formulae; Rec.Formulae)
                {
                    ApplicationArea = Basic;
                    Caption = 'Formula';
                }
                label(Control1102756053)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19025872;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Include Employer Deduction"; Rec."Include Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Formulae for Employer"; Rec."Formulae for Employer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Formula for Employer';
                }
                label(Control1102756054)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19080001;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Debit Account';
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Debit Account Name';
                }
                // field("Credit Account"; "Credit Account")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Credit Account';
                // }
                // field("Credit Account Name"; "Credit Account Name")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Credit Account Name';
                //     Editable = false;
                // }
                field(SubLedger; Rec.SubLedger)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting to Subledger';
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                }
                group(Control1102756055)
                {
                    Caption = 'Select one';
                    field("Special Transaction"; Rec."Special Transaction")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Include in Levy Calculation"; Rec."Include in Levy Calculation")
                {
                    ApplicationArea = Basic;
                }
                group(Control1102756068)
                {
                    Caption = 'Select one';
                    field("Special Transactions1"; Rec."Special Transaction")
                    {
                        ApplicationArea = Basic;
                        ValuesAllowed = "Life Insurance";
                    }
                    field("Deduct Premium"; Rec."Deduct Premium")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(Control1102756074)
                {
                    Caption = 'Select one';
                    field("Special Transactions2"; Rec."Special Transaction")
                    {
                        ApplicationArea = Basic;
                        ValuesAllowed = "Staff Loan";
                    }
                    group(Control1102756085)
                    {
                        Caption = 'Select one';
                        field("Repayment Method"; Rec."Repayment Method")
                        {
                            ApplicationArea = Basic;
                            ValuesAllowed = Reducing, "Straight line";
                        }
                    }
                    field("Fringe Benefit"; Rec."Fringe Benefit")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Employer Deduction"; Rec."Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Method1"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                    ValuesAllowed = Amortized;
                }
                group("Sacco Deduction Settings")
                {
                    Caption = 'Sacco Deduction Settings';
                    field("Co-Op Parameters"; Rec."Co-Op Parameters")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Sacco Deduction Type';
                    }
                    field("IsCo-Op/LnRep"; Rec."IsCo-Op/LnRep")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Is Sacco Deduction';
                    }
                    field("Loan Product"; Rec."Loan Product")
                    {
                        ApplicationArea = Basic;

                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //CurrPage.EDITABLE:=FALSE;
    end;

    var
        Text19065628: label 'Transaction Type';
        Text19046900: label 'Balance Type';
        Text19025872: label 'E.g ([005]+[020]*[24])/2268';
        Text19080001: label 'E.g ([005]+[020]*[24])/2268';
        Text19015031: label '%';
}

