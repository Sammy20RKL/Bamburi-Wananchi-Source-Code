#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56189 "SwizzKash Application Card"
{
    PageType = Card;
    SourceTable = "SwizzKash Applications";
    deleteallowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender) { ApplicationArea = Basic; }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(ActivationStatus; Rec.ActivationStatus)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Mobile Status"; Rec."Mobile Status") { ApplicationArea = Basic; }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Time Applied"; Rec."Time Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000004; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Refresh)
            {

                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Refresh;
                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            action(reload)
            {
                caption = 'Send Application';
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Post;
                trigger OnAction()
                begin
                    if Confirm('Are you sure to send the Mobile Application record for ' + Format(rec."Account Name") + ' for activation ?', false) = false then begin
                        exit;
                    end else begin
                        rec.status := rec.status::"Pending Approval";
                        rec.Modify(true);
                        Message('Record Marked for activation');
                        CurrPage.Close();
                    end;
                end;
            }
        }


    }

}

