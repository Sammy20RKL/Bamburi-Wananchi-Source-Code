page 70757 "API Loan Register"
{
    PageType = API;
    APIPublisher = 'swizzsoft';
    APIGroup = 'bamburi';
    APIVersion = 'v1.0';
    EntityName = 'loan';
    EntitySetName = 'loans';
    SourceTable = "Loans Register";
    DelayedInsert = true;
    ODataKeyFields = "Loan  No.";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(loanNo; Rec."Loan  No.") { }
                field(clientCode; Rec."Client Code") { }
                field(clientName; Rec."Client Name") { }
                field(productType; Rec."Loan Product Type") { }
                field(productTypeName; Rec."Loan Product Type Name") { }
                field(loanStatus; Rec."Loan Status") { }
                field(requestedAmount; Rec."Requested Amount") { }
                field(approvedAmount; Rec."Approved Amount") { }
                field(outstandingBalance; Rec."Outstanding Balance") { }
                field(outstandingInterest; Rec."Oustanding Interest") { }
                field(daysInArrears; Rec."Days In Arrears") { }
                field(issuedDate; Rec."Issued Date") { }
                field(disbursementDate; Rec."Loan Disbursement Date") { }
                field(posted; Rec.Posted) { }
            }
        }
    }
}
