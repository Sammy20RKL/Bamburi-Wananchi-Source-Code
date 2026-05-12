#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50210 "HR Exit Interview Checklist"
{
    AutoSplitKey = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Exit Interview Checklist";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("CheckList Item"; Rec."CheckList Item")
                {
                    ApplicationArea = Basic;
                }
                field(Cleared; Rec.Cleared)
                {
                    ApplicationArea = Basic;
                }
                field("Clearance Date"; Rec."Clearance Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("&Get Checklist Items")
                {
                    ApplicationArea = Basic;
                    Caption = '&Get Checklist Items';
                    Image = ChangeTo;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //GET EMPLOYEES JOB TITLE
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."User ID", UserId);
                        if HREmp.Find('-') then begin

                            //IMPORT CHECKLIST ITEMS
                            HRLV.Reset;
                            HRLV.SetRange(HRLV.Type, HRLV.Type::"Checklist Item");
                            HRLV.SetRange(HRLV."To be cleared by", HREmp."Job Title");
                            if HRLV.Find('-') then begin
                                HRLV.FindFirst;
                                repeat
                                    Rec.Init;
                                    Rec."Exit Interview No" := Rec.GetFilter("Exit Interview No");
                                    Rec."Employee No" := Rec.GetFilter("Employee No");
                                    Rec."CheckList Item" := HRLV.Code;
                                    Rec."Line No" := Rec."Line No" + 1000;
                                    Rec.Insert;
                                until
                                HRLV.Next = 0;
                            end else begin
                                Message('No checklist items have been assigned to ' + UserId);
                            end;
                        end else begin
                            Message('User ID ' + UserId + ' has not been assigned to any employee');
                        end;
                    end;
                }
            }
        }
    }

    var
        HRLV: Record 51186;
        HREmp: Record 51160;
        JT: Code[50];
}

