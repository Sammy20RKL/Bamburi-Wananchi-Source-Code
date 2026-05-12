// namespace PolyTech.PolyTech;

page 57106 "Account Savings type"
{
    ApplicationArea = Basic;
    Caption = 'Account Savings type';
    PageType = List;
    SourceTable = "Account Types-Saving Products";
    UsageCategory = Lists;

    // ApplicationArea = Basic;
    Editable = true;
    // PageType = List;
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Account No Prefix"; Rec."Account No Prefix")
                {
                    ToolTip = 'Specifies the value of the Account No Prefix field.', Comment = '%';
                }
                field("Account Openning Fee"; Rec."Account Openning Fee")
                {
                    ToolTip = 'Specifies the value of the Account Openning Fee field.', Comment = '%';
                }
                field("Account Openning Fee Account"; Rec."Account Openning Fee Account")
                {
                    ToolTip = 'Specifies the value of the Account Openning Fee Account field.', Comment = '%';
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    ToolTip = 'Specifies the value of the Activity Code field.', Comment = '%';
                }
                field("Allow Loan Applications"; Rec."Allow Loan Applications")
                {
                    ToolTip = 'Specifies the value of the Allow Loan Applications field.', Comment = '%';
                }
                field("Allow Multiple Over Draft"; Rec."Allow Multiple Over Draft")
                {
                    ToolTip = 'Specifies the value of the Allow Multiple Over Draft field.', Comment = '%';
                }
                field("Allow Over Draft"; Rec."Allow Over Draft")
                {
                    ToolTip = 'Specifies the value of the Allow Over Draft field.', Comment = '%';
                }
                field("Authorised Ovedraft Charge"; Rec."Authorised Ovedraft Charge")
                {
                    ToolTip = 'Specifies the value of the Authorised Ovedraft Charge field.', Comment = '%';
                }
                field("Bankers Cheque Account"; Rec."Bankers Cheque Account")
                {
                    ToolTip = 'Specifies the value of the Bankers Cheque Account field.', Comment = '%';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.', Comment = '%';
                }
                field("Bulk Withdrawal Amount"; Rec."Bulk Withdrawal Amount")
                {
                    ToolTip = 'Specifies the value of the Bulk Withdrawal Amount field.', Comment = '%';
                }
                field("Charge Closure Before Maturity"; Rec."Charge Closure Before Maturity")
                {
                    ToolTip = 'Specifies the value of the Charge Closure Before Maturity field.', Comment = '%';
                }
                field("Check Off Recovery"; Rec."Check Off Recovery")
                {
                    ToolTip = 'Specifies the value of the Check Off Recovery field.', Comment = '%';
                }
                field("Closing Charge"; Rec."Closing Charge")
                {
                    ToolTip = 'Specifies the value of the Closing Charge field.', Comment = '%';
                }
                field("Closing Prior Notice Charge"; Rec."Closing Prior Notice Charge")
                {
                    ToolTip = 'Specifies the value of the Closing Prior Notice Charge field.', Comment = '%';
                }
                field("Closure Fee"; Rec."Closure Fee")
                {
                    ToolTip = 'Specifies the value of the Closure Fee field.', Comment = '%';
                }
                field("Closure Notice Period"; Rec."Closure Notice Period")
                {
                    ToolTip = 'Specifies the value of the Closure Notice Period field.', Comment = '%';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.', Comment = '%';
                }
                field("Default Account"; Rec."Default Account")
                {
                    ToolTip = 'Specifies the value of the Default Account field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Dormancy Period (M)"; Rec."Dormancy Period (M)")
                {
                    ToolTip = 'Specifies the value of the Dormancy Period (M) field.', Comment = '%';
                }
                field("EFT Bank Account"; Rec."EFT Bank Account")
                {
                    ToolTip = 'Specifies the value of the EFT Bank Account field.', Comment = '%';
                }
                field("EFT Bin No"; Rec."EFT Bin No")
                {
                    ToolTip = 'Specifies the value of the EFT Bin No field.', Comment = '%';
                }
                field("EFT Charges Account"; Rec."EFT Charges Account")
                {
                    ToolTip = 'Specifies the value of the EFT Charges Account field.', Comment = '%';
                }
                field("Earns Interest"; Rec."Earns Interest")
                {
                    ToolTip = 'Specifies the value of the Earns Interest field.', Comment = '%';
                }
                field("Ending Series"; Rec."Ending Series")
                {
                    ToolTip = 'Specifies the value of the Ending Series field.', Comment = '%';
                }
                field("Entered By"; Rec."Entered By")
                {
                    ToolTip = 'Specifies the value of the Entered By field.', Comment = '%';
                }
                field("External EFT Charges"; Rec."External EFT Charges")
                {
                    ToolTip = 'Specifies the value of the External EFT Charges field.', Comment = '%';
                }
                field("FOSA Shares"; Rec."FOSA Shares")
                {
                    ToolTip = 'Specifies the value of the FOSA Shares field.', Comment = '%';
                }
                field("Fee Below Minimum Balance"; Rec."Fee Below Minimum Balance")
                {
                    ToolTip = 'Specifies the value of the Fee Below Minimum Balance field.', Comment = '%';
                }
                field("Fee bellow Min. Bal. Account"; Rec."Fee bellow Min. Bal. Account")
                {
                    ToolTip = 'Specifies the value of the Fee bellow Min. Bal. Account field.', Comment = '%';
                }
                field("Fixed Deposit"; Rec."Fixed Deposit")
                {
                    ToolTip = 'Specifies the value of the Fixed Deposit field.', Comment = '%';
                }
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    ToolTip = 'Specifies the value of the Fixed Deposit Type field.', Comment = '%';
                }
                field("Interest Calc Min Balance"; Rec."Interest Calc Min Balance")
                {
                    ToolTip = 'Specifies the value of the Interest Calc Min Balance field.', Comment = '%';
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Interest Calculation Method field.', Comment = '%';
                }
                field("Interest Expense Account"; Rec."Interest Expense Account")
                {
                    ToolTip = 'Specifies the value of the Interest Expense Account field.', Comment = '%';
                }
                field("Interest Forfeited Account"; Rec."Interest Forfeited Account")
                {
                    ToolTip = 'Specifies the value of the Interest Forfeited Account field.', Comment = '%';
                }
                field("Interest Payable Account"; Rec."Interest Payable Account")
                {
                    ToolTip = 'Specifies the value of the Interest Payable Account field.', Comment = '%';
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ToolTip = 'Specifies the value of the Interest Rate field.', Comment = '%';
                }
                field("Interest Tax Account"; Rec."Interest Tax Account")
                {
                    ToolTip = 'Specifies the value of the Interest Tax Account field.', Comment = '%';
                }
                field("Internal EFT Charges"; Rec."Internal EFT Charges")
                {
                    ToolTip = 'Specifies the value of the Internal EFT Charges field.', Comment = '%';
                }
                field("Last Account No Used(ELD)"; Rec."Last Account No Used(ELD)")
                {
                    ToolTip = 'Specifies the value of the Last Account No Used(ELD) field.', Comment = '%';
                }
                field("Last Account No Used(HQ)"; Rec."Last Account No Used(HQ)")
                {
                    ToolTip = 'Specifies the value of the Last Account No Used(HQ) field.', Comment = '%';
                }
                field("Last Account No Used(MSA)"; Rec."Last Account No Used(MSA)")
                {
                    ToolTip = 'Specifies the value of the Last Account No Used(MSA) field.', Comment = '%';
                }
                field("Last Account No Used(NAIV)"; Rec."Last Account No Used(NAIV)")
                {
                    ToolTip = 'Specifies the value of the Last Account No Used(NAIV) field.', Comment = '%';
                }
                field("Last Account No Used(NKR)"; Rec."Last Account No Used(NKR)")
                {
                    ToolTip = 'Specifies the value of the Last Account No Used(NKR) field.', Comment = '%';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.', Comment = '%';
                }
                field("Last No Used"; Rec."Last No Used")
                {
                    ToolTip = 'Specifies the value of the Last No Used field.', Comment = '%';
                }
                field("Loan Application Fee"; Rec."Loan Application Fee")
                {
                    ToolTip = 'Specifies the value of the Loan Application Fee field.', Comment = '%';
                }
                field("Maintenence Duration"; Rec."Maintenence Duration")
                {
                    ToolTip = 'Specifies the value of the Maintenence Duration field.', Comment = '%';
                }
                field("Maintenence Fee"; Rec."Maintenence Fee")
                {
                    ToolTip = 'Specifies the value of the Maintenence Fee field.', Comment = '%';
                }
                field("Max Period For Acc Topup (M)"; Rec."Max Period For Acc Topup (M)")
                {
                    ToolTip = 'Specifies the value of the Max Period For Acc Topup (M) field.', Comment = '%';
                }
                field("Maximum Allowable Deposit"; Rec."Maximum Allowable Deposit")
                {
                    ToolTip = 'Specifies the value of the Maximum Allowable Deposit field.', Comment = '%';
                }
                field("Maximum No Of Accounts"; Rec."Maximum No Of Accounts")
                {
                    ToolTip = 'Specify the maximum no of accounts a member can have for this product';
                }
                field("Maximum Withdrawal Amount"; Rec."Maximum Withdrawal Amount")
                {
                    ToolTip = 'Specifies the value of the Maximum Withdrawal Amount field.', Comment = '%';
                }
                field("Min Bal. Calc Frequency"; Rec."Min Bal. Calc Frequency")
                {
                    ToolTip = 'Specifies the value of the Min Bal. Calc Frequency field.', Comment = '%';
                }
                field("Minimum Balance"; Rec."Minimum Balance")
                {
                    ToolTip = 'Specifies the value of the Minimum Balance field.', Comment = '%';
                }
                field("Minimum Interest Period (M)"; Rec."Minimum Interest Period (M)")
                {
                    ToolTip = 'Specifies the value of the Minimum Interest Period (M) field.', Comment = '%';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ToolTip = 'Specifies the value of the Modified By field.', Comment = '%';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field("Non Staff Loan Security(%)"; Rec."Non Staff Loan Security(%)")
                {
                    ToolTip = 'Specifies the value of the Non Staff Loan Security(%) field.', Comment = '%';
                }
                field("Other Financial Income Account"; Rec."Other Financial Income Account")
                {
                    ToolTip = 'Specifies the value of the Other Financial Income Account field.', Comment = '%';
                }
                field("Over Draft Interest %"; Rec."Over Draft Interest %")
                {
                    ToolTip = 'Specifies the value of the Over Draft Interest % field.', Comment = '%';
                }
                field("Over Draft Interest Account"; Rec."Over Draft Interest Account")
                {
                    ToolTip = 'Specifies the value of the Over Draft Interest Account field.', Comment = '%';
                }
                field("Over Draft Issue Charge %"; Rec."Over Draft Issue Charge %")
                {
                    ToolTip = 'Specifies the value of the Over Draft Issue Charge % field.', Comment = '%';
                }
                field("Over Draft Issue Charge A/C"; Rec."Over Draft Issue Charge A/C")
                {
                    ToolTip = 'Specifies the value of the Over Draft Issue Charge A/C field.', Comment = '%';
                }
                field("Overdraft Charge"; Rec."Overdraft Charge")
                {
                    ToolTip = 'Specifies the value of the Overdraft Charge field.', Comment = '%';
                }
                field("Pass Book Fee"; Rec."Pass Book Fee")
                {
                    ToolTip = 'Specifies the value of the Pass Book Fee field.', Comment = '%';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ToolTip = 'Specifies the value of the Vendor Posting Group field.', Comment = '%';
                }
                field("Product Code"; Rec."Product Code")
                {
                    ToolTip = 'Specifies the value of the Product Code field.', Comment = '%';
                }
                field("RTGS Charges"; Rec."RTGS Charges")
                {
                    ToolTip = 'Specifies the value of the RTGS Charges field.', Comment = '%';
                }
                field("RTGS Charges Account"; Rec."RTGS Charges Account")
                {
                    ToolTip = 'Specifies the value of the RTGS Charges Account field.', Comment = '%';
                }
                field("Re-activation Fee"; Rec."Re-activation Fee")
                {
                    ToolTip = 'Specifies the value of the Re-activation Fee field.', Comment = '%';
                }
                field("Re-activation Fee Account"; Rec."Re-activation Fee Account")
                {
                    ToolTip = 'Specifies the value of the Re-activation Fee Account field.', Comment = '%';
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    ToolTip = 'Specifies the value of the Recovery Priority field.', Comment = '%';
                }
                field("Reject App. Pending Period"; Rec."Reject App. Pending Period")
                {
                    ToolTip = 'Specifies the value of the Reject App. Pending Period field.', Comment = '%';
                }
                field("Requires Closure Notice"; Rec."Requires Closure Notice")
                {
                    ToolTip = 'Specifies the value of the Requires Closure Notice field.', Comment = '%';
                }
                field("Requires Opening Deposit"; Rec."Requires Opening Deposit")
                {
                    ToolTip = 'Specifies the value of the Requires Opening Deposit field.', Comment = '%';
                }
                field("SMS Description"; Rec."SMS Description")
                {
                    ToolTip = 'Specifies the value of the SMS Description field.', Comment = '%';
                }
                field("Salary Processing Fee"; Rec."Salary Processing Fee")
                {
                    ToolTip = 'Specifies the value of the Salary Processing Fee field.', Comment = '%';
                }
                field("Savings Duration"; Rec."Savings Duration")
                {
                    ToolTip = 'Specifies the value of the Savings Duration field.', Comment = '%';
                }
                field("Savings Penalty Account"; Rec."Savings Penalty Account")
                {
                    ToolTip = 'Specifies the value of the Savings Penalty Account field.', Comment = '%';
                }
                field("Savings Withdrawal penalty"; Rec."Savings Withdrawal penalty")
                {
                    ToolTip = 'Specifies the value of the Savings Withdrawal penalty field.', Comment = '%';
                }
                field("Search Fee"; Rec."Search Fee")
                {
                    ToolTip = 'Specifies the value of the Search Fee field.', Comment = '%';
                }
                field("Service Charge"; Rec."Service Charge")
                {
                    ToolTip = 'Specifies the value of the Service Charge field.', Comment = '%';
                }
                field("Show On List"; Rec."Show On List")
                {
                    ToolTip = 'Specifies the value of the Show On List field.', Comment = '%';
                }
                field("Staff Loan Security(%)"; Rec."Staff Loan Security(%)")
                {
                    ToolTip = 'Specifies the value of the Staff Loan Security(%) field.', Comment = '%';
                }
                field("Standing Orders Suspense"; Rec."Standing Orders Suspense")
                {
                    ToolTip = 'Specifies the value of the Standing Orders Suspense field.', Comment = '%';
                }
                field("Statement Charge"; Rec."Statement Charge")
                {
                    ToolTip = 'Specifies the value of the Statement Charge field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field("Tax On Interest"; Rec."Tax On Interest")
                {
                    ToolTip = 'Specifies the value of the Tax On Interest field.', Comment = '%';
                }
                field("Term Termination Account"; Rec."Term Termination Account")
                {
                    ToolTip = 'Specifies the value of the Term Termination Account field.', Comment = '%';
                }
                field("Term terminatination fee"; Rec."Term terminatination fee")
                {
                    ToolTip = 'Specifies the value of the Term terminatination fee field.', Comment = '%';
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ToolTip = 'Specifies the value of the Time Entered field.', Comment = '%';
                }
                field("Transfer Fee"; Rec."Transfer Fee")
                {
                    ToolTip = 'Specifies the value of the Transfer Fee field.', Comment = '%';
                }
                field("Use Graduated Charges"; Rec."Use Graduated Charges")
                {
                    ToolTip = 'Specifies the value of the Use Graduated Charges field.', Comment = '%';
                }
                field("Use Savings Account Number"; Rec."Use Savings Account Number")
                {
                    ToolTip = 'Specifies the value of the Use Savings Account Number field.', Comment = '%';
                }
                field("Withdrawal Interval"; Rec."Withdrawal Interval")
                {
                    ToolTip = 'Specifies the value of the Withdrawal Interval field.', Comment = '%';
                }
                field("Withdrawal Interval Account"; Rec."Withdrawal Interval Account")
                {
                    ToolTip = 'Specifies the value of the Withdrawal Interval Account field.', Comment = '%';
                }
                field("Withdrawal Penalty"; Rec."Withdrawal Penalty")
                {
                    ToolTip = 'Specifies the value of the Withdrawal Penalty field.', Comment = '%';
                }
            }
        }
    }
}
