#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50101 "Import Paybill Transactions"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                XmlName = 'Paybill';
                fieldelement(No; "Cust. Ledger Entry"."Entry No.")
                {
                }
                fieldelement(Mobile_No; "Cust. Ledger Entry"."Document No.")
                {
                }
                fieldelement(Amount; "Cust. Ledger Entry".Amount)
                {
                }
                fieldelement(Header_No; "Cust. Ledger Entry"."Transaction Type")
                {
                }
                fieldelement(Transaction_No; "Cust. Ledger Entry"."Posting Date")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

