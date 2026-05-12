pageextension 50876 "BankAccountListExt" extends "Bank Account List"
{
    layout
    {
        addafter("Search Name")
        {
            field("Account Type"; Rec."Account Type")
            {
                ApplicationArea = Basic;
                Visible = false;
            }

        }
        addafter(Contact)
        {
            // field("Debit Amount"; "Debit Amount")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("Credit Amount"; "Credit Amount")
            // {
            //     ApplicationArea = Basic;
            // }

        }
        modify(Control1905767507)
        {
            Visible = false;
        }
        modify(BalanceLCY)
        {
            Visible = false;
        }

    }

    actions
    {
        addafter("Co&mments")
        {
            action(PositivePayExports)
            {
                ApplicationArea = Basic;
                Caption = 'Positive Pay Export';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Positive Pay Export";
                RunPageLink = "No." = field("No.");
                Visible = true;
            }
            action(PosPayEntries)
            {
                ApplicationArea = Suite;
                Caption = 'Positive Pay Entries';
                Image = CheckLedger;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Positive Pay Entries";
                RunPageLink = "Bank Account No." = FIELD("No.");
                RunPageView = SORTING("Bank Account No.", "Upload Date-Time")
                                  ORDER(Descending);
                ToolTip = 'View the bank ledger entries that are related to Positive Pay transactions.';
                Visible = false;
            }
            action(BankBalance)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Balance';
                Image = Balance;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Bank Account Balance";
                RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action("BankAccountStatements")
            {
                ApplicationArea = Suite;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Bank Account Statements';
                Image = "Report";
                RunObject = Report "Bank Account Statement";
                ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
            }
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        modify("&Bank Acc.")
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify("Dimensions-&Multiple")
        {
            Visible = false;
        }
        modify("Dimensions-Single")
        {
            Visible = false;
        }
        modify(Balance)
        {
            Visible = false;
        }
        modify(Statements)
        {
            Visible = false;
        }
        modify("Ledger E&ntries")
        {
            Visible = false;
        }
        modify("C&ontact")
        {
            Visible = false;
        }
        modify(CreateNewLinkedBankAccount)
        {
            Visible = false;
        }
        modify(LinkToOnlineBankAccount)
        {
            Visible = false;
        }
        modify(UnlinkOnlineBankAccount)
        {
            Visible = false;
        }
        modify(RefreshOnlineBankAccount)
        {
            Visible = false;
        }
        modify(EditOnlineBankAccount)
        {
            Visible = false;
        }
        modify(RenewAccessConsentOnlineBankAccount)
        {
            Visible = false;
        }
        modify(UpdateBankAccountLinking)
        {
            Visible = false;
        }
        modify(AutomaticBankStatementImportSetup)
        {
            Visible = false;
        }
        modify("Sent Emails")
        {
            Visible = false;
        }
        modify("Detail Trial Balance")
        {
            Visible = false;
        }
        modify("Check Details")
        {
            Visible = false;
        }
        modify("Trial Balance by Period")
        {
            Visible = false;
        }
        modify(List)
        {
            Visible = false;
        }
        modify("Receivables-Payables")
        {
            Visible = false;
        }
        modify("Trial Balance")
        {
            Visible = false;
        }
        modify("Bank Account Statements")
        {
            Visible = false;
        }
        modify(Email)
        {
            Visible = false;
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Check Report Name");
    end;

    trigger OnOpenPage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Accessed and read the bank accounts listing page');
    end;

    trigger OnClosePage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Closed bank accounts listing page');
    end;

    var
        AuditLog: Codeunit "Audit Log Codeunit";
}