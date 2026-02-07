// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// page 50410 "Sacco General Set-Up2"
// {
//     ApplicationArea = Basic;
//     PageType = Card;
//     SourceTable = "Sacco General Set-Up";
//     UsageCategory = Administration;
//     InsertAllowed = false;
//     DeleteAllowed = false;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("Max. Non Contribution Periods"; Rec."Max. Non Contribution Periods")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Min. Contribution"; Rec."Min. Contribution")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Min. Member Age"; Rec."Min. Member Age")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Retirement Age"; Rec."Retirement Age")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Retained Shares"; Rec."Retained Shares")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Minimum Share Capital';
//                 }
//                 field("Maximum No of Loans Guaranteed"; Rec."Maximum No of Loans Guaranteed")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Min. Guarantors"; Rec."Min. Guarantors")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Max. Guarantors"; Rec."Max. Guarantors")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Min. Loan Application Period"; Rec."Min. Loan Application Period")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Boosting Fees Account"; Rec."Boosting Fees Account")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Dividend (%)"; Rec."Dividend (%)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Interest on Deposits (%)"; Rec."Interest on Deposits (%)")
//                 {
//                     ApplicationArea = Basic;
//                 }

//                 field("Min. Dividend Proc. Period"; Rec."Min. Dividend Proc. Period")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Member Can Guarantee Own Loan"; Rec."Member Can Guarantee Own Loan")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Withdrawal Period"; Rec."Withdrawal Period")
//                 {
//                     ApplicationArea = Basic;

//                 }

//                 field("Use Bands"; Rec."Use Bands")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Maximum No of Guarantees"; Rec."Maximum No of Guarantees")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Top up Account"; Rec."Top up Account")
//                 {
//                     ApplicationArea = basic;
//                 }
//                 field("Max. Contactual Shares"; Rec."Max. Contactual Shares")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Commision (%)"; Rec."Commision (%)")
//                 {
//                     ApplicationArea = Basic;
//                 }

//                 field("Withdrawal Fee"; Rec."Withdrawal Fee")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Withdrawal Commision"; Rec."Withdrawal Commision")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Account Closure Fee(With Notice)';
//                 }
//                 // field("Speed Charge"; "Speed Charge")
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Caption = 'Account Closure Fee(Without Notice)';
//                 // }
//                 // field("Speed Charge (%)"; "Speed Charge (%)")
//                 // {
//                 //     ApplicationArea = Basic;
//                 // }
//                 field("Asset Valuation Cost"; Rec."Asset Valuation Cost")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Legal Fees"; Rec."Legal Fees")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Banks Charges"; Rec."Banks Charges")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Bank charges Account';
//                 }
//                 field("Withdrawal Fee Account"; Rec."Withdrawal Fee Account")
//                 {
//                     ApplicationArea = Basic;
//                 }


//                 field("Registration Fee"; Rec."Registration Fee")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Membership Fee';
//                 }
//                 field("Rejoining Fee"; Rec."Rejoining Fee")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Welfare Contribution"; Rec."Welfare Contribution")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Insurance Contribution';
//                 }

//                 field("Boosting Shares %"; Rec."Boosting Shares %")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Excise Duty(%)"; Rec."Excise Duty(%)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Boosting Shares Maturity (M)"; Rec."Boosting Shares Maturity (M)")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Approved Loans Letter"; Rec."Approved Loans Letter")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("ATM Expiry Duration"; Rec."ATM Expiry Duration")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Rejected Loans Letter"; Rec."Rejected Loans Letter")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Monthly Share Contributions"; Rec."Monthly Share Contributions")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Auto Open FOSA Savings Acc."; Rec."Auto Open FOSA Savings Acc.")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Auto Open Agile Savings Acc.';
//                     Visible = false;
//                 }
//                 field("FOSA Account Type"; Rec."FOSA Account Type")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Customer Care No"; Rec."Customer Care No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Send SMS Notifications"; Rec."Send SMS Notifications")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Send Email Notifications"; Rec."Send Email Notifications")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Auto Fill Msacco Application"; Rec."Auto Fill Msacco Application")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Auto Fill S-Pesa Application';
//                     Visible = false;
//                 }
//                 field("Auto Fill ATM Application"; Rec."Auto Fill ATM Application")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Form Fee"; Rec."Form Fee")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Passcard Fee"; Rec."Passcard Fee")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 // field("share Capital"; "share Capital")
//                 // {
//                 //     ApplicationArea = Basic;

