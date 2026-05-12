pageextension 50625 "Customer Posting Group Ext" extends "Customer Posting Groups"
{
    layout
    {
        // addfirst(Control1)
        // {

        //     field("Account Type"; Rec."Account Type")
        //     {

        //     }


        // }
        modify("View All Accounts on Lookup")
        {
            Visible = false;
        }
        modify("Service Charge Acc.")
        {
            Visible = false;
        }
        modify("Debit Rounding Account")
        {
            Visible = false;
        }
        modify("Credit Rounding Account")
        {
            Visible = false;
        }
        modify(ShowAllAccounts)
        {
            Visible = false;
        }
        modify("Payment Disc. Credit Acc.")
        {
            Visible = false;
        }
        modify("Payment Disc. Debit Acc.")
        {
            Visible = false;
        }
        modify("Interest Account")
        {
            Visible = false;
        }
        modify("Additional Fee Account")
        {
            Visible = false;
        }
        modify("Add. Fee per Line Account")
        {
            Visible = false;
        }
        modify("Invoice Rounding Account")
        {
            Visible = false;
        }
        modify("Debit Curr. Appln. Rndg. Acc.")
        {
            Visible = false;
        }
        modify("Credit Curr. Appln. Rndg. Acc.")
        {
            Visible = false;
        }
        modify("Payment Tolerance Credit Acc.")
        {
            Visible = false;
        }
        modify("Payment Tolerance Debit Acc.")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}