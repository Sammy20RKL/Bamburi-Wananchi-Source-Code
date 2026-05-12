#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50012 "Export EFT"
{
    Format = VariableText;

    schema
    {
        textelement(Loansrrr)
        {
            tableelement("Loans Register"; "Loans Register")
            {
                XmlName = 'Loan';
                fieldattribute(No; "Loans Register"."Client Code")
                {
                }
                fieldattribute(Name; "Loans Register"."Client Name")
                {
                }
                fieldattribute(BNo; "Loans Register"."Bank No")
                {
                }
                fieldattribute(AppAmount; "Loans Register"."Loan Disbursed Amount")
                {
                }
                fieldelement(Branch; "Loans Register"."Bank Branch")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    if cust.Get("Loans Register"."Client Code") then begin
                        //"Loans Register"."Bank code" := cust."Bank Code";
                        "Loans Register"."Bank No" := cust."Bank Account No.";
                        "Loans Register"."Bank Branch" := cust."Bank Branch Code";
                        "Loans Register".Modify;
                    end;
                end;

                trigger OnBeforeInsertRecord()
                var
                    OrgICGLAcc: Record "IC G/L Account";
                begin





                    /*
                    XMLInbound := TRUE;
                    
                    IF TempICGLAcc.GET(ICGLAcc."No.") THEN BEGIN
                      IF (ICGLAcc.Name <> TempICGLAcc.Name) OR (ICGLAcc."Account Type" <> TempICGLAcc."Account Type") OR
                         (ICGLAcc."Income/Balance" <> TempICGLAcc."Income/Balance") OR (ICGLAcc.Blocked <> TempICGLAcc.Blocked)
                      THEN
                        Modified := Modified + 1;
                      ICGLAcc."Map-to G/L Acc. No." := TempICGLAcc."Map-to G/L Acc. No.";
                      OrgICGLAcc.GET(ICGLAcc."No.");
                      OrgICGLAcc.DELETE;
                      TempICGLAcc.DELETE;
                    END ELSE
                      Inserted := Inserted + 1;
                    */

                end;
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

    var
        cust: Record Customer;
}

