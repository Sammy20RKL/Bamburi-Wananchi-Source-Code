Page 56125 "Loan List-New Application BOSA"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Application Card";
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = const(false),
                            Source = filter(BOSA));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member  No';
                }

                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; Rec."Captured By")
                {

                }
            }
        }
        area(factboxes)
        {
            part(Control1000000000; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }

    actions
    {

    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Captured By", UserId);

    end;
}

