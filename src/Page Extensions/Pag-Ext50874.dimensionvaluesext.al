pageextension 50874 "dimensionvaluesext" extends "Dimension Values"
{
    layout
    {
        addafter(Blocked)
        {
            field("Account Code"; Rec."Account Code")
            {
                ApplicationArea = Basic;
            }
            field("Banker Cheque Account"; Rec."Banker Cheque Account")
            {
                ApplicationArea = Basic;
            }
            field("Clearing Bank Account"; Rec."Clearing Bank Account")
            {
                ApplicationArea = Basic;
            }
            field("No. Series"; Rec."No. Series")
            {
                ApplicationArea = Basic;
            }
            field("Global Dimension No."; Rec."Global Dimension No.")
            {
                ApplicationArea = Basic;
            }
            field("Local Cheque Charges"; Rec."Local Cheque Charges")
            {
                ApplicationArea = Basic;
            }
            field("Upcountry Cheque Charges"; Rec."Upcountry Cheque Charges")
            {
                ApplicationArea = Basic;
            }
            field("Bounced Cheque Charges"; Rec."Bounced Cheque Charges")
            {
                ApplicationArea = Basic;
            }
        }
        //..............modify
        modify(Totaling)
        {
            Visible = false;
        }
    }
}
