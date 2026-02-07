page 56083 "Customer Care"
{
    ApplicationArea = All;
    Caption = 'Customer Care';
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
            action("Bulk Sms")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Send SMS';
                Image = Message;
                RunObject = Page "Bulk SMS Header";
                ToolTip = 'Send Bulk Sms to Members';
                // Visible = false;
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
                Caption = 'Alternative Channels';
                group(SwizzKashActivities)
                {
                    Caption = 'Mobile Banking';
                    Image = Receivables;
                    ToolTip = 'Mobile Banking .';
                    Visible = false;

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
                    Visible = false;
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

                    Visible = false;
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

    }

}