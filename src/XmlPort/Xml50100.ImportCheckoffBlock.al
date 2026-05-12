#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50100 "Import Checkoff Block"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("ReceiptsProcessing_L-Checkoff"; "ReceiptsProcessing_L-Checkoff")
            {
                XmlName = 'checkoff';
                fieldelement(Transaction_No; "ReceiptsProcessing_L-Checkoff"."Receipt Line No")
                {
                }
                fieldelement(No; "ReceiptsProcessing_L-Checkoff"."Receipt Header No")
                {
                }
                fieldelement(Mobile_No; "ReceiptsProcessing_L-Checkoff"."Staff/Payroll No")
                {
                }
                fieldelement(Amount; "ReceiptsProcessing_L-Checkoff".Amount)
                {
                }
                fieldelement(Header_No; "ReceiptsProcessing_L-Checkoff"."Employer Code")
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

