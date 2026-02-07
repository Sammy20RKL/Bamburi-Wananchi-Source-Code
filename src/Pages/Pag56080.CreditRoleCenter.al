// namespace PolyTechERPSourceCode.PolyTechERPSourceCode;

page 56080 "Credit Role Center"
{
    ApplicationArea = All;
    Caption = 'Credit Role Center';
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
            // part(BOSACue; "BOSA Cue")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = true;
            // }
            // part(FOSACue; "FOSA Cue")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = false;

            // }
            part("LoansCue"; "Loans Cue")
            {
                ApplicationArea = Suite;
                Visible = true;
            }
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
            action("M-Wallets")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'M-Wallet Accounts';
                Image = Vendor;
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
                Visible = false;
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
                        RunObject = report "Other Disclosures";
                    }
                    action("Insider Lending Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insider Lending Report';
                        RunObject = report "Insider Lending & Perf Return";
                        ToolTip = 'View or Generate Agency Returns for a given period.';
                        // Visible = false;
                    }

                    action("Loans Defaulter Aging-SASRA")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Defaulter Aging';
                        RunObject = report "Loans Defaulter Aging";//"SASRA Loans Classification"
                    }

                    // action("Sectorial Lending Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Sectorial Lending Report';
                    //     RunObject = report "SECTORAL LENDING";
                    //     ToolTip = 'View or Generate Agency Returns for a given period.';
                    //     // Visible = false;
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
                        RunObject = report "Risk Class Of Assets & ProvNav";
                    }

                    // action("Loans Provisioning Summary-SASRA")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Loans Provisioning Summary';
                    //     RunObject = report "Loans Provisioning Summarys";
                    // }
                    action("Loan Sectorial Lendng-SASRA")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Sectorial Lending';
                        RunObject = REPORT "Loan Sectoral Lending Report";
                        Visible = false;
                    }
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

                    action("Polytech Trial Balance")
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
                        // RunObject = report StatementProfitorloss;
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
                Visible = false;

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
                            RunPageView = WHERE(status = CONST(closed));
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
                        Visible = true;

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
                        Caption = 'Member savings columnar report.';
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
                        Caption = 'Benificiary Report';
                        RunObject = report "nok report";//"Next of Kin Details Report"
                    }
                    action("Members Without Next of Kin")
                    {
                        ApplicationArea = All;
                        RunObject = report MemberWithoutNextOfKin;
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
                    // Visible = false;
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
                        Caption = 'Loans Defaulter Aging Nav';
                        ToolTip = 'Loans Defaulter Aging Nav';
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
                    action("Loan Defaulter Aging")
                    {
                        ApplicationArea = all;
                        Caption = 'Loans Defaulter Aging-SASRA';
                        RunObject = report "Loans Defaulter Aging";//"SASRA Loans Classification"
                        ToolTip = 'Loan Classification Report';
                    }
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
                action("LoansRescheduleList")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Loans Reschedule  List";
                    Caption = 'Loans Reschedule List';
                }
                action("Loan Calculator")
                {
                    RunObject = page "Loans Calculator List";
                }
                group("Run Commands")
                {
                    action("Loan Aging Code Unit") { RunObject = codeunit "Loan Aging Code Unit"; }
                    action("Loans Defaulter Aging Codeunit") { RunObject = codeunit "Loans Defaulter Aging Codeunit"; }
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
                        // group(DemandNoticesLists)
                        // {
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
                        // action("Recovery Letter")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = report "Recovery Letter";
                        // }
                        // 
                        action("Loan Demand Notice List(Recovery)")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Loan 4TH Demand Notices List";
                        }
                        // action("Loan CRB Notices List")
                        // {
                        //     ApplicationArea = "Basic", Suite;
                        //     RunObject = Page "Loan CRB Notices List";
                        // }


                        // }
                    }

                    /* group(GuarantorRecovery)
                    {
                        action(GuaraRecovList)
                        {
                            Caption = 'Guarantor Recovery List';
                            RunObject = page "Guarantors Recovery List";
                        }
                    } */
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
                        action("Checkoff Processing List Blocked Poly")
                        {
                            Caption = 'Bamburi Employer Remittance';
                            Image = Setup;
                            RunObject = page "Bamburi Checkoff Receipts";
                            // Visible = false;
                        }
                        action("Posted Employer Checkoff Remittance Poly")
                        {
                            Caption = 'Posted Employer Checkoff Remittance';
                            Image = Setup;
                            RunObject = page "Posted Bamburi List-Checkoff";
                            // Visible = false;
                        }
                        action("Nav Checkoff")
                        {
                            Caption = 'Check Off List';
                            Image = Setup;
                            RunObject = page "Checkoff Process-D List Nav";
                        }
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
                        action("Check off Adivice-Breakdown")
                        {
                            Image = Setup;
                            RunObject = report "Check Off Advice";
                        }
                        action("Check off Adivice-Lumpsum")
                        {
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
                            Caption = 'Post Monthly Interest';
                            Image = Setup;
                            RunObject = report "Post Monthly Interest.";
                            ToolTip = 'Used to process Loans Monthly Interest';
                        }
                        action(process)
                        {
                            Caption = 'Process Loan Interest Nav';
                            Image = Process;
                            RunObject = report "Process Loan Monthly Interest";
                        }
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


            //....................... START OF ALTERNATIVE CHANNELS MAIN MENU ...................................
            group(SwizzKash)
            {
                Visible = false;
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
                        RunObject = page "M Polytech Loans";
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
                        ToolTip = 'Get the History of M-Polytech Loans';
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
                }

            }

            //.............................. END OF ALTERNATIVE CHANNELS MAIN MENU ..................................

            group("My Services")
            {
                Visible = true;
                action("Leave Application")
                {
                    ApplicationArea = basic, suite;
                    Image = Employee;
                    // RunObject = page "HR Leave Applications List";
                }
                action("My P9 Report")
                {
                    ApplicationArea = basic, suite;
                    Image = Employee;
                    // RunObject = report MyP9port;
                    RunObject = report "P9 Report";
                }
                action("My Payslip")
                {
                    ApplicationArea = basic, suite;
                    Image = Employee;
                    // RunObject = report "My Payroll Payslip.";
                    RunObject = report "My Payroll Payslip";
                }
            }


        }

        // #endif

    }

}