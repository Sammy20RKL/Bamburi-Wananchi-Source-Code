Page 56127 "Loan Application BOSA-Approved"
{
    ApplicationArea = All;
    Caption = 'Loan List-Approved Applications BOSA';
    CardPageID = "BOSA Loans Disbursement Card";
    PageType = List;
    SourceTable = "Loans Register";
    UsageCategory = Lists;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = where(Posted = const(false),
                            Source = filter(BOSA), "Approval Status" = const(Approved));

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

    trigger OnOpenPage()
    begin
        If FnCanPostLoans(UserId) = false then begin
            Rec.SetRange("Captured By", UserId);
        end;
    end;

    local procedure FnCanPostLoans(UserId: Text): Boolean
    var
        UserSetUp: Record "User Setup";
    begin
        if UserSetUp.get(UserId) then begin
            if UserSetUp."Can POST Loans" = true then begin
                exit(true);
            end;
        end;
        exit(false);
    end;

}

