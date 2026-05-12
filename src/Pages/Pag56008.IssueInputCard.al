#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56008 "Issue Input Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Loans reg";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Module Code"; Rec."Module Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Module';
                }
                field("UAT Item"; Rec."UAT Item")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issue Description';
                    MultiLine = true;
                }
                field("USER ID"; Rec."USER ID")
                {
                    ApplicationArea = Basic;
                }
                field("UAT Level"; Rec."UAT Level")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Status"; Rec."Customer Status")
                {
                    ApplicationArea = Basic;
                }
                field("User Comments"; Rec."User Comments")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Submit Issue';
                Image = post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."Module Code" = '' then
                        Error('Kindly select module');
                    if Rec."UAT Item" = '' then
                        Error('Kindly enter description of the issue being submitted.');
                    Rec.Posted := true;
                    Rec.Modify;
                    Message('Your issue has been submitted and shall be handled ASAP! Thank you.');
                end;
            }
            group(ActionGroup9)
            {
            }
        }
    }

    var
        Post: Integer;
}

