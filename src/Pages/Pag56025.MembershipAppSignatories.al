#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56025 "Membership App Signatories"
{
    CardPageID = "Membership App Signatories";
    PageType = List;
    SourceTable = "Member App Signatories";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                            Rec."Staff/Payroll" := CUST."Payroll/Staff No2";
                            Rec."Date Of Birth" := CUST."Date of Birth";
                            Rec."Mobile No." := CUST."Mobile Phone No";
                            Rec.Modify;
                        end;
                    end;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = false;
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
                field("BOSA No."; Rec."BOSA No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No"; Rec."Mobile No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
            }
        }
        area(factboxes)
        {

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
        // MemberApp.Reset;
        // MemberApp.SetRange(MemberApp."No.", "Account No");
        // if MemberApp.Find('-') then begin
        //     if MemberApp.Status = MemberApp.Status::Approved then begin
        //         CurrPage.Editable := false;
        //     end else
        //         CurrPage.Editable := true;
        // end;
    end;

    trigger OnInit()
    begin

    end;

    var
        MemberApp: Record "Membership Applications";
        ReltnShipTypeEditable: Boolean;
        CUST: Record Customer;
}

