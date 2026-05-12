#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50887 "Change Req Signatory list"
{
    PageType = Card;
    SourceTable = "Change Request New Signatories";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    trigger OnValidate()
                    begin

                    end;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CUST.Reset;
                        CUST.SetRange(CUST."ID No.", Rec."ID No.");
                        if CUST.Find('-') then begin
                            Rec."BOSA No." := CUST."No.";
                            Rec.Names := CUST.Name;
                            Rec."Date Of Birth" := CUST."Date of Birth";
                            Rec."Email Address" := cust."E-Mail (Personal)";
                        end;
                    end;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Control1102760009; Rec.Signatory)
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
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {

        }
    }

    trigger OnOpenPage()
    begin

    end;

    var
        MemberApp: Record "Membership Applications";
        ReltnShipTypeEditable: Boolean;
        CUST: Record Customer;
}

