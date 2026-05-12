#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50365 "Membership App Witness Card"
{
    PageType = Card;
    SourceTable = "Member Group Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("BOSA No."; Rec."BOSA No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
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

