pageextension 56000 "SGN Ext. Sales Order" extends "Company Information"
{
    layout
    {
        addafter(General)
        {
            group("SGN Signature Group")
            {
                usercontrol("SGN SGNSignaturePad"; "SGN SGNSignaturePad")
                {
                    ApplicationArea = All;
                    Visible = true;
                    trigger Ready()
                    begin
                        CurrPage."SGN SGNSignaturePad".InitializeSignaturePad();
                    end;

                    trigger Sign(Signature: Text)
                    begin
                        Rec.SignDocument(Signature);
                        CurrPage.Update(false);
                    end;
                }

            }
            field("SGN Signature"; Rec."SGN Signature")
            {
                Caption = 'CEO Signature';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

}