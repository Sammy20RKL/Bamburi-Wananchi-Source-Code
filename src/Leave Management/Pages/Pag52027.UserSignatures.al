page 52027 "User Signatures"
{
    PageType = Card;
    SourceTable = "User Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    DelayedInsert = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Signature field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DeleteSignature)
            {
                Caption = 'Delete Signature';
                Image = DeleteQtyToHandle;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ConfirmManagement: Codeunit "Confirm Management";
                    UserSetupRec: Record "User Setup";
                    DeleteConfirmMsg: Label 'Are you sure you want to delete %1''s signature?';
                begin
                    if ConfirmManagement.GetResponseOrDefault(StrSubstNo(DeleteConfirmMsg, Rec."User ID"), false) then begin
                        UserSetupRec.Get(Rec."User ID");
                        UserSetupRec.CalcFields(Signature);
                        if UserSetupRec.Signature.HasValue then begin
                            Clear(UserSetupRec.Signature);
                            UserSetupRec.Modify();
                        end;
                    end;
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(DeleteSignature_Promoted; DeleteSignature)
                {
                }
            }
        }
    }
}