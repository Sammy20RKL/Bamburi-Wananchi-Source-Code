#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 57102 "FOSA Statistics FactBox"
{
    Caption = 'M-Wallet Statistics FactBox';
    Editable = false;
    PageType = CardPart;
    SaveValues = true;
    SourceTable = Vendor;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group("Member Picture")
            {
                field(Image; Rec.Image)
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                }
            }
            group("Account Statistics FactBox")
            {
                Caption = 'Account Statistics FactBox';
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Book Balance';
                    StyleExpr = FieldStyle;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Withdrawable Balance"; sfactory.FnGetFosaAccountBalance(rec."No."))
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawable Balance';
                    StyleExpr = FieldStyle;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Uncleared Cheques"; Rec."Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'M-Polytech Balances';
                }
                field("Outstanding Balance"; Rec."Outstanding BOSA Balance")
                {
                    Style = StrongAccent;
                    Caption = 'BOSA Outstanding Principle';
                }
                field("OutstandingInterest"; Rec."Outstanding BOSA Interest")
                {
                    Style = StrongAccent;
                    Caption = 'BOSA Outstanding Interest';
                }
                // field("FOSA Outstanding Balance"; Rec."FOSA Outstanding Balance")
                // {
                //     Style = StrongAccent;
                //     Caption = 'FOSA Outstanding Principle';
                // }
                // field("FOSA Oustanding Interest"; Rec."FOSA Oustanding Interest")
                // {
                //     Style = StrongAccent;
                // }
                // field("MICRO Outstanding Principle"; Rec."MICRO Outstanding Principle")
                // {
                //     Style = StrongAccent;
                // }
                // field("MICRO Outstanding Interest"; Rec."MICRO Outstanding Interest")
                // {
                //     Style = StrongAccent;
                // }
            }
            group("Member Signature")
            {
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    Editable = false;
                }
            }
            group("Account Status")
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Blocking Account"; Rec."Reason For Blocking Account")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnOpenPage()
    var

    begin

    end;

    var
        LatestCustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry: array[4] of Record "Cust. Ledger Entry";
        AgingTitle: array[4] of Text[30];
        AgingPeriod: DateFormula;
        sfactory: Codeunit "SWIZZSFT Factory";
        I: Integer;
        PeriodStart: Date;
        PeriodEnd: Date;
        Text002: label 'Not Yet Due';
        Text003: label 'Over %1 Days';
        Text004: label '%1-%2 Days';
        MinBalance: Decimal;
        UserSetup: Record "User Setup";
        FieldStyle: Text;
        AccountType: Record "Account Types-Saving Products";
}

