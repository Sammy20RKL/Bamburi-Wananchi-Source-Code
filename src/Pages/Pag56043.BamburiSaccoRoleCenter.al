Page 56043 "Bamburi SACCO Role Center"
{
    Caption = 'Bamburi Wananchi SACCO';
    PageType = RoleCenter;



    layout
    {
        area(rolecenter)
        {

            part(Control75; "Custom Headline")
            {
                ApplicationArea = All;
                Visible = false;
            }
            part(Control99; "Finance Performance")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(BOSACue; "BOSA Cue")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            // part(FOSACue; "FOSA Cue")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = false;

            // }
            // part("LoansCue"; "Loans Cue")
            // {
            //     ApplicationArea = Suite;
            //     Visible = true;
            // }
            part("General Cue"; "General Cue")
            {
                ApplicationArea = Suite;
                Visible = true;

            }
            // part("SasraLoanClassificationCue"; "Sasra Loan Classification Cue")
            // {
            //     ApplicationArea = Suite;
            //     Visible = true;
            // }

            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            // part(Control123; "Team Member Activities")
            // {
            //     ApplicationArea = Suite;
            //     Visible = false;
            // }
            // part(Control1907692008; "My Accounts")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = false;
            // }
            // part(Control103; "Trailing Sales Orders Chart")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = false;
            // }

            // part(Control106; "My Job Queue")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = false;
            // }
            // part(Control9; "Help And Chart Wrapper")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = false;
            // }
            // part(Control100; "Cash Flow Forecast Chart")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = false;
            // }
            // part(Control108; "Report Inbox Part")
            // {
            //     AccessByPermission = TableData "Report Inbox" = IMD;
            //     ApplicationArea = Basic, Suite;
            //     Visible = false;
            // }
            // part(Control122; "Power BI Report Spinner Part")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = false;
            // }

            // systempart(Control1901377608; MyNotes)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = false;
            // }
        }
    }

    actions
    {
        area(reporting)
        {

        }
        area(embedding)
        {
            action("Chart of Account")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'Open the chart of accounts.';
                Visible = true;
            }
            action("Bank Accounts List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                visible = false;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action("M-Wallets")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'M-Wallet Accounts';
                Image = Vendor;
                Visible = true;
                RunObject = Page "Product Details Master";
                RunPageView = where("Account Type" = filter('M-Wallet'));
                ToolTip = 'View or edit detailed information for the Mobile Wallet Accounts.';

            }
            action(Members)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Members';
                Image = Customer;
                visible = true;
                RunObject = Page "Member List";
                ToolTip = 'View or edit detailed information for the Members.';
            }
            action(Loans)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Credits';
                Image = Loaner;
                Visible = true;
                RunObject = Page "Loans Posted List";
                ToolTip = 'View or edit detailed information for the Credits Accounts.';

            }
            action("Bulk Sms")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Send SMS';
                Image = Message;
                RunObject = Page "Bulk SMS Header";
                ToolTip = 'Send Bulk Sms to Members';
                Visible = false;
            }
            action("Posted Receipts List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'View Posted Receipts';
                Image = Documents;
                RunObject = Page "Posted BOSA Receipts List";
                ToolTip = 'View Posted BOSA Receipts';
                Visible = true;
            }
        }
        area(sections)
        {


            //......................... START OF FINANCIAL MANAGEMENT MENU ...........................

            group(FinancialManagement)
            {
                Caption = 'Financial Management';
                Image = Journals;
                ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';
                group("Budgeted Management")
                {
                    action("Budgets")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Budgets';
                        Image = Journal;
                        RunObject = Page "G/L Budget Names";
                        ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                    }
                    action("Actuals Vs Budget")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Budget vs Actuals';
                        Image = Journal;
                        RunObject = report "Actual Vs Budget";
                    }
                }

                action("General Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal";
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }

                group("General Ledger")
                {
                    Caption = 'General Ledger and General Journals';
                    ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.  ';
                    Visible = true;
                    action("G/L Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Register';
                        Image = Journal;
                        RunObject = Page "G/L Registers";
                    }

                    action("Chart of Accounts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Chart of Accounts';
                        RunObject = Page "Chart of Accounts";
                        ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';

                    }

                    action("G/L Navigator")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Navigator';
                        Image = Journal;
                        RunObject = Page Navigate;


                    }
                    action("Account Categories")
                    {
                        ApplicationArea = Basic, Suite;

                        Image = Journal;
                        RunObject = Page "G/L Account Categories";
                    }
                    action("Payment Journals")
                    {
                        ApplicationArea = Basic;
                        RunObject = page "Payment Journal";
                    }
                }
                //......................................................................................................................................

                group("Cash Management")
                {
                    Caption = 'Cash Management';
                    ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.  ';
                    Visible = true;

                    action("Bank Accounts Management")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Bank Accounts List';
                        RunObject = page "Bank Account List";
                    }


                    action("Voucher Cash Payments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Voucher Cash Payment';
                        RunObject = Page "Payment List";
                        Visible = false;

                    }

                    action("Cash Payments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Payments';
                        RunObject = Page "Cash Payment List";
                        Visible = false;

                    }

                    action("Bank Account Reconciliation")

                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Bank Accounts Reconcilations';
                        RunObject = page "Bank Acc. Reconciliation List";

                    }

                    action("Posted Payment Reconcilations")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Reconcilations';
                        RunObject = page "Posted Payment Reconciliations";
                        Visible = false;


                    }
                    action("Bank Reconciliation Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Reconcilations Report';
                        RunObject = report "Bank Account - List";
                        Visible = false;

                    }
                    action("Bank Reconciliation Summaary Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Reconcilations Summary Report';
                        RunObject = report BankReconiliationsummary;
                        //Visible = false;

                    }


                    action("Payment Reconcilations JOURNALS")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Reconcilations Journals';
                        RunObject = page "Payment Reconciliation Journal";
                        Visible = false;

                    }



                }
                //........................................................................................................................................           

                group("SASRA Reports")
                {
                    Caption = 'SASRA Reports';
                    ToolTip = 'which highlights the operations and performance of the SACCO industry during the year ended';
                    Visible = true;
                    action("Capital Adequacy Return")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Capital Adequacy Return';
                        RunObject = report "CAPITAL ADEQUACY RETURN";
                        ToolTip = 'View or Generate Deposit Return SASRA for a given period.';
                    }

                    action("Investiment Return")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Investiment Return';
                        RunObject = report "RETURN ON INVESTMENT";
                        ToolTip = 'View or Generate Deposit Return SASRA for a given period.';
                        // Visible = false;
                    }
                    action("Liquidity Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Liquidity Statement';
                        RunObject = report Liquidity;
                        ToolTip = 'View or Generate Deposit Return SASRA for a given period.';
                        // Visible = false;
                    }
                    action("Form2F Statement of CompIncome")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of comprehensive Income';
                        RunObject = report "Form2F Statement of CompIncome";
                        ToolTip = 'View or Generate Deposit Return SASRA for a given period.';
                        // Visible = false;
                    }
                    action("Deposits Return-SASRA")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Deposits Return';
                        Image = Report;
                        RunObject = report "Deposit returnN";
                    }
                    action("Statement of Financial Position")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Financial Position';
                        RunObject = report "STATEMENT OF FINANCIAL P";
                        ToolTip = 'View or Generate Deposit Return SASRA for a given period.';
                        // Visible = false;
                    }
                    action("Other Disclosures")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Other Disclosures';
                        RunObject = report "Other Disclosures";// "Other Disclosures..";//
                    }
                    // action("Other Disclosures 2")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Other Disclosures Nav';
                    //     RunObject = report "Other Disclosures..";
                    //     Visible = false;
                    // }
                    action("Insider Lending Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insider Lending Report';
                        RunObject = report "Insider Lending & Perf Return";
                        ToolTip = 'View or Generate Agency Returns for a given period.';
                        Visible = false;
                    }
                    action("InsiderLending")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insider Lending';
                        RunObject = report InsiderN;
                    }
                    // action("Loans Defaulter Aging-SASRA")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Loans Defaulter Aging';
                    //     RunObject = report "Loans Defaulter Aging";//"SASRA Loans Classification"
                    //     Visible = false;
                    // }

                    action("Risk Class of Assets")
                    {
                        Visible = false;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Risk Classification and Loan Provisioning';
                        RunObject = report "Risk Class Of Assets & Prov";
                    }
                    action("Risk Class of Assets Nav")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Risk Classification and Loan Provisioning';
                        RunObject = report "Risk Class Assets & Prov Nav";// 
                        // RunObject = report "Risk Class Of Assets & ProvNav";
                    }

                    // action("Loans Provisioning Summary-SASRA")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Loans Provisioning Summary';
                    //     RunObject = report "Loans Provisioning Summarys";
                    // }
                    // action("Loan Sectorial Lendng-SASRA")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Loan Sectorial Lending';
                    //     RunObject = REPORT "Loan Sectoral Lending Report";
                    //     Visible = false;
                    // }
                    action("Loan Sectorial Lendng-Nav")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Sectorial Lending -Nav';
                        RunObject = REPORT "SECTORAL LENDING";
                    }

                }
                //..........................................................................................................................................
                group("Receipt Processing")
                {
                    action("Create Receipt")
                    {
                        ApplicationArea = all;
                        Image = Journal;
                        RunObject = page "Receipt Header List";
                    }
                    action("Posted Receipts")
                    {
                        ApplicationArea = all;
                        Image = Journal;
                        RunObject = page "Posted Receipt Header List";
                    }
                }
                group("Payments Processing")
                {
                    Caption = 'Payment Processing';
                    ToolTip = 'Process incoming and outgoing payments.';
                    Visible = true;

                    action("Payment Vouchers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Vouchers Posting';
                        Image = Journal;
                        RunObject = Page "Payment List";
                    }

                    action("Posted Payment Vouchers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Payment Vouchers';
                        Image = Journal;
                        RunObject = Page "Posted Payment List";

                    }

                    action("Petty Cash Payment")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash Payment';
                        RunObject = page "PettyCash Payment List";
                    }

                    action("Posted Petty Cash")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Petty Cash';
                        RunObject = page "Posted PettyCash Payment List";
                    }
                    action("Sitting Allowance Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Board Sitting Allowance Report';
                        RunObject = report "Sitting Allowance Members";
                    }

                }
                Group(FundsTranfer)
                {
                    Caption = 'Funds Tranfer';


                    action("FundTransList")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Funds Transfer';
                        RunObject = Page "Funds Transfer List";
                    }

                    action("PostedFundTrans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Funds Transfer';
                        RunObject = Page "Posted Funds Transfer List";
                    }

                    action("EFT")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Electronic Funds Tranfer';
                        RunObject = Page "EFT list";
                    }

                }
                //............................................................................................

                group("Other Financials")
                {
                    action("Trade Creditors")
                    {
                        ApplicationArea = basic, Suite;
                        RunObject = page TradeCreditors;

                    }
                    // action("Ex-Member Creditors")
                    // {
                    //     ApplicationArea = basic, Suite;
                    //     RunObject = page Ex_MemberCreditors;

                    // }
                    action(EmployerReceivables)
                    {
                        ApplicationArea = all;
                        Caption = 'Employer Receivables';
                        RunObject = page EmployerReceivables;
                    }
                }
                group("Assets Management")
                {
                    Caption = 'Assets Management';
                    ToolTip = 'Record and Manage Assets.';
                    Visible = true;
                    action("Asset Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Assets Register';
                        RunObject = Page "Fixed Asset List";
                        ToolTip = 'Assets Register.';
                    }

                    action("Fixed Asset G/L Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed Asset G/J Journal';
                        RunObject = Page "Fixed Asset G/L Journal";
                        ToolTip = 'Record Asset Movement.';
                        visible = false;
                    }


                    action("Fixed Asset Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed Asset Journal';
                        RunObject = Page "Fixed Asset Journal";
                        ToolTip = 'View all Sacco Assets.';
                        Visible = false;
                    }

                    action("Fixed Asset Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed Asset Setup';
                        RunObject = page "Fixed Asset Setup";

                    }
                    group("Fixed Asset Report")
                    {


                        action("Fixed Asset List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Fixed Asset List';
                            RunObject = report "Fixed Asset - List";

                        }
                        action("Fixed Asset Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Fixed Asset Register';
                            RunObject = report "Fixed Asset Register";

                        }

                        action("Fixed Assets Book Value1")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Fixed Assets Book Value 1';
                            RunObject = report "Fixed Asset - Book Value 01";//FixeAssetbookValueReport;

                        }
                        action("Fixed Assets Book Value2")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Fixed Assets Book Value 2';
                            RunObject = report "Fixed Asset - Book Value 02";//FixeAssetbookValueReport;
                        }

                    }



                }
                group(Payables)
                {
                    Caption = 'Payables';
                    action(vendors)
                    {
                        ApplicationArea = all;
                        Caption = 'Vendor List';
                        RunObject = Page "Vendor List";
                        RunPageView = where("Account Type" = filter('<>M-Wallet'));
                        ToolTip = 'View Vendor List';
                        Visible = true;
                    }
                    action("Purchase Invoicing")
                    {
                        ApplicationArea = all;
                        Caption = 'Purchase Invoicing';
                        RunObject = Page "Purchase Invoices";
                        Visible = true;
                    }
                    action("Purchase Credit Memo")
                    {
                        ApplicationArea = all;
                        Caption = 'Purchase Credit Memo';
                        RunObject = Page "Purchase Credit Memo";
                        Visible = true;
                    }

                }
                group(Receivables)
                {
                    caption = 'Receivables';
                    action(Customers)
                    {
                        ApplicationArea = all;
                        Caption = 'Customers';
                        RunObject = Page "Customer List";
                        RunPageView = where("Customer Type" = filter(BOSA | STAFF),
                            "Customer Posting Group" = filter('BOSA' | 'STAFF'));
                        Visible = true;
                    }
                    action("Customer Invoices")
                    {
                        ApplicationArea = all;
                        Caption = 'Customer Invoices';
                        RunObject = Page "Sales Invoice List";
                        Visible = true;
                    }
                    action("Sales Memo")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Memo';
                        RunObject = page "Sales Credit Memo";
                        Visible = true;
                    }
                }



                //.................................................................................................................................................

                group("Finance Statements")
                {
                    Caption = 'Financial Statements';
                    ToolTip = 'Display Financial Statements.';
                    Visible = true;

                    action("Bamburi Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Summarised Trial Balance';
                        RunObject = report "Trial Balance2016";
                        ToolTip = 'Generate Trial Balance for a given period.';
                    }
                    action("Account Schedules")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Account Schedules';
                        RunObject = page "Financial Reports";

                    }

                    action("LiquidityReport")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Liquidity Report';
                        Image = Journal;
                        RunObject = report Liquidity;
                        ToolTip = 'Generate Liquidity Report for a given period.';
                        Visible = false;
                    }

                }


                //.......................................................................................................................................
                group("Mkopo Reports")
                {
                    Caption = 'Mkopo Reports';
                    action(SaccoInformationReport)
                    {
                        ApplicationArea = All;
                        Caption = 'Sacco Information Report';
                        RunObject = report "Sacco Information";

                    }
                    action("Statement of Directors'RE")
                    {
                        ApplicationArea = All;
                        Caption = 'Statement of Directors Responsibilities';
                        // RunObject = report "Statement of Directors'RE";
                    }
                    action(Reportofthedirectors)
                    {
                        ApplicationArea = All;
                        // RunObject = report "REPORT OF THE DIRECTORS";
                        Caption = 'Report of the Directors';
                    }
                    action("Financial Statical Information")
                    {
                        ApplicationArea = All;

                        // RunObject = report FinancialStaticalInformation;
                    }
                    action("Statement of Financial Position Mkopo")
                    {
                        ApplicationArea = All;
                        Caption = 'Satement of Financial Position';
                        // RunObject = report "State of financial Position";
                    }
                    action("Statement of profit or loss and other comprehensive income")
                    {
                        ApplicationArea = All;
                        Caption = 'Statement of profit or loss and other comprehensive income';
                        // RunObject = report Sta   tementProfitorloss;
                    }
                    action("Statement of changes of Equity Current")
                    {
                        ApplicationArea = All;
                        Caption = 'Statement of Changes im Equity';
                        // RunObject = report StatementOfChangesInEquity;
                    }
                    // action("Statement of changes of Equity Previous")
                    // {
                    //     ApplicationArea = All;
                    //     RunObject = report StatchangesinequityPrevious;
                    // }
                    action("Statement OF Cash Flows")
                    {
                        ApplicationArea = All;
                        Caption = 'Cash Flows';
                        // RunObject = report cashFlows;
                    }
                }
                //.......................................................................................................................................

                //..................................................................................................................................
                group("Periodic Activities")
                {
                    Caption = 'Periodic Activities';
                    ToolTip = ' All Finance Module Setups ';
                    Visible = true;

                    action("Update Loan Aging")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Aging New';
                        RunObject = report "loan aging new";
                    }

                    action("Close Income Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Close Income Statement';
                        RunObject = report "Close Income Statement";
                    }
                    action("Sacco Information")
                    {
                        ApplicationArea = Basic, Suite;

                        RunObject = page "Sacco Information";
                    }
                    action("Create Accounting Period")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Create and Close Accounting Period';
                        RunObject = page "Accounting Periods";
                    }

                    // action("Update Liquidity")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     caption = 'Update Liquidity Report';

                    // }
                }




                // }

            }

            //.................................START OF MEMBERSHIP MANAGEMENT..................................
            group(MembershipManagement)
            {
                Caption = 'Membership Management';

                action(MembersList)
                {
                    ApplicationArea = all;
                    Caption = 'Member Accounts';
                    RunObject = Page "Member List";
                    ToolTip = 'View Member Accounts';
                    Visible = true;
                }
                group(Registration)
                {
                    group("Account Opening New")
                    {
                        Caption = 'Membership Registration';
                        action(NewAccountOpening)
                        {
                            ApplicationArea = All;
                            Caption = 'New Account Opening';
                            RunObject = page "Membership Application List";
                            RunPageView = WHERE(status = CONST(open));
                            RunPageMode = Edit;
                        }
                        action(NewAccountPending)
                        {
                            ApplicationArea = All;
                            Caption = 'Applications Pending Approval';
                            RunObject = page "Membership Application List";
                            RunPageView = WHERE(status = CONST("Pending Approval"));
                            RunPageMode = View;
                        }

                        action(NewApprovedAccounts)
                        {
                            ApplicationArea = all;
                            Caption = 'Applications Pending Creation';
                            RunObject = page "Membership Application List";
                            RunPageView = WHERE(status = CONST(approved));
                        }
                        action("CreatedAccounts")
                        {
                            ApplicationArea = all;
                            Caption = 'Closed Membership Applications';
                            RunObject = page "Membership Applications List";
                            RunPageView = where(status = CONST(closed));
                            Visible = true;
                        }

                    }
                    action("Membership Rejoining List")
                    {
                        ApplicationArea = All;
                        RunObject = page "Membership Rejoining List";
                    }
                }
                group("Membership Exit")
                {

                    action("Member Withdrawal List")
                    {
                        ApplicationArea = all;
                        RunObject = page "Membership Exit List";

                    }

                    action("Approved Membership Exit")
                    {
                        ApplicationArea = all;
                        RunObject = page "Membership Exit List-Posted";
                        RunPageView = where(status = const(Approved), posted = const(false));
                    }

                    action("Posted Membership Exit")
                    {
                        ApplicationArea = all;
                        RunObject = page "Membership Exit List-Posted";
                        RunPageView = where(Posted = const(true));
                    }
                    action("Deposit Refund Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Deposit Refund Report";
                    }


                }
                group("Membership Re-Application")
                {
                    action("Member Re-Application List")
                    {

                        RunObject = page "Member Re-Application List";
                        Enabled = true;
                        ApplicationArea = all;
                    }
                    action("Member Re-Application posted")
                    {

                        RunObject = page "MemberRe-ApplicationListPosted";
                        Enabled = true;
                        Caption = ' Member Re-Application Posted';
                        ApplicationArea = all;
                    }
                }
                group("Member Reports")
                {

                    Caption = 'Membership Reports';
                    action("Sacco Membership Reports")
                    {
                        ApplicationArea = all;
                        Caption = 'Member Accounts';
                        RunObject = Page "Member List";
                        ToolTip = 'View Member Accounts';
                        Visible = false;

                    }
                    /* action("Member Account Balances Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Account  balances";
                        ToolTip = 'Member Account Summary Report.';
                    } */
                    action(MembersavingReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Member savings report.';
                        RunObject = report "Member savings report";

                    }
                    action(MemberWelfareReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Member Welfare Report.';
                        RunObject = report "Member Welfare Contributions";

                    }
                    action(memberwithoutsharecapitalReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Members without minimum share capital report.';
                        RunObject = report MemberwithoutMinshapitalreport;

                    }

                    action(MemberwithoutPassportReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Members without passports report.';
                        RunObject = report Memberswithoutpassportsreport;

                    }
                    action(MemberwithoutSignatureReport)
                    {
                        ApplicationArea = all;
                        Caption = ' Members without signature report.';
                        RunObject = report Memberwithoutsignaturereport;

                    }
                    action(MemberApplicationReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Member application report';
                        RunObject = report MembershipApplicationReport;
                    }
                    action(MemberswithoutLoanReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Members Without Loan report';
                        RunObject = report MemberwithoutLoanReport;
                    }
                    action(MembersReport)
                    {
                        ApplicationArea = all;
                        Caption = 'Members Register';
                        RunObject = report MemberReport;
                        ToolTip = 'Members Report Contains all Members status';
                    }
                    action("Membership Closure Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Membership Exit Reports';
                        RunObject = report "Membership Closure Report";

                    }


                    //
                    action("Member Next Of Kin Details")
                    {
                        ApplicationArea = All;
                        Caption = 'Next of Kin Report';
                        RunObject = report "nok report";//"Next of Kin Details Report"
                    }
                    action("Members Without Next of Kin")
                    {
                        ApplicationArea = All;
                        RunObject = report "Member Missing NOK";
                    }
                    action("Member shares Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Share Capital Statement";
                    }
                    action("Member Deposits Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Members Deposits Statement";
                    }
                    action("Member Detailed Statement")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Detailed Statement";
                    }
                    action("Member Dividends Statement")
                    {
                        ApplicationArea = all;
                        RunObject = report "Members Dividend Statement";// "Member Account Statement";
                    }
                }

            }

            //'''''''''''''''''''''''''''''''''''''''''END OF MEMBERSHIP MANAGEMENT

            //.....................................START OF LOAN MANAGEMENT
            group(SaccoLoansManagement)
            {
                Caption = 'Credit Management';
                ToolTip = 'Manage BOSA Loans Module';
                group("Import Loans BC240")
                {
                    Visible = false;
                    Caption = 'Post Existing Loans';
                    action("Import Loans")
                    {
                        ApplicationArea = All;
                        Caption = 'Import Loans Page';
                        RunObject = page "Existing Loans";
                    }
                }
                group("BOSA Loans Management")
                {
                    Caption = 'New BOSA Loans Applications';
                    ToolTip = 'BOSA Loans'' Management Module';
                    action("BOSA Loan Application")
                    {
                        ApplicationArea = All;
                        Caption = 'BOSA Loan Application List';
                        Image = Loaners;
                        RunObject = Page "Loan List-New Application BOSA";
                        ToolTip = 'Open BOSA Loan Applications List';
                        RunPageView = where(Posted = const(false), "Loan Status" = const(Application));
                    }
                    action("Pending BOSA Loan Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'BOSA Loans Pending Approval';
                        Image = CreditCard;
                        RunObject = Page "LoanList-Pending Approval BOSA";

                        ToolTip = 'Open the list of BOSA Loans Pending Approval';
                    }
                    action("Approved Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'BOSA Loans Pending Disbursement.';
                        RunObject = Page "Loan Application BOSA-Approved";
                        ToolTip = 'Open the list of Approved Loans Pending Disbursement.';
                    }
                    action("PostedLoansBosa")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'BOSA Posted Loans';
                        RunObject = Page "Loans Posted List";
                        ToolTip = 'Open the list of the Loans Posted.';
                    }
                }

                group("Loans Appeals")
                {
                    Visible = false;
                    Caption = 'Loan Restructure';
                    action("Loan Appeal List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loan Appeal List";
                        Caption = 'Loans Restructure List';
                    }
                    action("Loans Appealed Posted")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loan Appeal List";
                        Caption = 'Loans Restructured List';
                    }

                }

                group("Loans' Reports")
                {
                    action("Loan Aging 1")
                    {
                        ApplicationArea = all;
                        RunObject = report "loan aging new Nav";
                        Caption = 'Loan Aging New';
                        ToolTip = 'Loan Aging New';
                        Visible = true;
                    }
                    action("Loan Aging 2")
                    {
                        ApplicationArea = All;
                        RunObject = report "Loans Defaulter Aging Nav";
                        Caption = 'Loans Defaulter Aging SASRA';
                        ToolTip = 'Loans Defaulter Aging SASRA';
                        Visible = true;
                    }
                    action("Loans Balances Report")
                    {
                        ApplicationArea = all;
                        RunObject = Report "Loan Balances Report";
                        Caption = 'Member Loans Book Report';
                        ToolTip = 'Member Loans Book Report';
                        Visible = true;
                    }
                    // action("Loan Defaulter Aging")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Loans Defaulter Aging-SASRA';
                    //     RunObject = report "Loans Defaulter Aging";//"SASRA Loans Classification"
                    //     ToolTip = 'Loan Classification Report';
                    //     Visible = false;
                    // }
                    action("Loan Collection Targets Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Loan Monthly Expectation";
                        ToolTip = 'Loan Collection Targets';
                        Caption = 'Loan Collection Targets';
                    }

                    action("Loans Guard Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Loan Guard Report";
                        ToolTip = 'Loans Guard Report';
                    }
                    action("Loan defaulter List")
                    {
                        ApplicationArea = all;
                        RunObject = report "Loan Defaulters List";
                    }
                    action("Loans Register")
                    {
                        ApplicationArea = all;
                        Caption = 'Member Loan Register';
                        RunObject = Report "Loans Register";
                        ToolTip = 'Loan Register Report';
                        Visible = true;
                    }

                    action("Loans Arreas Report")
                    {
                        ApplicationArea = all;
                        RunObject = Report "Loan Arrears1";
                        Caption = 'Loan Arrears Report';
                        visible = true;
                    }

                    action("Loans Guarantor Details Report")
                    {
                        ApplicationArea = all;
                        RunObject = Report "Loans Guarantor Details Report";
                        ToolTip = 'Loans Securities Report';
                    }
                    action("Secutiy Manangement Register")
                    {
                        ApplicationArea = all;
                        RunObject = Report "Secutiy Manangement Register";
                        ToolTip = 'Loans Securities Report';
                        Caption = 'Securities Report';
                        Visible = true;
                    }
                    action("Monthly Exp Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "monthly exp Bamburi";
                        Caption = 'Monthly Expectation Checkoff';
                    }
                    action(CheckoffByCustomerBank)
                    {
                        ApplicationArea = all;
                        RunObject = report CheckoffByCustomerBank;
                        Caption = 'CheckOff Bank Grouping';
                    }

                }

                action("PostedLoans")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted BOSA Loans';
                    RunObject = Page "Posted Loans List";
                    ToolTip = 'Open the list of the Loans Posted.';
                }
                group("Loan Rescheduling")
                {
                    Visible = false;
                    action("LoansRescheduleList")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loans Reschedule  List";
                        Caption = 'Loans Reschedule List';
                    }
                    action("LoansRescheduledList")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loans Rescheduled List";
                        Caption = 'Rescheduled Loans';
                    }
                }
                action("Loan Calculator")
                {
                    RunObject = page "Loans Calculator List";
                }
                group("Run Commands")
                {
                    Visible = false;
                    // action("Loan Aging Code Unit") { RunObject = codeunit "Loan Aging Code Unit"; }
                    // action("Loans Defaulter Aging Codeunit") { RunObject = codeunit "Loans Defaulter Aging Codeunit"; }
                    action("Update Arrears") { RunObject = codeunit LoanAgingProcessor; }
                    // action("2PostedLoansBosa")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Double Posted Loans';
                    //     ToolTip = 'Open the list of Loans where Outstanding Balance > Approved Amount';
                    //     Image = List;

                    //     trigger OnAction()
                    //     var
                    //         LoansPage: Page "Loans Posted List";
                    //         LoansRec: Record "Loans Register";
                    //     begin
                    //         LoansRec.Reset();
                    //         LoansRec.SetFilter("Outstanding Balance", '>%1', 0); // optional base filter
                    //                                                              // Then filter in memory
                    //         if LoansRec.FindSet() then begin
                    //             repeat
                    //                 if LoansRec."Outstanding Balance" <= LoansRec."Approved Amount" then
                    //                     LoansRec.Mark(false)
                    //                 else
                    //                     LoansRec.Mark(true);
                    //             until LoansRec.Next() = 0;
                    //             LoansRec.MarkedOnly(true);
                    //         end;

                    //         LoansPage.SetTableView(LoansRec);
                    //         LoansPage.Run();
                    //     end;
                    // }

                }
            }

            group(BosaManagement)
            {
                Caption = 'Other Bosa Management Functions';
                //................................................START OF CHANGE REQUEST MENU.........................
                group(ChangeRequest)
                {
                    Caption = 'Change Request';
                    action("Change Request")
                    {
                        ApplicationArea = All;
                        Caption = 'Change Request List';
                        RunObject = Page "Change Request List";
                        ToolTip = 'Change Member Details';
                    }

                    group(ReportsChangereq)
                    {
                        caption = 'Change Request Reports ';
                        action(ChangeReqMobile)
                        {
                            ApplicationArea = All;
                            Caption = 'Change Req(mobile)';
                            Visible = false;
                            // Promoted = true;
                            // PromotedCategory = Process;
                            //RunObject = report "Change Request Report(Mobile)";
                        }
                    }

                    action(updatedchangereqslist)
                    {
                        ApplicationArea = All;
                        Caption = 'Updated Change requests';
                        RunObject = page "Updated Change Request List";
                    }

                }


                //...........................START OF TRANSFERS MENU .........................................
                group(Transfers)
                {
                    Caption = 'Sacco Transfers';
                    action(TransfersList)
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Transfers List';
                        Image = Customer;
                        RunObject = page "BOSA Transfer List";
                        ToolTip = 'Make member receiptings for payments done by member';
                        Visible = false;
                    }

                    // action(ApprovedTransfers)
                    // {
                    //     ApplicationArea = basic, suite;
                    //     Caption = 'Approved Transfer List';
                    //     Image = Customer;
                    //     RunObject = page "BOSA Transfer Posted";
                    //     ToolTip = 'BOSA Transfer Posted';
                    //     RunPageView = where(Posted = const(false), approved = const(true));

                    // }

                    action(SaccoTransfersList)
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Sacco Transfers List';
                        Image = Customer;
                        RunObject = page "Sacco Transfer List";
                        RunPageView = where(Posted = const(false));
                    }
                    action(PostedTransfers)
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Posted Transfer List';
                        Image = Customer;
                        RunObject = page "Sacco Transfer List";
                        ToolTip = 'BOSA Transfer Posted';
                        RunPageView = where(Posted = const(true));
                        // Visible = false;

                    }
                    action(InternalTransferPosted)
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Internal Transfer Posted';
                        Image = PostedPayment;
                        RunObject = page "Posted Internal Transfers";
                        ToolTip = 'Posted member transfers payments done by member';
                        Visible = true;
                    }
                }
                //......................................................................................


                group("Bosa Receipts")
                {
                    Caption = 'Bosa Receipts';

                    action("Bosa Receipt")
                    {
                        ApplicationArea = All;
                        Caption = 'Bosa Receipts';
                        RunObject = page "BOSA Receipts List";
                    }

                    action(" Posted Bosa Receipt")
                    {
                        ApplicationArea = All;
                        caption = 'Posted Bosa Receipts';
                        RunObject = page "Posted BOSA Receipts List";
                    }
                }

                //.............................Collateral Management..........................................

                group("Collateral Management")
                {
                    // visible = false;
                    action(Collateralreg)
                    {
                        Caption = 'Loan Collateral Register';
                        Image = Register;
                        RunObject = page "Loan Collateral Register List";
                    }
                    action(CollateralSch)
                    {
                        Caption = 'Loan Collateral Depreciation Schedule';
                        RunObject = page "Collateral Depr. Schedule";
                        Visible = false;
                    }
                    action(collateralsetup)
                    {
                        Caption = 'Loan collateral Setup';
                        RunObject = page "Loan Collateral Setup";
                        Visible = false;
                    }
                    action("Loan Updates")
                    {
                        ApplicationArea = Basic, Suite;
                        visible = false;
                        RunObject = page "Loan Update List";
                        Caption = 'Loan Updates';
                    }
                    action("Monthly Advice")
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                        RunObject = page "Monthly Advice List";
                    }
                    action("Appraisal Salary Details")
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                        RunObject = page "Appraisal Salary Details List";
                    }
                    action("Batches List")
                    {
                        ApplicationArea = Basic, Suite;
                        Visible = false;
                        RunObject = page "Batches List";
                    }
                    // group(CollateralReports)
                    // {
                    //     Caption = 'Collateral Movement';
                    //     action(ColateralsReport)
                    //     {
                    //         Caption = 'Collateral Report';
                    //         RunObject = report "Collaterals Report";
                    //     }

                    // }
                    group(ArchiveCollateral)
                    {
                        Caption = 'Archive';
                        action(Effectedcollatmvmt)
                        {
                            Caption = 'Effective Collateral Movement';
                            //RunObject = page "Effected Collateral Movement";
                            Visible = false;
                        }
                    }


                }

                //.........................End of Collateral Management......................................


                //...................................Guarantor Management........................................
                group("Guarantor Management")
                {
                    Caption = 'Guarantor Management';
                    action("Guarantor Substitution List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Guarantorship Sub List";
                    }
                    action("Effected Guarantor Substitution")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Loans Guarantee Details";
                    }
                    action("Member Loans Guaranteed")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loans Guaranteed Report";

                    }

                    action("Members Loan  Guarantors")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Members Loans Guarantors";

                    }
                    action("Update Loan  Guarantors")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = codeunit "Guarantor Management";
                    }

                }

                //..................................End of Guarantor Management......................................

                //......................................Start of Defaulter Management............................
                group("Defaulter's Management")
                {
                    Caption = 'Defaulter Management';
                    group(demandnotices)
                    {
                        action("Loan 1st Demand Notice List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Loan 1st Demand Notices List";
                        }
                        action("Loan 2st Demand Notice List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Loan 2nd Demand Notices List";
                        }
                        action("Loan 3rd Demand Notice List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Loan 3rd Demand Notices List";
                        }
                        action("Loan Demand Notice List(Recovery)")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Loan 4TH Demand Notices List";
                        }
                    }

                    group(loanRecovery)
                    {
                        Caption = 'Loan Recovery';
                        //Guarantor Revocery List && & Loan Recoveries List
                        action(GuaraRecovList)
                        {
                            Caption = 'Guarantor Recovery List';
                            RunObject = page "Guarantors Recovery List";
                        }
                        //choose which serves both purposes
                        action(LoanRecovList)
                        {
                            Caption = 'Open Loan Recovery List';
                            RunObject = page "Loan Recovery List";
                            RunPageView = WHERE(Status = CONST(open));
                        }

                        action(PLoanRecovList)
                        {
                            Caption = 'Pending Approval Loan Recovery List';
                            RunObject = page "Loan Recovery";
                            RunPageView = WHERE(Status = CONST(pending));
                        }
                        action(ALoanRecovList)
                        {
                            Caption = 'Approved Loan Recovery List';
                            RunObject = page "Loan Recovery";
                            RunPageView = WHERE(Status = CONST(approved));
                        }
                        action(PostedLoanRecovList)
                        {
                            Caption = 'Posted Loan Recovery List';
                            RunObject = page "Loan Recovery";
                            RunPageView = WHERE(Status = CONST(closed));
                            Visible = false;

                        }
                    }

                }


                //.......................................End of Defaulter Management .................................
                group("Holiday Savings")
                {
                    action("Process Holiday savings")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Process Holiday Savings";
                    }
                    action(HolidaySavingsList)
                    {
                        Caption = 'Holiday Savings List';
                        RunObject = page "Member Holiday Savings List";
                    }

                }

                //..............................................................................................

                group(BOSAPeriodicActivities)
                {
                    Caption = 'Periodic Activities';
                    group(CheckOffBlockedPoly)
                    {
                        Caption = 'Checkoff Processing';
                        action("Checkoff Processing")
                        {
                            Caption = 'Bamburi Employer Remittance';
                            Image = Setup;
                            RunObject = page "Bamburi Checkoff Receipts";
                            // RunObject = page "Bosa Receipts H List-Checkoff";
                            // Visible = false;
                        }
                        action("Posted Employer Checkoff Remittance Poly")
                        {
                            Caption = 'Posted Employer Checkoff Remittance';
                            Image = Setup;
                            RunObject = page "Posted Bamburi List-Checkoff";
                            // Visible = false;
                        }
                        // action("Nav Checkoff")
                        // {
                        //     Caption = 'Check Off List';
                        //     Image = Setup;
                        //     RunObject = page "Checkoff Process-D List Nav";
                        // }
                    }

                    group(CheckOffAdvice)
                    {
                        Caption = 'Check-Off Advice';
                        action("Monthly Exp Report Main")
                        {
                            ApplicationArea = all;
                            RunObject = report "monthly exp Bamburi";
                            Caption = 'Monthly Expectation Checkoff';
                        }
                        // action("Check off Adivice-Breakdown")
                        // {
                        //     Image = Setup;
                        //     RunObject = report "Check Off Advice";
                        // }
                        action("Check off Adivice-Lumpsum")
                        {
                            Visible = false;
                            Image = Setup;
                            RunObject = report "Check Off Advice-Lumpsum";
                        }

                        action("Checkoff Expectation By Bank")
                        {
                            Image = Setup;
                            RunObject = report CheckoffByCustomerBank;
                        }

                    }
                    group(MonthlyInterestProcessing)
                    {
                        Caption = 'Monthly Interest Processing';
                        action("Post Monthly Interest")
                        {
                            // Visible = false;
                            Caption = 'Individual Interest Processing';
                            Image = Setup;
                            RunObject = report "Post Monthly Interest.";
                            ToolTip = 'Used to process Loans Monthly Interest for a particular Member/Loan';
                        }
                        // action(process)
                        // {
                        //     Visible = false;
                        //     Caption = 'Process Loan Interest Nav';
                        //     Image = Process;
                        //     RunObject = report "Process Loan Monthly Interest";
                        // }
                        action("Loan Interest List")
                        {
                            Caption = 'Loan Interest List';
                            Image = Setup;
                            RunObject = page "Loan Interest List";
                        }
                    }
                    group(Dividends)
                    {
                        Caption = 'Dividends';

                        group(Prorated)
                        {
                            Caption = 'Prorated';
                            action("Dividends Processing-Prorated")
                            {
                                Caption = 'Dividends Processing-Prorated';
                                Image = Setup;
                                RunObject = report "Dividend Processing-Prorated";
                            }
                            action("Dividends Header List")
                            {
                                Caption = 'Dividends Header List';
                                Image = Setup;
                                RunObject = page "Dividends Header List";
                            }
                            action("Dividends Register")
                            {
                                Caption = 'Dividends Register';
                                Image = Setup;
                                RunObject = report "Dividend Register";
                            }
                            action(DividendProgressionSlip)
                            {
                                Caption = 'Dividend Progression Slip';
                                Image = Setup;
                                RunObject = report "Dividends Progressionslip";
                                Visible = false;
                            }
                            action("Dividends Payments Report")
                            {
                                ApplicationArea = all;
                                RunObject = Report "Dividends Payments";

                            }
                            action("Process Dividends 2")
                            {
                                ApplicationArea = all;
                                RunObject = Report "Process Dividends for member";
                            }
                            action("Dividends To Loan Arrears")
                            {
                                //Caption = 'Dividends Processing-Prorated';
                                Image = Setup;
                                RunObject = report "Dividend Transfer To ArreaLoan";
                            }
                        }
                        group("Share capital Manangement")
                        {
                            action("Share Capital Recovery")
                            {
                                Image = ReceiveLoaner;
                                ApplicationArea = all;
                                Caption = 'Recover Sharecapital from Deposits';
                                RunObject = report "Share Capital Recovery";
                            }
                            group(SharecapitalTrading)
                            {
                                action(SharecapitalTradingList)
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = page "Share Capital Trading List";
                                    Caption = 'Sharecapital Trading List';
                                }
                                action(SharecapitalTradingListPosted)
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = page "Share Capital Trading Posted";
                                    Caption = 'Sharecapital Trading List Posted';

                                }
                            }
                        }



                    }
                }

            }

            group(AllReport)
            {
                Caption = 'Bamburi Wananchi Banking Reports';
                group("Membership/Product Management")
                {
                    action("Members Deposit Listing")
                    {
                        RunObject = report "ANNEX 3 - MEMBER Deposits";
                        ToolTip = 'Show Deposits Listing Report';
                    }
                    action("Members Shares Listing")
                    {
                        RunObject = report "ANNEX 4 - MEMBER Shares";
                        ToolTip = 'Show Shares Listing Report';
                    }
                    action("Next of Kin")
                    {
                        Caption = 'Next of Kin Report';
                        RunObject = report "nok Report";
                    }
                    action("Members Missing Next of Kin")
                    {
                        ApplicationArea = All;
                        RunObject = report "Member Missing NOK";
                    }
                }
                group("Credit Reports")
                {
                    action("Loans Disbursment Listing")
                    {
                        RunObject = report "Loans Register-Net";
                    }
                    action("Loan Recovery Report")
                    {
                        RunObject = report "Loan Recovery Rprt";
                    }
                    action("Insinder Lending Board")
                    {
                        RunObject = report "Insider Loans Board";
                    }
                    action("Insinder Lending Employee")
                    {
                        RunObject = report "Insider Loans Employee";
                    }
                    action("Loans Defaulter Aging")
                    {
                        Caption = 'Loans Defaulter Aging SASRA';
                        // RunObject = report "Loans Defaulter Aging 130";
                        RunObject = report "Loans Defaulter Aging Nav";
                    }
                    group("Loan Aging New")
                    {
                        Visible = false;
                        action("Run Aging")
                        {
                            Caption = 'Process Loan Aging New';
                            ToolTip = 'Process Loan Aging New';
                            RunObject = codeunit LoanAgingProcessor;
                        }
                        action("Loan Aging nav")
                        {
                            ApplicationArea = all;
                            RunObject = report "loan aging new Nav";
                            Caption = 'Loan Aging New';
                            ToolTip = 'Loan Aging New';
                            Visible = true;
                        }
                    }
                }
            }
            //....................... START OF ALTERNATIVE CHANNELS MAIN MENU ...................................
            group(SwizzKash)
            {
                Caption = 'Alternative Channels';
                group(SwizzKashActivities)
                {
                    Caption = 'Mobile Banking';
                    Image = Receivables;
                    ToolTip = 'Mobile Banking .';

                    action("SwizzKashApplications")
                    {
                        Caption = 'M-Banking Applications';
                        Image = Calls;
                        RunObject = page "SwizzKash Applications";
                        RunPageView = WHERE(status = filter('<>Approved'));
                        ToolTip = 'Membership Applicaton for SwizzKash.';
                    }
                    action("RegisteredSwizzKashMembers")
                    {
                        Caption = 'M-Banking Registered Members';
                        Image = PostedReceipt;
                        RunObject = page "SwizzKash Mobile Members";
                        RunPageView = WHERE(status = CONST(Approved));
                        ToolTip = 'Member Receipts for payments done.';

                    }
                    action("M-Banking PIN Reset")
                    {
                        Caption = 'M-Banking PIN Reset';
                        Image = PostedReceipt;
                        RunObject = page "Mobile PIN Reset";
                        ToolTip = 'Member Receipts for payments done.';

                    }
                    action("PM-Banking PIN Reset")
                    {
                        Caption = 'Pending M-Banking PIN Reset';
                        Image = PostedReceipt;
                        RunObject = page "SwizzKash pending PIN Reset";
                        RunPageView = WHERE("PIN Requested" = CONST(true));
                        ToolTip = 'Member Receipts for payments done.';

                    }

                    action("SurePesaTransactions")
                    {
                        Caption = 'M-Banking Transactions';
                        Image = PostedReceipt;
                        RunObject = page "SwizzKash Transactions";
                        ToolTip = 'Surepesa Transactions.';

                    }
                    action("Mobile Loans")
                    {
                        Caption = 'Mobile Loans';
                        Image = PostedReceipt;
                        // RunObject = page "Mobile Loans";
                        RunObject = page "M Bamburi Loans";
                        ToolTip = 'View Mobile Loans List.';
                    }

                }
                group("Paybill Management")
                {
                    Caption = 'Paybill Deposits';
                    Image = Receivables;
                    ToolTip = 'Manage Paybill Deposits.';
                    action("All Paybill Deposits")
                    {
                        Caption = 'All Paybill Transactions';
                        Image = PostedReceipt;
                        RunObject = page "SwizzKash Paybill Trans";
                        ToolTip = 'View Paybill Deposits.';

                    }
                    action("Bamburi Paybill Transactions")
                    {
                        Caption = 'Bamburi Paybill Transactions';
                        Image = ReceiptLines;
                        RunObject = page "Bamburi Paybill Transactions";
                        ToolTip = 'This page contains C2B Transactions for paybill Number 751459';
                    }
                    action("Import Paybills")
                    {
                        Image = PostedReceipt;
                        RunObject = page "SwizzKash Paybill Buffer";

                    }

                }
                group("SMS Messages")
                {
                    Caption = 'SMS Messages';

                    ToolTip = 'SMS Messages.';
                    action("SentSMS")
                    {
                        Caption = 'Sent SMS';
                        Image = PostedReceipt;
                        RunObject = page "SMS Messages";
                        ToolTip = 'Sent SMS.';
                    }

                    action("Send BULK SMS")
                    {
                        Caption = 'Send BULK SMS';
                        Image = PostedReceipt;
                        RunObject = page "Bulk SMS Header List";
                        ToolTip = 'Sent SMS.';

                    }


                }
                group("Portal Activities")
                {
                    Caption = 'Online Banking';
                    action("PortalApplications")
                    {
                        Caption = 'Online Portal Users';
                        Image = Calls;
                        RunObject = page "Online Portal Users";
                    }
                    action("Portal Audit Trail")
                    {
                        Caption = 'Portal Audit Trail';
                        Image = PostedReceipt;
                        RunObject = page "Portal Audit Trail";
                    }
                    action("Portal Feedback")
                    {
                        Caption = 'Portal Feedback';
                        Image = PostedReceipt;
                        RunObject = page "Portal Feedback";
                    }
                    action("Online Loans")
                    {
                        Caption = 'Online Loan Applications';
                        Image = PostedMemo;
                        RunObject = page "Online Loan Applications";
                    }

                }
                group("Alternative Channels Setups")
                {
                    Caption = 'Alternative Channels Setup';

                    ToolTip = 'SMS Messages.';
                    action("M-Banking Charges Setup")
                    {
                        Caption = 'M-Banking Charges Setup';
                        Image = PostedReceipt;
                        RunObject = page "SMS Messages";
                        ToolTip = 'Sent SMS.';
                    }

                    action("Agency Banking Charges")
                    {
                        Caption = 'Agency Banking Charges Setup';
                        Image = PostedReceipt;
                        RunObject = page "Bulk SMS Header List";
                        ToolTip = 'Sent SMS.';

                    }
                    action("ATM  Charges")
                    {
                        Caption = 'ATM Charges Setups';
                        Image = PostedReceipt;
                        RunObject = page "Bulk SMS Header List";
                        ToolTip = 'Sent SMS.';
                    }
                    action("Mobile Loans Transactions")
                    {
                        Caption = 'Mobile Loans Transactions';
                        Image = PaymentHistory;
                        RunObject = page "Mobile Loans Transactions";
                        ToolTip = 'Get the History of M-Bamburi Loans';
                    }
                    action("Wallets Setup")
                    {
                        Caption = 'Create M-Wallets';
                        Image = CreateDocuments;
                        RunObject = codeunit SwizzKashMobile;
                        ToolTip = 'Create Wallet Accounts';
                    }
                    action(Portal)
                    {
                        Caption = 'Debug Portal';
                        RunObject = codeunit PORTALIntegration;
                        Image = RollUpCosts;
                    }
                    action(RunNotifications)
                    {
                        Caption = 'Process Notifications';
                        Image = SendConfirmation;
                        RunObject = codeunit SwizzKashMobile;
                    }
                }

            }

            //.............................. END OF ALTERNATIVE CHANNELS MAIN MENU ..................................
            group("Payment Management")
            {
                Caption = 'Payment Process';
                Image = Payables;
                ToolTip = 'Payment Process.';
                Visible = false;
                action("Check Payment")
                {

                    Caption = 'Check Payment ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    //RunObject = page "Payment Voucher List";
                    ToolTip = 'Payment Voucher List.';
                }

                action("Cash Payment")
                {

                    Caption = 'New Petty Cash Payments List ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    //RunObject = page "New Petty Cash Payments List";
                    ToolTip = 'New Petty Cash Payments List.';
                }
                action("Posted Cash Payment")
                {

                    Caption = 'Posted Cash Payment';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    //RunObject = page "Posted Petty Cash Payments";
                    ToolTip = 'Posted Cash Payment';
                }
                action("Posted Cheque Payment")
                {

                    Caption = 'Posted Cheque Payment';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    //RunObject = page "Posted Cheque Payment Vouchers";
                    ToolTip = 'Posted Cheque Payment';
                }

                action("Funds Transfer List")
                {
                    Caption = 'Funds Transfer List';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    // RunObject = page "Funds Transfer List";
                    ToolTip = 'Funds Transfer List';
                }

                action("Posted Funds Transfer List")
                {
                    Caption = 'Posted Funds Transfer List';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    //RunObject = page "Posred Funds Transfer List";
                    ToolTip = 'Posted Funds Transfer List';
                }

                action("Receipt Header List")
                {
                    Caption = 'Receipt Header List';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    //RunObject = page "Receipt Header List";
                    ToolTip = 'Receipt Header List';
                }

                action("Posted Receipt Header List ")
                {
                    Caption = 'Posted Receipt Header List ';
                    ApplicationArea = Basic, Suite;
                    Image = PostedOrder;
                    //RunObject = page "Posted Receipt Header List";
                    ToolTip = 'Posted Receipt Header List ';
                }

            }


            //........................... End of CRM MAIN MENU ...............................................
            group(Action16)
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;
                Visible = false;
                ToolTip = 'Manage depreciation and insurance of your fixed assets.';
                action(Action17)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action("Fixed Assets G/L Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets G/L Journals';
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation, in integration with the general ledger. The FA G/L Journal is a general journal, which is integrated into the general ledger.';
                }
                action("Fixed Assets Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets Journals';
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                }
                action("Fixed Assets Reclass. Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets Reclass. Journals';
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "FA Reclass. Journal Batches";
                    ToolTip = 'Transfer, split, or combine fixed assets by preparing reclassification entries to be posted in the fixed asset journal.';
                }
                action(Insurance)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance';
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "Insurance List";
                    ToolTip = 'Manage insurance policies for fixed assets and monitor insurance coverage.';
                }
                action("Insurance Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance Journals';
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "Insurance Journal Batches";
                    ToolTip = 'Post entries to the insurance coverage ledger.';
                }
                action("Recurring Fixed Asset Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Recurring Fixed Asset Journals';
                    // Promoted = true;
                    // PromotedCategory = Process;
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                    ToolTip = 'Post recurring fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                }
            }
            group("Human Resources")
            {
                // Visible = false;
                group("Employee Management")
                {
                    action("EmployeesList")
                    {
                        Caption = 'Employees List';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Employee List";
                    }
                }
                group("Leave Management")
                {
                    Image = Administration;
                    Caption = 'Leave Management';
                    group("Leave")
                    {
                        Caption = 'Leave Applications';
                        action("Leave Applications-Open")
                        {
                            RunObject = page "Leave Application List";
                            RunPageLink = Status = const(Open);
                            ToolTip = 'Executes the Leave Applications action';
                            Caption = 'Leave Applications-Open';
                        }
                        action("Leave Applications-Pending Approval")
                        {
                            RunObject = page "Leave Application List";
                            RunPageLink = Status = const("Pending Approval");
                            ToolTip = 'Executes the Leave Applications action';
                            Caption = 'Leave Applications-Pending';
                        }
                        action("Leave Applications-Approved")
                        {
                            RunObject = page "Leave Application List";
                            RunPageLink = Status = const(Released);
                            ToolTip = 'Executes the Leave Applications action';
                            Caption = 'Leave Applications-Approved';
                        }
                        action("Leave Applications-Rejected")
                        {
                            RunObject = page "Leave Application List";
                            RunPageLink = Status = const(Rejected);
                            ToolTip = 'Executes the Leave Applications action';
                            Caption = 'Leave Applications-Rejected';
                        }
                    }
                    group("Leave Adjustments ")
                    {
                        action("Leave Adjustments")
                        {
                            RunObject = page "Leave Adjustment List";
                            RunPageLink = Posted = filter(false);
                            ToolTip = 'Executes the Leave Adjustments action';
                            Caption = 'Leave Adjustments';
                        }
                        action("Posted Leave Adjustments")
                        {
                            RunObject = page "Leave Adjustment List";
                            RunPageLink = Posted = filter(true);
                            ToolTip = 'Executes the Posted Leave Adjustments action';
                            Caption = 'Posted Leave Adjustments';
                        }
                    }
                    group("Leave Recalls")
                    {
                        action("Leave Recall")
                        {
                            RunObject = page "Leave Recall List";
                            RunPageLink = Completed = filter(false);
                            ToolTip = 'Executes the Leave Recall action';
                            Caption = 'Leave Recall';
                        }
                        action("Completed Leave Recalls")
                        {
                            RunObject = page "Leave Recall List";
                            RunPageLink = Completed = filter(true);
                            ToolTip = 'Executes the Completed Leave Recalls action';
                            Caption = 'Completed Leave Recalls';
                        }
                    }
                    group("Leave Planner ")
                    {
                        Caption = 'Leave Planner ';
                        action("Leave Planner")
                        {
                            RunObject = page "Leave Planner List";
                            ToolTip = 'Executes the Assign Leave Days action';
                            Caption = 'Leave Planner';
                        }
                    }
                    group("Leave Reports")
                    {
                        Caption = 'Leave Reports';
                        action("Leave Applications Report")
                        {
                            RunObject = report "Leave Applications";
                            ToolTip = 'Executes the Leave Balances action';
                            Caption = 'Leave Applications';
                        }
                        action("Leave Balances")
                        {
                            RunObject = report "Leave Balance";
                            ToolTip = 'Executes the Leave Balances action';
                            Caption = 'Leave Balances';
                        }
                        action("Leave Statement")
                        {
                            RunObject = report "HR Staff Leave Statement";
                            ToolTip = 'Executes the Leave Statement action';
                            Caption = 'Leave Statement';
                        }
                    }
                    group("Leave Archive")
                    {
                        action("Leave Ledger")
                        {
                            RunObject = page "HR Leave Ledger Entries";
                            Caption = 'Leave Ledger Entries';
                        }
                    }
                }

                group("HR Setup")
                {
                    Caption = 'HR Setup';

                    action("General Setup")
                    {
                        Caption = 'General Setup';
                        ApplicationArea = All;
                        RunObject = page "HR Setup";
                    }
                    action("HR Set up")
                    {
                        Caption = 'Human Resources Setup';
                        RunObject = page "Human Resources Setup";
                        ApplicationArea = All;
                    }
                    group("Leave Setups")
                    {
                        Caption = 'Leave Setups';
                        action("Leave Types")
                        {
                            RunObject = page "Leave Types Setup";
                            ToolTip = 'Executes the Leave Types action';
                            Caption = 'Leave Types';
                        }
                        action("Leave Period")
                        {
                            RunObject = page "Leave Periods";
                            ToolTip = 'Executes the Leave Period action';
                            Caption = 'Leave Period';
                        }
                        action("Base Calendar")
                        {
                            RunObject = page "Base Calendar List";
                            ToolTip = 'Executes the Base Calendar List action';
                            Caption = 'Base Calendar';
                        }
                    }

                }

            }

            group("Swizz Payroll Management")
            {
                group("Payroll Employees")
                {
                    action("Payroll Employee List")
                    {
                        RunObject = page "Payroll Employee List.";
                        ApplicationArea = All;

                    }
                    action("Payroll Earnings List.")
                    {
                        RunObject = page "Payroll Earnings List.";
                        ApplicationArea = All;

                    }
                    action("Payroll Deductions List.")
                    {
                        RunObject = page "Payroll Deductions List.";
                        ApplicationArea = All;
                        Visible = false;

                    }
                    action("Payroll Employee Earnings.")
                    {
                        RunObject = page "Payroll Employee Earnings.";
                        ApplicationArea = All;
                        Visible = false;

                    }
                    action("Payroll Employee Deductions.")
                    {
                        RunObject = page "Payroll Employee Deductions.";
                        ApplicationArea = All;
                        Visible = false;

                    }

                }
                group("Payroll Periodic Activities")
                {
                    action("Payroll Employee Transactions")
                    {
                        RunObject = page "Payroll Employee Transactions";
                        ApplicationArea = All;
                    }
                    action("Payroll Periods")
                    {
                        RunObject = page "Payroll Periods.";
                        ApplicationArea = All;
                    }

                    action("Transfer Payroll to journal")
                    {
                        RunObject = report "Payroll JournalTransfer.";
                        ApplicationArea = All;

                    }
                    action("General Journal")
                    {
                        RunObject = page "General Journal";
                        ApplicationArea = All;
                        Visible = false;

                    }

                }
                group(Reports1)
                {
                    Caption = 'Reports';
                    action("Payroll Employees Report")
                    {
                        RunObject = report "Payroll Employees Report.";
                        ApplicationArea = All;
                    }
                    // action("Payroll allowances Report")
                    // {
                    //     RunObject = report "payroll Allowances Report.";
                    //     ApplicationArea = all;
                    // }
                    // action("payroll Deductions Report.")
                    // {
                    //     RunObject = report "payroll Deductions Report.";
                    //     ApplicationArea = All;
                    // }
                    action("SHIF Report")
                    {
                        RunObject = report "NHIF Schedule W..";

                        ApplicationArea = all;
                    }
                    action("NSSF Report")
                    {
                        RunObject = report "NSSF Schedule W..";
                        ApplicationArea = all;
                    }
                    action("Payroll Summary")
                    {
                        RunObject = report "Payroll Summary";
                        ApplicationArea = All;
                    }
                    action("Payroll Payee")
                    {
                        RunObject = report "PAYE Schedule";
                        ApplicationArea = All;
                    }
                    action("P9 Report")
                    {
                        RunObject = report "P9 Report";
                        ApplicationArea = All;
                    }
                    action("Staff Salaries Report")
                    {
                        RunObject = report "Staff Salaries Report";
                        Caption = 'Staff Loan Report';
                        ApplicationArea = all;
                    }


                }
                group(Setup1)
                {
                    Caption = 'Payroll Setup';
                    action("Payroll PAYE Setup")
                    {
                        RunObject = page "Payroll PAYE Setup.";
                        ApplicationArea = All;
                    }
                    action("Payroll NSSF Setup")
                    {
                        RunObject = page "Payroll NSSF Setup.";
                        ApplicationArea = All;
                    }
                    action("Payroll NHIF Setup")
                    {
                        RunObject = page "Payroll NHIF Setup.";
                        ApplicationArea = All;
                    }
                    action("Payroll Posting Group")
                    {
                        RunObject = page "Payroll Posting Group.";
                        ApplicationArea = All;
                    }
                    action("Payroll Transaction List")
                    {
                        RunObject = page "Payroll Transaction List.";
                        ApplicationArea = All;
                    }
                    // action("Salary Grade Structures")
                    // {
                    //     RunObject = page "Salary grade Structures";
                    //     ApplicationArea = All;
                    // }
                    action("Payroll Period Transactions")
                    {
                        RunObject = page "Payroll Period Transaction.";
                        ApplicationArea = All;
                    }
                    action("Payroll Transaction Codes")
                    {
                        RunObject = page "Payroll Transaction Codes";
                        ApplicationArea = All;
                    }
                    action("Payroll General Setup LIST")
                    {
                        RunObject = page "Payroll General Setup LIST.";
                        ApplicationArea = All;
                    }


                }

            }
            group(SetupAndExtensions)
            {

            }

            group("System Administration")
            {
                group("Payments Setup")
                {
                    Caption = 'Payment Setup';
                    Image = Setup;
                    ToolTip = 'Payment Setup.';
                    action("Funds Genral Setup")
                    {

                        Caption = 'Funds General Setup. ';
                        ApplicationArea = Basic, Suite;
                        Image = Check;
                        RunObject = page "Funds General Setup";
                        ToolTip = 'Funds General Setup.';
                    }



                    action("Receipt and Payment Types List")
                    {

                        Caption = 'Receipt and Payment Types List';
                        ApplicationArea = Basic, Suite;
                        Image = Setup;
                        RunObject = page "Receipt and Payment Types List";
                        ToolTip = 'Receipt and Payment Types List';
                    }
                }

                group("Address setup")
                {
                    action("Postal codes")
                    {
                        RunObject = page "Post Codes";
                        ApplicationArea = all;
                    }
                    action("Sacco Employers")
                    {
                        RunObject = page "Employer list";
                        ApplicationArea = all;
                    }
                    action("Next of Kin Relations Types")
                    {
                        RunObject = page "Relationship list";
                        ApplicationArea = all;
                    }
                }
                action("Sacco General Setup")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Sacco General Set-Up";

                }
                action("Sacco No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Sacco No. Series";

                }


                action("Payment Types List")
                {

                    Caption = 'Payment Types Setup';
                    ApplicationArea = Basic, Suite;
                    Image = Setup;
                    RunObject = page "Payment Types List";
                    ToolTip = 'Payment Types Setup';
                }
                action("Tax codes")
                {
                    RunObject = page "Funds Tax Codes";
                    ApplicationArea = all;
                }

                group("Sacco Workflow Mgmt")
                {
                    Visible = true;
                    action("Workflow Categories")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Workflow Categories";

                    }
                    action("Workflows Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page Workflows;

                    }
                    action("Workflow User Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Workflow User Groups";
                    }
                }



                group(MembershipSetUps)
                {
                    Caption = 'Membership Setups';
                    action("Customer Risk Rating")
                    {
                        Caption = 'Customer Risk Rating';
                        Image = Setup;
                        RunObject = page "Customer Risk Rating";
                    }
                    action("member due diligence")
                    {
                        Caption = 'Member Due Diligence';
                        Image = Setup;
                        RunObject = page "Member Due Diligence Measure";
                    }
                    action("Product Risk Rating")
                    {
                        Caption = 'Product Risk Rating';
                        Image = Setup;
                        RunObject = page "Product Risk Rating";
                    }
                }
                group(userssetup)
                {
                    caption = 'User Setups';
                    action(userAccountsSetups)
                    {
                        Caption = 'User Account Setups';
                        Image = Setup;
                        RunObject = page "User Setup";
                    }

                    action("Approval User Setup")
                    {
                        Caption = 'User Approval Setup';
                        Image = Setup;
                        RunObject = page "Approval User Setup";
                    }

                    action("User Permisions")
                    {
                        Caption = 'User Account Permissions';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Status Change Permisions";
                    }
                    action("User Permisionss")
                    {
                        Caption = 'Cheque Truncation';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Cheque Truncation details buff";
                    }

                    action("User Branch Setup")
                    {
                        Caption = 'Users Branch Setups';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "User Branch Set Up";
                    }

                    action("Funds User Setup")
                    {
                        Caption = 'Funds User Setup ';
                        ApplicationArea = Basic, Suite;
                        Image = Check;
                        RunObject = page "Funds User Setup";
                        ToolTip = 'Funds User Setup';
                    }
                    action("User Workflow Setup")
                    {
                        Caption = 'User Workflow Setup';
                        ApplicationArea = Basic, Suite;
                        Image = Check;
                        RunObject = page "Workflows";

                    }

                    action("Supervisor Approval Levels")
                    {
                        Caption = 'SuperUser Approvals Setup';
                        ApplicationArea = Basic, Suite;
                        Image = Check;
                        RunObject = page "Supervisor Approvals Levels";

                    }
                    action("Supervisory and Employees")
                    {
                        Caption = 'Supervisory and Employees';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Supervisory$Empl";
                    }
                }

                group(loanssetup)
                {
                    Caption = 'BOSA Setup';
                    action(LoansproductSetup)
                    {
                        Caption = 'Loans Product Setup';
                        Image = Setup;
                        RunObject = page "Loan Products Setup List";
                    }

                    action("Update Loans Category")
                    {
                        ApplicationArea = Basic, Suite;
                        // RunObject = report "Loans Defaulters Aging -(Auto)";
                    }
                    // action("Update Loans Category2")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = report "Consolidated loan report-sasra";
                    // }

                    // action("Fosa loans admin")
                    // {
                    //     RunObject = page AdminLoansList;
                    //     visible = false;
                    // }

                }

                group("Finance Setups")
                {

                    Caption = 'Finance Setups';
                    ToolTip = ' All Finance Module Setups ';
                    Visible = true;
                    action("General Ledger setup")
                    {
                        ApplicationArea = Basic;
                        RunObject = Page "General Ledger Setup";

                    }
                    action("Accounting Period Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Accounting Period Setup';
                        RunObject = page "Accounting Periods";
                    }
                    action("Funds Transaction Types")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Funds Transaction Types';
                        RunObject = page "Funds Transaction Types";
                    }
                }


                Group("FundsTransferSetup")
                {
                    Caption = 'Funds Tranfer Setups';


                    action("FundsGeneralSetup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Funds General Setup';
                        RunObject = Page "Funds General Setup";
                    }


                    action("RepaymentTypes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Funds Repayment Funds';
                        RunObject = Page "Funds General Setup";
                    }

                    action("ReceiptTypes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Funds Receipt Types';
                        RunObject = Page "Funds General Setup";
                    }


                }

                // group(HumanResourceSetups)
                // {
                //     Caption = 'Human Resource Settings';
                //     action(HRGeneralSetup)
                //     {
                //         Caption = 'General Setup';
                //         ApplicationArea = basic, suite;
                //         RunObject = page "HR General Setup";
                //     }
                //     action(HRLeaveTypes)
                //     {
                //         Caption = 'Leave Types';
                //         ApplicationArea = basic, suite;
                //         RunObject = page "HR Leave Types";
                //     }
                //     action(HRLeavePeriods)
                //     {
                //         Caption = 'Leave Periods';
                //         ApplicationArea = basic, suite;
                //         RunObject = page "HR Leave Periods";
                //     }
                //     action(HRJournalTemp)
                //     {
                //         Caption = 'HR Journal Templates';
                //         ApplicationArea = basic, suite;
                //         RunObject = page "HR Leave Journal Template";
                //     }
                //     action(HRJournalBatch)
                //     {
                //         Caption = 'HR Journal Batches';
                //         ApplicationArea = basic, suite;
                //         RunObject = page "HR Leave Batches";
                //     }
                // }


                // group("Payroll Setups")
                // {
                //     action(payrollearningssetup)
                //     {
                //         Caption = 'Payroll Earnings List';
                //         ApplicationArea = basic, suite;
                //         RunObject = page "Payroll Earnings List";
                //     }
                //     action(payrolldeductionssetup)
                //     {
                //         Caption = 'Payroll Deductions List';
                //         ApplicationArea = basic, suite;
                //         RunObject = page "Payroll Deductions List";
                //     }
                //     action(payesetup)
                //     {
                //         Caption = 'Payroll PAYE SETUP';
                //         ApplicationArea = basic, suite;
                //         RunObject = page "Payroll PAYE Setup";
                //     }
                //     action(NHIF)
                //     {
                //         Caption = 'Payroll NHIF SETUP';
                //         ApplicationArea = basic, suite;
                //         RunObject = page "Payroll NHIF Setup";
                //     }
                //     action(NSSF)
                //     {
                //         Caption = 'Payroll NSSF SETUP';
                //         ApplicationArea = basic, suite;
                //         RunObject = page "Payroll NSSF Setup";
                //     }
                //     action(Payrolposting)
                //     {
                //         Caption = 'Payroll Posting group';
                //         ApplicationArea = basic, suite;
                //         RunObject = page "Payroll Posting Group";
                //     }
                //     action(PayrollGeneralSetup)
                //     {
                //         Caption = 'Payroll General Setup';
                //         ApplicationArea = basic, suite;
                //         RunObject = page "Payroll General Setup";
                //     }

                // }

                // group("TellersTreasury")
                // {
                //     Caption = 'Treasury and Teller Setups';
                //     action("Treasurry List")
                //     {
                //         Caption = 'Treasury List';
                //         Image = CashFlow;
                //         RunObject = page "Treasury List";
                //     }
                //     action("Teller Till List")
                //     {
                //         Caption = 'Teller Till List';
                //         Image = CashFlow;
                //         RunObject = page "Teller Till List";
                //     }
                // }


                group("workflow")
                {

                    Caption = 'Posting Group Setup';
                    // action("Update Pictures")
                    // {
                    //     Caption = 'Update Pictures';
                    //     Image = CashFlow;
                    //     RunObject = report "get pictures";
                    // }
                    action("Posting groups")
                    {
                        Caption = 'Customer Posting Groups';
                        Image = CashFlow;
                        RunObject = page "Customer Posting Groups";
                    }
                    action("Transaction type  Mapping")
                    {
                        Caption = 'Transaction Type  Mapping';
                        Image = CashFlow;
                        RunObject = page "Transaction Types Mapping";
                    }
                }
                group("Developer Automations")
                {
                    group(CEEPNEW)
                    {
                        // action("Generate Monthly FOSA Interest")
                        // {
                        //     RunObject = REPORT "Generate Monthly FOSA Interest";
                        //     Visible = false;
                        // }
                        // action("CEEP Loan Status Performance Report")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = report "Group Performance Status";
                        //     Visible = false;
                        // }
                        // action("CEEP Collections Report ")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = report "CEEP Collections Report";
                        //     Visible = false;
                        // }
                        // action("CEEP Targets & Variance Report")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = report "CEEP Targets & Variance Report";
                        //     Visible = false;
                        // }

                        // action("Main Automation")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = codeunit "Main Automation";
                        //     Visible = false;
                        // }
                    }
                    // action("Bulk Insert Member Pics")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     //RunObject = report "get pictures";
                    //     //RunObject = codeunit 50;
                    // }
                    // action("Insert Signatories")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = codeunit 50049;
                    // }
                    // action("Bulk Insert Vendor Pics")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = report "get pictures-FOSA";
                    // }
                    // action("Recovery on Loans Automation")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Recovery on Loans Automation';
                    //     RunObject = codeunit 50053;
                    // }
                }


            }
            group("Audit Trails")
            {
                action("User Audit Trails")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Users Trail";
                }
                action("Session Tracker")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Session Tracker";
                }
                action("Transaction Log")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "System Transaction Log";
                }
                action("Posting Audit Trail")
                {
                    ApplicationArea = all;
                    RunObject = report "Ledger enries audit Trail";
                }
                action("Read Log")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "System Change Entry Log";
                    Caption = 'System Change Entry Log';
                }

                action("User ID")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "User";
                    Caption = 'User ID';
                }

                action("Log Reg")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "LogReg";
                    Caption = 'Log Reg';
                }

                action("Log Reg Minutes")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "LogRegMinutes";
                    Caption = 'Log Reg Minutes';
                }

                action("Approval Details")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Approval Details";
                    Caption = 'Approval Details';
                }

                action("Approval Details Rec")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Approval Details rec";
                    Caption = 'Approval Details Rec';
                }
            }


            group("Periodic Processes")
            {
                action("Generate Loan Schedule")
                {
                    // RunObject = codeunit "Regenerate loan repayment sch";
                    image = CostAccountingDimensions;
                    Visible = false;
                    ToolTip = 'Generate Loan Performance Classification and New Schedule';
                    Enabled = true;
                }


            }


        }

        // #endif

    }

}


