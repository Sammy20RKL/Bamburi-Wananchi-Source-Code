#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50446 "Teller & Treasury Trans List"
{
    // CardPageID = "Teller & Treasury Trans Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Treasury Transactions";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("From Account"; Rec."From Account")
                {
                    ApplicationArea = Basic;
                }
                field("From Account User"; Rec."From Account User")
                {
                    ApplicationArea = Basic;
                    Caption = 'From';
                }
                field("To Account"; Rec."To Account")
                {
                    ApplicationArea = Basic;
                }
                field("To Account User"; Rec."To Account User")
                {
                    ApplicationArea = Basic;
                    Caption = 'To';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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

