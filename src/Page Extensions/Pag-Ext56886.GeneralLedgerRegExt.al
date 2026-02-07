pageextension 56886 "General Ledger Reg Ext" extends "G/L Registers"
{
    layout
    {
        addbefore("No.")
        {
            // field(document)
        }
        modify("From VAT Entry No.")
        {
            Visible = false;
        }
        modify("To VAT Entry No.")
        {
            Visible = false;
        }


        modify(Control1900383207)
        {
            Visible = false;
        }
        modify(Control1905767507)
        {
            Visible = false;
        }

    }
    actions
    {
        modify(ChangeDimensions)
        {
            visible = false;
        }
        modify("VAT Entries")
        {
            visible = false;
        }
        modify("Maintenance Ledger")
        {
            visible = false;
        }
        modify("Fixed &Asset Ledger")
        {
            visible = false;
        }
        modify("Delete Empty Registers")
        {
            visible = false;
        }
        modify("Employee Ledger")
        {
            visible = false;
        }

        modify("Item Ledger Relation")
        {
            visible = false;
        }
        modify("Customer &Ledger")
        {
            Caption = 'Member Ledger Entries';
        }
    }
    var
        RunningBal: Decimal;
        CalcRunningAccBalance: Codeunit "System General Setup";

    trigger OnOpenPage()
    begin
        CurrPage.Editable := false;
    end;

}
