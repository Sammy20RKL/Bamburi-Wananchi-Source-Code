#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50006 "Import Sacco Jnl"
{
    Format = VariableText;


    schema
    {
        textelement(root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(A; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(B; "Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(K; "Gen. Journal Line"."Line No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(E; "Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(FB; "Gen. Journal Line"."Account No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(C; "Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(D; "Gen. Journal Line"."Document No.")
                {
                }

                fieldelement(G; "Gen. Journal Line".Description)
                {
                }
                fieldelement(GA; "Gen. Journal Line"."Bal. Account Type")
                {
                }
                fieldelement(GB; "Gen. Journal Line"."Bal. Account No.")
                {
                }
                fieldelement(JK; "Gen. Journal Line"."Transaction Type")
                {
                }
                fieldelement(JL; "Gen. Journal Line"."Loan No")
                {
                }
                fieldelement(I; "Gen. Journal Line"."Shortcut Dimension 1 Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(J; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(HA; "Gen. Journal Line".Amount)
                {
                }
                fieldelement(HB; "Gen. Journal Line"."Debit Amount")
                {
                }
                fieldelement(HC; "Gen. Journal Line"."Credit Amount")
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

