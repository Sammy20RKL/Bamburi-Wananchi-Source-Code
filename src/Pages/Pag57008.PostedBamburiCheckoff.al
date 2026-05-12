page 57008 "Posted Bamburi Checkoff"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Bamburi Checkoff Header";
    SourceTableView = where(Posted = const(true));
    Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date"; Rec."Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                }
                // field(Remarks; Rec.Remarks)
                // {
                //     ApplicationArea = Basic;
                // }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account No"; Rec."Account No")
                {
                    Caption = 'Bank Account';
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Cheque Amount';
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Bosa receipt lines"; "Bamburi CheckoffLines")
            {
                SubPageLink = "Receipt Header No" = field(No);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Processed Checkoff")
            {
                Caption = 'UnMark as Posted';
                ApplicationArea = Basic;
                Image = POST;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to un-mark this Checkoff as Posted', false) = true then begin
                        Rec.Posted := false;
                        Rec."Posted By" := '';
                        Rec.Modify;
                        CurrPage.close();
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}