//                 // }
//                 field("Form Fee Account"; Rec."Form Fee Account")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Membership Form Acct"; Rec."Membership Form Acct")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'PassCard Acct';
//                     Visible = false;
//                 }
//                 field("Ceep Reg Fee"; Rec."Ceep Reg Fee")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Ceep Reg Acct"; Rec."Ceep Reg Acct")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Withholding Tax Account"; Rec."Withholding Tax Account")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("GO Live Date"; Rec."GO Live Date") { ApplicationArea = Basic; }
//             }
//             group(Numbering)
//             {
//                 Caption = 'Numbering';
//                 Visible = false;
//                 field("Overdraft App Nos."; Rec."Overdraft App Nos.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Overdraft Limit"; Rec."Overdraft Limit")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group(Micro)
//             {
//                 Visible = false;
//                 Caption = 'Micro';
//                 field("Group Account No"; Rec."Group Account No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Business Loans A/c Format"; Rec."Business Loans A/c Format")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'MICRO Loans A/C Format';
//                 }
//                 field("Min. Contribution Bus Loan"; Rec."Min. Contribution Bus Loan")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Min. Contribution CEEP';
//                 }
//             }
//             group("Mail Setup")
//             {
//                 Caption = 'Mail Setup';
//                 Visible = false;
//                 field("Incoming Mail Server"; Rec."Incoming Mail Server")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Outgoing Mail Server"; Rec."Outgoing Mail Server")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Email Text"; Rec."Email Text")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Sender User ID"; Rec."Sender User ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Sender Address"; Rec."Sender Address")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Email Subject"; Rec."Email Subject")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Statement Message #1"; Rec."Statement Message #1")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Statement Message #2"; Rec."Statement Message #2")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Statement Message #3"; Rec."Statement Message #3")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Statement Message #4"; Rec."Statement Message #4")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group(Others)
//             {
//                 Caption = 'Others';
//                 field("Insurance Retension Account"; Rec."Insurance Retension Account")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;

//                 }
//                 field("Shares Retension Account"; Rec."Shares Retension Account")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Loan Transfer Fees Account"; Rec."Loan Transfer Fees Account")
//                 {
//                     ApplicationArea = Basic;
//                 }

//                 field("Bridging Commision Account"; Rec."Bridging Commision Account")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 // field("Funeral Expenses Amount"; Rec."Funeral Expenses Amount")
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Visible = false;
//                 // }
//                 field("Funeral Expenses Account"; Rec."Funeral Expenses Account")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Excise Duty Account"; Rec."Excise Duty Account")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Cheque Processing Fee"; Rec."Cheque Processing Fee")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Cheque Processing Fee Account"; Rec."Cheque Processing Fee Account")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//             }
//             group("Dividends Processing Setups")
//             {
//                 field("Withholding Tax (%)"; Rec."Withholding Tax (%)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Interest On Current Shares"; Rec."Interest On Current Shares")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Interest On Current Shares(%)';
//                 }
//                 field("Interest on Share Capital(%)"; Rec."Interest on Share Capital(%)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Dividends Paying Bank Account"; Rec."Dividends Paying Bank Account")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 // field("Interest On FOSA Shares"; Rec."Interest On FOSA Shares")
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Caption = 'Interest On FOSA Shares(%)';
//                 //     Visible = false;
//                 // }
//                 field("Dividend Payable Account"; Rec."Dividend Payable Account")
//                 {
//                     ApplicationArea = Basic;

//                 }
//                 field("Interest On Preferential Shares"; Rec."Interest On PreferentialShares")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Interest On Preferential Shares(%)';
//                     Visible = false;
//                 }
//                 field("Interest On Lift Shares"; Rec."Interest On LiftShares")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Interest On Lift Shares(%)';
//                     Visible = false;
//                 }
//                 field("Interest On PreferentialShares"; Rec."Interest On PreferentialShares")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Interest On Preferential Shares(%)';
//                     Visible = false;
//                 }
//                 field("Interest On TambaaShares"; Rec."Interest On TambaaShares")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Interest On Tambaa Shares(%)';
//                     Visible = false;
//                 }
//                 field("Interest On PepeaShares"; Rec."Interest On PepeaShares")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Interest On Pepea Shares(%)';
//                     Visible = false;
//                 }
//                 field("Interest On HousingShares"; Rec."Interest On HousingShares")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Interest On Housing Shares(%)';
//                     Visible = false;
//                 }
//                 field("Dividends Capitalization Rate"; Rec."Dividends Capitalization Rate")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Dividends Capitalization Rate(%)';
//                     Visible = false;
//                 }
//                 field("Proposed Honoraria"; Rec."Proposed Honoraria")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(ATM)
//             {
//                 visible = false;
//                 field("ATM Card Fee-New Coop"; Rec."ATM Card Fee-New Coop")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ATM Card Fee-New Sacco"; Rec."ATM Card Fee-New Sacco")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ATM Card Fee-Replacement"; Rec."ATM Card Fee-Replacement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ATM Card Fee-Renewal"; Rec."ATM Card Fee-Renewal")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ATM Card Fee-Account"; Rec."ATM Card Fee-Account")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ATM Card Fee Co-op Bank"; Rec."ATM Card Fee Co-op Bank")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("ATM Card Co-op Bank Amount"; Rec."ATM Card Co-op Bank Amount")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Shares Bands")
//             {
//                 Visible = false;
//                 Caption = 'Shares Bands';
//             }
//         }
//         area(processing)
//         {
//             action("Reset Data Sheet")
//             {
//                 Visible = false;
//                 ApplicationArea = Basic;
//                 Caption = 'Reset Data Sheet';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin

//                 end;
//             }
//         }
//     }

//     var
//         Cust: Record Customer;
//         Loans: Record "Loans Register";


//     trigger OnInit()
//     begin
//         if Rec.IsEmpty() then
//             Rec.Insert();
//     end;
// }

