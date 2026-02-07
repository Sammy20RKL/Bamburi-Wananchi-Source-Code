pageextension 50029 "Bank Acc. Reconciliation" extends "Bank Acc. Reconciliation"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addfirst(processing)
        {

            action("Bank Acc. Recon. - Test")
            {
                Caption = 'Bank Reconciliation Test Report';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                RunObject = report "Bank Acc. Recon. - Test";
            }
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}