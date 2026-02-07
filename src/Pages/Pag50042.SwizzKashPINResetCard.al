#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50042 "SwizzKash PIN Reset Card"
{
    Editable = true;
    PageType = Card;
    ModifyAllowed = true;
    SourceTable = "SwizzKash Applications";

    DeleteAllowed = false;
    InsertAllowed = false;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Applied"; Rec."Time Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last PIN Reset"; Rec."Last PIN Reset")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reset By"; Rec."Reset By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SentToServer; Rec.SentToServer)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Reset Pin API")
            {
                ApplicationArea = Basic;
                Image = Answers;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F5';
                Visible = false;

                trigger OnAction()
                var
                    appRec: Record "SwizzKash Applications";
                begin
                    // Re-get the record by primary key to be safe
                    if not appRec.Get(Rec."No.") then
                        Error('Record not found');

                    if appRec."PIN Requested" then
                        Error('Pin reset has already been requested.');

                    // Update record
                    resetPINRequest(Rec."Account No");

                    // Insert log
                    pinResetLogs.Init();
                    pinResetLogs."Account Name" := appRec."Account Name";
                    pinResetLogs."No" := appRec."No.";
                    pinResetLogs."ID No" := appRec."ID No";
                    pinResetLogs."Account No" := appRec."Account No";
                    pinResetLogs.Telephone := appRec.Telephone;
                    pinResetLogs.Date := CurrentDateTime;
                    pinResetLogs."Last PIN Reset" := CurrentDateTime;
                    pinResetLogs."Reset By" := UserId;
                    pinResetLogs.Insert();

                    Message('Pin reset has been successfully sent.');
                end;
            }

            action("Reset Pin")
            {
                ApplicationArea = Basic;
                Image = Answers;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F5';
                trigger OnAction()
                begin
                    if Rec."PIN Requested" then
                        Error('Pin reset has already been requested.');

                    // Update record
                    Rec."Last PIN Reset" := Today;
                    Rec."Reset By" := UserId;
                    Rec.SentToServer := false;
                    Rec."PIN Requested" := true;
                    Rec.Modify();
                    Commit();

                    // Create log
                    pinResetLogs.Init();
                    pinResetLogs."Account Name" := Rec."Account Name";
                    pinResetLogs."No" := Rec."No.";
                    pinResetLogs."ID No" := Rec."ID No";
                    pinResetLogs."Account No" := Rec."Account No";
                    pinResetLogs.Telephone := Rec.Telephone;
                    pinResetLogs.Date := CurrentDateTime;
                    pinResetLogs."Last PIN Reset" := CurrentDateTime;
                    pinResetLogs."Reset By" := UserId;

                    pinResetLogs.Insert();

                    Message('Pin reset has been successfully sent.');
                end;
            }
            action("PIN Reset Entries")
            {
                ApplicationArea = Basic;
                Image = CampaignEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "SwizzKash PIN Reset Logs";
                RunPageLink = No = field("No.");
                RunPageOnRec = false;
                RunPageView = sorting(No)
                              order(descending);
            }
        }
    }

    trigger OnOpenPage()
    begin
        //ERROR('under maintenance');
    end;

    var
        SwizzKashapp: Record "SwizzKash Applications";
        pinResetLogs: Record "SwizzKash Pin Reset Logs";

    procedure resetPINRequest(accountNumber: Code[20])
    begin
        SwizzKashapp.Reset();
        SwizzKashapp.SetRange(SwizzKashapp."Account No", accountNumber);
        if SwizzKashapp.Find('-') then begin
            SwizzKashapp."PIN Requested" := true;
            SwizzKashapp."Last PIN Reset" := Today;
            SwizzKashapp."Reset By" := UserId;
            SwizzKashapp.SentToServer := false;
            SwizzKashapp."PIN Requested" := true;
            SwizzKashapp.Modify();

            SwizzKashapp.Modify(true);
        end;
    end;
}

