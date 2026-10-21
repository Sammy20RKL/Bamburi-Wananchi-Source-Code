page 70759 "API Member Transactions"
{
    PageType = API;
    APIPublisher = 'swizzsoft';
    APIGroup = 'bamburi';
    APIVersion = 'v1.0';
    EntityName = 'memberTransaction';
    EntitySetName = 'memberTransactions';
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = where("Transaction Type" = filter("Deposit Contribution" | "Loan Repayment"));
    DelayedInsert = true;
    ODataKeyFields = "Entry No.";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.") { }
                field(customerNo; Rec."Customer No.") { }
                field(postingDate; Rec."Posting Date") { }
                field(transactionType; Rec."Transaction Type") { }
                field(amount; Rec.Amount) { }
                field(documentNo; Rec."Document No.") { }
                field(description; Rec.Description) { }
            }
        }
    }
}
