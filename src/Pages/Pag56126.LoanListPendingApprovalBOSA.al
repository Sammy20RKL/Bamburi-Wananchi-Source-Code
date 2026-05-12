Page 56126 "LoanList-Pending Approval BOSA"
{
    ApplicationArea = All;
    Caption = 'Loan List-Pending Approval BOSA';
    CardPageID = "Loans Pending Approval";
    PageType = List;
    SourceTable = "Loans Register";
    UsageCategory = Lists;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = where(Posted = const(false),
                            Source = filter(BOSA), "Loan Status" = const(Appraisal), "Approval Status" = const(Pending));

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


                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Style = Ambiguous;

                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                }
                field("Rejection  Remark"; Rec."Rejection  Remark")
                {
                    ApplicationArea = Basic;
                    visible = false;
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

