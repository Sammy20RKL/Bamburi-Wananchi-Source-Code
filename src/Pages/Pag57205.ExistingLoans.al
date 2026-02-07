// namespace PolyTechERPSourceCode.PolyTechERPSourceCode;

page 57205 "Existing Loans"
{
    ApplicationArea = All;
    Caption = 'Existing Loans';
    CardPageId = "Existing Loans Card";
    PageType = List;
    SourceTable = "Loans Register";
    UsageCategory = Administration;
    Editable = false;

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
                    Style = StrongAccent;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Style = Ambiguous;
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
}
