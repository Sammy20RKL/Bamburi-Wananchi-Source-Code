pageextension 50628 "ChartOfAccountsCardExt" extends "G/L Account Card"
{

    layout
    {

        addafter(Reporting)
        {
            group(Budgetary)
            {
                Visible = false;

                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Budgeted Credit Amount"; Rec."Budgeted Credit Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Budgeted Debit Amount"; Rec."Budgeted Debit Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

            }
            group("SASRA REPORTS SETUP")
            {
                Caption = 'SASRA REPORTS SETUP';
                field(StatementOfFP; Rec.StatementOfFP)
                {
                    ApplicationArea = Basic;
                }
                field(StatementOfFP2; Rec.StatementOfFP2)
                {
                    ApplicationArea = Basic;
                }
                field("Form2F(Statement of C Income)"; Rec."Form2F(Statement of C Income)")
                {
                    ApplicationArea = Basic;
                }
                field("Form2F1(Statement of C Income)"; Rec."Form2F1(Statement of C Income)")
                {
                    ApplicationArea = Basic;
                }
                field("Capital adequecy"; Rec."Capital adequecy")
                {
                    ApplicationArea = Basic;
                }
                field(Liquidity; Rec.Liquidity)
                {
                    ApplicationArea = Basic;
                }
                field("Form2E(investment)"; Rec."Form2E(investment)")
                {
                    ApplicationArea = Basic;
                }
                field("Form 2H other disc"; Rec."Form 2H other disc")
                {
                    ApplicationArea = Basic;
                }
                field("Form2E(investment)New"; Rec."Form2E(investment)New")
                {
                    ApplicationArea = Basic;
                }
                field("Form2E(investment)Land"; Rec."Form2E(investment)Land")
                {
                    ApplicationArea = Basic;
                }
                field(ChangesInEquity; Rec.ChangesInEquity)
                {
                    ApplicationArea = Basic;
                }


            }
            group("Mkopo Setup")
            {
                field(Assets; Rec.Assets)
                {
                    ApplicationArea = all;
                }
                field(MkopoLiabilities; Rec.MkopoLiabilities)
                {
                    ApplicationArea = all;
                    Caption = 'Liabilities';
                }
                field(FinancedBy; Rec.FinancedBy)
                {
                    ApplicationArea = all;
                    Caption = 'Financed By';
                }
                field(Financials; Rec.Financials)
                {
                    ApplicationArea = all;
                }
                field(Incomes; Rec.Incomes)
                {
                    Caption = 'Incomes and Expenses';
                    ApplicationArea = all;
                }
                field(Others; Rec.Others)
                {
                    Caption = 'Other Mkopo Paramters';
                    ApplicationArea = all;
                }
                field("Budget Controlled"; Rec."Budget Controlled") { ApplicationArea = All; }
            }
        }

    }
    trigger OnOpenPage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Accessed and read the G/L account page no-' + Format(Rec."No.") + ' Name-' + Format(Rec.Name));
    end;

    trigger OnClosePage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Closed G/L account page no-' + Format(Rec."No.") + ' Name-' + Format(Rec.Name));
    end;

    var
        AuditLog: Codeunit "Audit Log Codeunit";
        GlEntry: Record "G/L Entry";
        Edit: Boolean;

}