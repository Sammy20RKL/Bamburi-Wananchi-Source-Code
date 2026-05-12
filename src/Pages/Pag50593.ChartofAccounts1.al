#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50593 "Chart of Accounts 1"
{
    PageType = List;
    SourceTable = "G/L Account";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                }
                field("Income/Balance"; Rec."Income/Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Debit/Credit"; Rec."Debit/Credit")
                {
                    ApplicationArea = Basic;
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Direct Posting"; Rec."Direct Posting")
                {
                    ApplicationArea = Basic;
                }
                field("Reconciliation Account"; Rec."Reconciliation Account")
                {
                    ApplicationArea = Basic;
                }
                field("New Page"; Rec."New Page")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Blank Lines"; Rec."No. of Blank Lines")
                {
                    ApplicationArea = Basic;
                }
                field(Indentation; Rec.Indentation)
                {
                    ApplicationArea = Basic;
                }
                field("Last Modified Date Time"; Rec."Last Modified Date Time")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Filter"; Rec."Global Dimension 1 Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Filter"; Rec."Global Dimension 2 Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Balance at Date"; Rec."Balance at Date")
                {
                    ApplicationArea = Basic;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = Basic;
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Totaling; Rec.Totaling)
                {
                    ApplicationArea = Basic;
                }
                field("Budget Filter"; Rec."Budget Filter")
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Budget at Date"; Rec."Budget at Date")
                {
                    ApplicationArea = Basic;
                }
                field("Consol. Translation Method"; Rec."Consol. Translation Method")
                {
                    ApplicationArea = Basic;
                }
                field("Consol. Debit Acc."; Rec."Consol. Debit Acc.")
                {
                    ApplicationArea = Basic;
                }
                field("Consol. Credit Acc."; Rec."Consol. Credit Acc.")
                {
                    ApplicationArea = Basic;
                }
                field("Business Unit Filter"; Rec."Business Unit Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    ApplicationArea = Basic;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Automatic Ext. Texts"; Rec."Automatic Ext. Texts")
                {
                    ApplicationArea = Basic;
                }
                field("Budgeted Debit Amount"; Rec."Budgeted Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Budgeted Credit Amount"; Rec."Budgeted Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Additional-Currency Net Change"; Rec."Additional-Currency Net Change")
                {
                    ApplicationArea = Basic;
                }
                field("Add.-Currency Balance at Date"; Rec."Add.-Currency Balance at Date")
                {
                    ApplicationArea = Basic;
                }
                field("Additional-Currency Balance"; Rec."Additional-Currency Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Exchange Rate Adjustment"; Rec."Exchange Rate Adjustment")
                {
                    ApplicationArea = Basic;
                }
                field("Add.-Currency Debit Amount"; Rec."Add.-Currency Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Add.-Currency Credit Amount"; Rec."Add.-Currency Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Default IC Partner G/L Acc. No"; Rec."Default IC Partner G/L Acc. No")
                {
                    ApplicationArea = Basic;
                }
                field("Omit Default Descr. in Jnl."; Rec."Omit Default Descr. in Jnl.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Subcategory Entry No."; Rec."Account Subcategory Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Subcategory Descript."; Rec."Account Subcategory Descript.")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension Set ID Filter"; Rec."Dimension Set ID Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Cost Type No."; Rec."Cost Type No.")
                {
                    ApplicationArea = Basic;
                }
                field("Default Deferral Template Code"; Rec."Default Deferral Template Code")
                {
                    ApplicationArea = Basic;
                }
                field(Id; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Controlled"; Rec."Budget Controlled")
                {
                    ApplicationArea = Basic;
                }
                field("Expense Code"; Rec."Expense Code")
                {
                    ApplicationArea = Basic;
                }
                field("Donor defined Account"; Rec."Donor defined Account")
                {
                    ApplicationArea = Basic;
                }
                // field(test; Rec.test)
                // {
                //     ApplicationArea = Basic;
                // }
                field("Grant Expense"; Rec."Grant Expense")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Old No."; Rec."Old No.")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

