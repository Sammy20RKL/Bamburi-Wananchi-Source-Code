pageextension 57105 "Purch Invoice Vendor Filter" extends "Purchase Invoice"
{
    layout
    {
        modify("Buy-from Vendor No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Vendor: Record Vendor;
                VendorList: Page "Vendor List";
            begin
                Vendor.SetFilter("No.", '<>%1', '100-BWS*');
                VendorList.SetTableView(Vendor);
                VendorList.LookupMode(true);
                if VendorList.RunModal() = Action::LookupOK then begin
                    VendorList.GetRecord(Vendor);
                    Text := Vendor."No.";
                    exit(true);
                end;
                exit(false);
            end;
        }
    }
}