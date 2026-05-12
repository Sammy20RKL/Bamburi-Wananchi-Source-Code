Report 50877 "Ledger enries audit Trail"
{
    ApplicationArea = All;
    Caption = 'Ledger enries audit Trail';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Ledgerentries.rdl';
    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            RequestFilterFields = "User ID";
            DataItemTableView = sorting("Entry No.");
            column(EntryNo; "Entry No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Description; Description)
            {
            }
            column(GLAccountNo; "G/L Account No.")
            {
            }
            column(GLAccountName; "G/L Account Name")
            {
            }
            column(Amount; Amount)
            {
            }
            column(UserID; "User ID")
            {
            }
            column(LastModifiedDateTime; "Last Modified DateTime")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
