#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56187 "SwizzKash Paybill Tran Card"
{
    PageType = Card;
    SourceTable = "SwizzKash MPESA Trans";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Key Word"; Rec."Key Word")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Needs Manual Posting"; Rec."Needs Manual Posting")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                group("Record Logs")
                {

                    Visible = CanViewRecordLogs;
                    field("Changed By"; Rec."Changed By")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Date Changed"; Rec."Date Changed")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Time Changed"; Rec."Time Changed")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                }

            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Refresh")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Refresh Page';
                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            action("Mark As Reversed")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = ActionIsVisible;
                Visible = ActionIsVisible;
                trigger OnAction()
                begin
                    if confirm('Are you sure you want to mark transaction as reversed?This means that transaction will never be posted in the sytem', false) = false then begin
                        exit;
                    end else begin
                        rec.Reversed := true;
                        rec.Description := rec.Description + '-Is Reversed';
                        rec.Modify(true);
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
    begin
        FnUpdateControls();
    end;

    trigger OnAfterGetCurrRecord()
    var
    begin
        FnUpdateControls();
    end;

    trigger OnAfterGetRecord()
    var
    begin
        FnUpdateControls();
    end;

    local procedure FnUpdateControls()
    var
        StatusChangePermissions: Record "Status Change Permision";
    begin
        ActionIsVisible := false;
        CanViewRecordLogs := false;
        StatusChangePermissions.Reset();
        StatusChangePermissions.SetRange(StatusChangePermissions."User ID", UserId);
        StatusChangePermissions.SetRange(StatusChangePermissions.Function, StatusChangePermissions.Function::"Can View Paybill Logs");
        if StatusChangePermissions.Find('-') then begin
            CanViewRecordLogs := true;
        end;

        if (rec.Posted = false) and (rec.Reversed = false) then ActionIsVisible := true;
        if rec.Reversed = true then begin
            CurrPage.Editable := false;
            Message('Note: This transaction is marked as reversed.');
        end;
        if rec.Posted = true then begin
            CurrPage.Editable := false;
        end;
    end;

    var
        ActionIsVisible: Boolean;
        CanViewRecordLogs: Boolean;
}

