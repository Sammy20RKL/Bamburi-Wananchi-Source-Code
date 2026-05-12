#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50005 MpesaTransImport
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("SwizzKash Paybill Buffer"; "SwizzKash Paybill Buffer")
            {
                AutoUpdate = true;
                XmlName = 'SwizzKashTRansactions';
                fieldelement(A; "SwizzKash Paybill Buffer"."Receipt No.")
                {
                }
                fieldelement(B; "SwizzKash Paybill Buffer"."Completion Time")
                {
                }
                fieldelement(C; "SwizzKash Paybill Buffer"."Initiation Time")
                {
                }
                fieldelement(D; "SwizzKash Paybill Buffer".Details)
                {
                }
                fieldelement(E; "SwizzKash Paybill Buffer"."Transaction Status")
                {
                }
                fieldelement(F; "SwizzKash Paybill Buffer"."Paid In")
                {
                }
                fieldelement(G; "SwizzKash Paybill Buffer".Withdrawn)
                {
                }
                fieldelement(H; "SwizzKash Paybill Buffer".Balance)
                {
                }
                fieldelement(I; "SwizzKash Paybill Buffer"."Balance Confirmed")
                {
                }
                fieldelement(J; "SwizzKash Paybill Buffer"."Reason Type")
                {
                }
                fieldelement(K; "SwizzKash Paybill Buffer"."Other Party Info")
                {
                }
                fieldelement(L; "SwizzKash Paybill Buffer"."Linked Transaction ID")
                {
                }
                fieldelement(M; "SwizzKash Paybill Buffer"."A/C No.")
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

