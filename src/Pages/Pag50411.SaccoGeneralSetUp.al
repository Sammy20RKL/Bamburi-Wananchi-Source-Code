#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50411 "Sacco General Set-Up"
{
    ApplicationArea = Basic;
    PageType = Card;
    SourceTable = "Sacco General Set-Up";
    UsageCategory = Administration;
    InsertAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Setup';
                field("Min. Member Age"; Rec."Min. Member Age")
                {
                    ApplicationArea = Basic;
                }
                field("Retirement Age"; Rec."Retirement Age")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Contribution"; Rec."Min. Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Min. Deposit Contribution';
                }
                field("Memb.Withdrawl Maturity Period"; Rec."Memb.Withdrawl Maturity Period")
                {
                    ApplicationArea = Basic;
                }
                field("Retained Shares"; Rec."Retained Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital Amount';
                }
                field("Min Deposit Cont.(% of Basic)"; Rec."Min Deposit Cont.(% of Basic)")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Take home"; Rec."Minimum Take home")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum take home FOSA"; Rec."Minimum take home FOSA")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Non Contribution Periods"; Rec."Max. Non Contribution Periods")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Loan Application Period"; Rec."Min. Loan Application Period")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Statement Period"; Rec."Bank Statement Period")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal Statement Period';
                }
                field("Deposits Multiplier"; Rec."Deposits Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum No of Guarantees"; Rec."Maximum No of Guarantees")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Guarantors"; Rec."Min. Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Guarantors"; Rec."Max. Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Capital Reserve"; Rec."Capital Reserve")
                {
                    ApplicationArea = Basic;
                }
                field("Member Can Guarantee Own Loan"; Rec."Member Can Guarantee Own Loan")
                {
                    ApplicationArea = Basic;
                }
                /* field("Dividend (%)"; Rec."Dividend (%)")
                {
                    ApplicationArea = Basic;
                } */
                field("Interest on Deposits (%)"; Rec."Interest on Deposits (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Top Up Commision(%)"; Rec."Loan Top Up Commision(%)")
                {
                    ApplicationArea = Basic;
                }
                /* field("Min. Dividend Proc. Period"; Rec."Min. Dividend Proc. Period")
                {
                    ApplicationArea = Basic;
                }
                field("Div Capitalization Min_Indiv"; Rec."Div Capitalization Min_Indiv")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Capitalization Minimum Deposit_Individula';
                    ToolTip = 'Less this Deposits the System will capitalize part of your dividend based on the Dividend Capitalization %';
                }
                field("Div Capitalization Min_Corp"; Rec."Div Capitalization Min_Corp")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Capitalization Minimum Deposit_Corporate Account';
                    ToolTip = 'Less this Deposits the System will capitalize part of your dividend based on the Dividend Capitalization %';
                }
                field("Div Capitalization %"; Rec."Div Capitalization %")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Capitalization %'; 
                }*/
                field("Days for Checkoff"; Rec."Days for Checkoff")
                {
                    ApplicationArea = Basic;
                }
                field("Boosting Shares Maturity (M)"; Rec."Boosting Shares Maturity (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Contactual Shares (%)"; Rec."Contactual Shares (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Use Bands"; Rec."Use Bands")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Contactual Shares"; Rec."Max. Contactual Shares")
                {
                    ApplicationArea = Basic;
                }
                /*  field("Withholding Tax (%)"; Rec."Withholding Tax (%)")
                 {
                     ApplicationArea = Basic;
                 } */
                field("Welfare Contribution"; Rec."Welfare Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance Contribution';
                }
                field("ATM Expiry Duration"; Rec."ATM Expiry Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Share Contributions"; Rec."Monthly Share Contributions")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Co-op Bank Amount"; Rec."ATM Card Co-op Bank Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Fund Amount"; Rec."Risk Fund Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Deceased Cust Dep Multiplier"; Rec."Deceased Cust Dep Multiplier")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposit Refund Multiplier-Death';
                }
                field("Begin Of Month"; Rec."Begin Of Month")
                {
                    ApplicationArea = Basic;
                }
                field("End Of Month"; Rec."End Of Month")
                {
                    ApplicationArea = Basic;
                }
                field("E-Loan Qualification (%)"; Rec."E-Loan Qualification (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Charge FOSA Registration Fee"; Rec."Charge FOSA Registration Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Charge BOSA Registration Fee"; Rec."Charge BOSA Registration Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Defaulter LN"; Rec."Defaulter LN")
                {
                    ApplicationArea = Basic;
                }
                field("Last Transaction Duration"; Rec."Last Transaction Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code No"; Rec."Branch Code No")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Contribution"; Rec."Insurance Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Allowable Cheque Discounting %"; Rec."Allowable Cheque Discounting %")
                {
                    ApplicationArea = Basic;
                }
                field("Sto max tolerance Days"; Rec."Sto max tolerance Days")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Order Maximum Tolerance Days';
                    ToolTip = 'Specify the Maximum No of  Days the Standing order should keep trying if the Member account has inserficient amount';
                }
                field("Dont Allow Sto Partial Ded."; Rec."Dont Allow Sto Partial Ded.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dont Allow Sto Partial Deduction';
                }
                field("Standing Order Bank"; Rec."Standing Order Bank")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specify the Cash book account to be credit when a member places an External standing order';
                }
                field("Share Capital Grace Period"; Rec."Share Capital Grace Period")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Share Capital Period"; Rec."Share Capital Period")
                {
                    ApplicationArea = Basic;
                }
                field("Send Remainder SMS"; Rec."Send Remainder SMS")
                {
                    ApplicationArea = Basic;
                }
                field("Ledger Fee"; Rec."Ledger Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Auto Open FOSA Savings Acc."; Rec."Auto Open FOSA Savings Acc.")
                {
                    Caption = 'Auto Open M-Wallets Accounts';
                    ApplicationArea = Basic;
                }
                field("Package Retrieval Charge"; Rec."Package Retrieval Charge") { }
                field("Package Retrieval Charge Acc"; Rec."Package Retrieval Charge Acc") { }
            }
            group("Fees & Commissions")
            {
                Caption = 'Fees & Commissions';
                field("Commission on Offset"; Rec."Commission on Offset")
                {
                    ApplicationArea = Basic;
                }
                field("Top up Account"; Rec."Top up Account")
                {
                    ApplicationArea = basic;
                }
                // field("Welfare Contribution"; Rec."Welfare Contribution")
                // {
                //     ApplicationArea = basic;
                // }
                field("Asset Valuation Cost"; Rec."Asset Valuation Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Partial Disbursement Account"; Rec."Partial Disbursement Account")
                {
                    ApplicationArea = Basic;
                }
                field("Banks Charges"; Rec."Banks Charges")
                {
                    ApplicationArea = basic;
                }
                field("Withdrawal Fee"; Rec."Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Registration Fee Amount"; Rec."FOSA Registration Fee Amount")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Registration Fee Amount"; Rec."BOSA Registration Fee Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Rejoining Fee"; Rec."Rejoining Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Boosting Shares %"; Rec."Boosting Shares %")
                {
                    ApplicationArea = Basic;
                    Caption = 'Boosting Deposits %';
                }
                /* field("Dividend Processing Fee"; Rec."Dividend Processing Fee")
                {
                    ApplicationArea = Basic;
                } */
                field("Loan Trasfer Fee-EFT"; Rec."Loan Trasfer Fee-EFT")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Trasfer Fee-Cheque"; Rec."Loan Trasfer Fee-Cheque")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Trasfer Fee-Cheque';
                }
                field("Loan Trasfer Fee-FOSA"; Rec."Loan Trasfer Fee-FOSA")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Trasfer Fee-RTGS"; Rec."Loan Trasfer Fee-RTGS")
                {
                    ApplicationArea = Basic;
                }
                field("Top up Commission"; Rec."Top up Commission")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee New"; Rec."ATM Card Fee New")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-New Coop"; Rec."ATM Card Fee-New Coop")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-New Sacco"; Rec."ATM Card Fee-New Sacco")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Renewal Fee Bank"; Rec."ATM Card Renewal Fee Bank")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Renewal Fee Sacco"; Rec."ATM Card Renewal Fee Sacco")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-Renewal"; Rec."ATM Card Fee-Renewal")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee Co-op Bank"; Rec."ATM Card Fee Co-op Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Excise Duty(%)"; Rec."Excise Duty(%)")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Fee Amount"; Rec."SMS Fee Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Beneficiary (%)"; Rec."Risk Beneficiary (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Cash Clearing Fee(%)"; Rec."Loan Cash Clearing Fee(%)")
                {
                    ApplicationArea = Basic;
                }
                field("Mpesa Withdrawal Fee"; Rec."Mpesa Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Discounting Fee %"; Rec."Cheque Discounting Fee %")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Discounting Comission"; Rec."Cheque Discounting Comission")
                {
                    ApplicationArea = Basic;
                }
                field("Funeral Expense Amount"; Rec."Funeral Expense Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital Transfer Fee"; Rec."Share Capital Transfer Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Partial Deposit Refund Fee"; Rec."Partial Deposit Refund Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Monthly Contribution"; Rec."Penalty Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Penalty on Failed Monthly Contribution';
                    ToolTip = 'Specify the Penalty Amount to Charge a Member who has not meet the minimum Monthly contribution';
                }
                field("Four Month Multiplier"; Rec."Four Month Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Top Up Commision"; Rec."Loan Top Up Commision")
                {
                    ApplicationArea = Basic;
                }
                field("GO Live Date"; Rec."GO Live Date")
                {
                    ApplicationArea = Basic;
                }
                field("Legal Fees"; Rec."Legal Fees")
                {
                    ApplicationArea = basic;
                    Caption = 'Kivukio Processing Fee';
                }
                field("Customer Care No"; Rec."Customer Care No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Fees & Commissions Accounts")
            {
                Caption = 'Fees & Commissions Accounts';
                field("Withdrawal Fee Account"; Rec."Withdrawal Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Registration Fee Account"; Rec."FOSA Registration Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Registration Fee Account"; Rec."BOSA Registration Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Rejoining Fees Account"; Rec."Rejoining Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Trasfer Fee A/C-EFT"; Rec."Loan Trasfer Fee A/C-EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Trasfer Fee Account-EFT';
                }
                field("Loan Trasfer Fee A/C-Cheque"; Rec."Loan Trasfer Fee A/C-Cheque")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Trasfer Fee Account-Cheque';
                }
                field("Loan Trasfer Fee A/C-FOSA"; Rec."Loan Trasfer Fee A/C-FOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Trasfer Fee Account-FOSA';
                }
                field("Loan Trasfer Fee A/C-RTGS"; Rec."Loan Trasfer Fee A/C-RTGS")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-Account"; Rec."ATM Card Fee-Account")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA MPESA COmm A/C"; Rec."FOSA MPESA COmm A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Retension Account"; Rec."Insurance Retension Account")
                {
                    ApplicationArea = Basic;
                }
                field("WithHolding Tax Account"; Rec."WithHolding Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Retension Account"; Rec."Shares Retension Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Transfer Fees Account"; Rec."Loan Transfer Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Boosting Fees Account"; Rec."Boosting Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bridging Commision Account"; Rec."Bridging Commision Account")
                {
                    ApplicationArea = Basic;
                }
                field("Funeral Expenses Account"; Rec."Funeral Expenses Account")
                {
                    ApplicationArea = Basic;
                }
                /* field("Dividend Payable Account"; Rec."Dividend Payable Account")
                {
                    ApplicationArea = Basic;
                } 
                field("Dividend Process Fee Account"; Rec."Dividend Process Fee Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Processing Fee Account';
                }*/
                field("Excise Duty Account"; Rec."Excise Duty Account")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Fee Account"; Rec."SMS Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Interest Account"; Rec."Checkoff Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Cash Clearing Account"; Rec."Loan Cash Clearing Account")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Fund Control Account"; Rec."Risk Fund Control Account")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill Tarrifs"; Rec."Paybill Tarrifs")
                {
                    ApplicationArea = Basic;
                }
                field("Mpesa Withdrawal Fee Account"; Rec."Mpesa Withdrawal Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Comission Received Mpesa"; Rec."Comission Received Mpesa")
                {
                    ApplicationArea = Basic;
                }
                field("Mpesa Cash Withdrawal fee ac"; Rec."Mpesa Cash Withdrawal fee ac")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Discounting Fee Account"; Rec."Cheque Discounting Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Refund On DeathAccount"; Rec."Deposit Refund On DeathAccount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Attachment Comm. Account"; Rec."Loan Attachment Comm. Account")
                {
                    ApplicationArea = Basic;
                }
                field("Ledger Fee Account"; Rec."Ledger Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital Transfer Fee Acc"; Rec."Share Capital Transfer Fee Acc")
                {
                    ApplicationArea = Basic;
                }
                field("Four Months  Interest Account"; Rec."Four Months  Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Partial Deposit Refund Fee A/C"; Rec."Partial Deposit Refund Fee A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Monthly Contr. Account"; Rec."Penalty Monthly Contr. Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Penalty On Failed Monthly Contr. Account';
                }
            }
            group("SMS Notifications")
            {
                field("Send Membership App SMS"; Rec."Send Membership App SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Membership Application SMS';
                }
                field("Send Membership Reg SMS"; Rec."Send Membership Reg SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Membership Registration SMS';
                }
                field("Send Loan App SMS"; Rec."Send Loan App SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Loan Application SMS';
                }
                field("Send Loan Disbursement SMS"; Rec."Send Loan Disbursement SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Loan Disbursement SMS';
                }
                field("Send Guarantorship SMS"; Rec."Send Guarantorship SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Guarantorship SMS';
                }
                field("Send Membership Withdrawal SMS"; Rec."Send Membership Withdrawal SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Membership Withdrawal SMS';
                }
                field("Send ATM Withdrawal SMS"; Rec."Send ATM Withdrawal SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send ATM Withdrawal SMS';
                }
                field("Send Cash Withdrawal SMS"; Rec."Send Cash Withdrawal SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Cash Withdrawal SMS';
                }
            }
            group("Email Notifications")
            {
                field("Send Membership App Email"; Rec."Send Membership App Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Membership Reg Email"; Rec."Send Membership Reg Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Loan App Email"; Rec."Send Loan App Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Loan Disbursement Email"; Rec."Send Loan Disbursement Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Guarantorship Email"; Rec."Send Guarantorship Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Membship Withdrawal Email"; Rec."Send Membship Withdrawal Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send ATM Withdrawal Email"; Rec."Send ATM Withdrawal Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Cash Withdrawal Email"; Rec."Send Cash Withdrawal Email")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Dividends Processing Setups")
            {
                field("Withholding Tax (%)"; Rec."Withholding Tax (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend (%)"; Rec."Dividend (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Dividend Proc. Period"; Rec."Min. Dividend Proc. Period")
                {
                    ApplicationArea = Basic;
                }
                field("Div Capitalization Min_Indiv"; Rec."Div Capitalization Min_Indiv")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Capitalization Minimum Deposit_Individula';
                    ToolTip = 'Less this Deposits the System will capitalize part of your dividend based on the Dividend Capitalization %';
                }
                field("Div Capitalization Min_Corp"; Rec."Div Capitalization Min_Corp")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Capitalization Minimum Deposit_Corporate Account';
                    ToolTip = 'Less this Deposits the System will capitalize part of your dividend based on the Dividend Capitalization %';
                }
                field("Div Capitalization %"; Rec."Div Capitalization %")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Capitalization %';
                }
                field("Dividend Processing Fee"; Rec."Dividend Processing Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Process Fee Account"; Rec."Dividend Process Fee Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Processing Fee Account';
                }

                field("Interest On Current Shares"; Rec."Interest On Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest On Current Shares(%)';
                }
                field("Interest on Share Capital(%)"; Rec."Interest on Share Capital(%)")
                {
                    ApplicationArea = Basic;
                }
                field("Share Interest (%)"; Rec."Share Interest (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Dividends Paying Bank Account"; Rec."Dividends Paying Bank Account")
                {
                    ApplicationArea = Basic;
                }

                field("Dividend Payable Account"; Rec."Dividend Payable Account")
                {
                    ApplicationArea = Basic;

                }
                field("HolidaySavings(%)"; Rec."HolidaySavings(%)")
                {
                    ApplicationArea = Basic;
                }
                field("HolidaySavings Payout Bank"; Rec."HolidaySavings Payout Bank") { ApplicationArea = Basic; }

            }
            group("Default Posting Groups")
            {
                field("Default Customer Posting Group"; Rec."Default Customer Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Default Micro Credit Posting G"; Rec."Default Micro Credit Posting G")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Shares Bands")
            {
                Caption = 'Shares Bands';
            }
        }
        area(processing)
        {
            action("Reset Data Sheet")
            {
                ApplicationArea = Basic;
                Caption = 'Reset Data Sheet';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Cust.Reset;
                    Cust.SetFilter("Customer Type", '%1|%2', Cust."Customer Type"::BOSA, Cust."Customer Type"::FOSA);
                    if Cust.Find('-') then
                        Cust.ModifyAll(Cust.Advice, false);


                    Loans.Reset;
                    Loans.SetRange(Loans.Source, Loans.Source::" ");
                    if Loans.Find('-') then
                        Loans.ModifyAll(Loans.Advice, false);


                    Message('Reset Completed successfully.');
                end;
            }
        }
    }

    var
        Cust: Record Customer;
        Loans: Record "Loans Register";
}

