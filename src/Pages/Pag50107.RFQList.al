#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50107 "RFQ List"
{
    // CardPageID = "RFQ Header";
    PageType = List;
    SourceTable = "Purchase Quote Header";
    SourceTableView = where(Status = filter(Open | Released));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Closing Date"; Rec."Expected Closing Date")
                {
                    ApplicationArea = Basic;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }


    procedure GetSelectionFilter(): Text
    var
        RFQ: Record 51100;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(RFQ);
        //EXIT(SelectionFilterManagement.GetSelectionFilterForItem(Item));
        exit(RFQ."No.");
    end;


    procedure SetSelection(var RFQ: Record 51100)
    begin
        CurrPage.SetSelectionFilter(RFQ);
    end;
}

