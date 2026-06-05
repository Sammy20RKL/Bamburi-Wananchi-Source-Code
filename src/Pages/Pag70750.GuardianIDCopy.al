#pragma warning disable AL0729
page 50710 "Guardian ID Copy"
{
    Caption = 'Guardian ID Copy';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            field("ID Copy"; Rec."ID Copy")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the Guardian ID/Passport Copy.';
                ShowMandatory = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Picture;
                Enabled = RecordIsOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Open camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                Enabled = RecordIsOpen;
                ToolTip = 'Import Guardian ID file.';

                trigger OnAction()
                var
                    DialogTittle: Label 'Select The Media File...';
                    FileName: Text;
                    InstreamFile: InStream;
                begin
                    Rec.TestField(Rec."No.");
                    if UploadIntoStream(DialogTittle, '', 'All Files (*.*)|*.*', FileName, InstreamFile) then begin
                        if Rec."ID Copy".HasValue() then begin
                            if Confirm(OverrideImageQst, false) = false then begin
                                exit;
                            end else begin
                                Clear(Rec."ID Copy");
                                Rec.Modify();
                            end;
                        end;
                        Rec."ID Copy".ImportStream(InstreamFile, FileName);
                        if not Rec.Modify(true) then
                            Rec.Insert(true);
                    end;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled and RecordIsOpen;
                Image = Export;
                ToolTip = 'Export Guardian ID to a file.';

                trigger OnAction()
                var
                    TenantMedia: Record "Tenant Media";
                    FileName: Text;
                    InstreamPic: InStream;
                begin
                    Rec.TestField(Rec."No.");
                    if TenantMedia.Get(Rec."ID Copy".MediaId) then begin
                        TenantMedia.CalcFields(TenantMedia.Content);
                        if TenantMedia.Content.HasValue then begin
                            FileName := Rec."No." + '_ID.png';
                            TenantMedia.Content.CreateInStream(InstreamPic, TextEncoding::UTF8);
                            DownloadFromStream(InstreamPic, '', '', '', FileName);
                        end;
                    end;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled and RecordIsOpen;
                Image = Delete;
                ToolTip = 'Delete Guardian ID Copy.';

                trigger OnAction()
                begin
                    Rec.TestField(Rec."No.");
                    if not Confirm(DeleteImageQst) then
                        exit;
                    Clear(Rec."ID Copy");
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
        RecordIsOpen := Rec."Approval Status" = Rec."Approval Status"::Open;
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Camera: Codeunit Camera;
        RecordIsOpen: Boolean;
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing Guardian ID will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the Guardian ID?';
        DeleteExportEnabled: Boolean;
        MimeTypeTok: Label 'image/jpeg', Locked = true;

    procedure TakeNewPicture()
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.TestField(Rec."No.");
        if Rec."ID Copy".HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;
        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Rec."ID Copy".ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true);
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."ID Copy".HasValue;
    end;
}