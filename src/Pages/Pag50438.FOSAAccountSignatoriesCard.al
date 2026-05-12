#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50438 "FOSA Account Signatories Card"
{
    PageType = Card;
    SourceTable = "Witness Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("BOSA No."; Rec."BOSA No.")
                {
                    ApplicationArea = Basic;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Signatory; Rec.Signatory)
                {
                    ApplicationArea = Basic;
                }
                field("Must Sign"; Rec."Must Sign")
                {
                    ApplicationArea = Basic;
                }
                field("Must be Present"; Rec."Must be Present")
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

