XmlPort 50003 "Import Loans"
{
    Caption = 'Import Loans';
    Format = VariableText;
    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Loan Imported"; "Loans Register")
            {
                XmlName = 'LoanImport';
                fieldelement(LoanNo; "Loan Imported"."Loan  No.")
                {
                }
                fieldelement(ApplicationDate; "Loan Imported"."Application Date")
                {
                }
                fieldelement(ClientNo; "Loan Imported"."Client Code")
                {
                }
                fieldelement(LoanProductType; "Loan Imported"."Loan Product Type")
                {
                }
                fieldelement(RequestedAmount; "Loan Imported"."Requested Amount")
                {
                }
                fieldelement(ApprovedAmount; "Loan Imported"."Approved Amount")
                {
                }
                fieldelement(ClientName; "Loan Imported"."Client Name")
                {
                }
                fieldelement(LoanStatus; "Loan Imported"."Loan Status")
                {
                }
                fieldelement(IssuedDate; "Loan Imported"."Issued Date")
                {
                }
                fieldelement(Posted; "Loan Imported".Posted)
                {
                }
                fieldelement(RepayemntStartDate; "Loan Imported"."Repayment Start Date")
                {
                }
                fieldelement(Source; "Loan Imported".Source)
                {
                }
                fieldelement(ExpectedDate; "Loan Imported"."Expected Date of Completion")
                {
                }
                fieldelement(ApprovedStatus; "Loan Imported"."Approval Status")
                {
                }



            }
        }
    }
}
