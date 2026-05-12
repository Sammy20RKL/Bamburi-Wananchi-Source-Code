#pragma warning disable AL0729
page 50643 "Applicant Picture"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the Passport Image of the member.';
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
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    DialogTittle: Label 'Select The Media File...';
                    FileName: Text;
                    InstreamFile: InStream;
                //................................................................
                begin
                    Rec.TestField(Rec."No.");
                    if UploadIntoStream(DialogTittle, '', 'All Files (*.*)|*.*', FileName, InstreamFile) then begin
                        if Rec."Picture 2".HasValue() then begin
                            if Confirm(OverrideImageQst, false) = false then begin
                                exit;
                            end else begin
                                Clear(REC.Picture);
                                rec.Modify();
                            end;
                        end;
                        rec.Picture.ImportStream(InstreamFile, FileName);
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
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    ExportPath: Text;
                    TenantMedia: Record "Tenant Media";
                    FileName: Text;
                    InstreamPic: InStream;
                begin
                    Rec.TestField(Rec."No.");
                    if TenantMedia.Get(REC.Picture.MediaId) then begin
                        TenantMedia.CalcFields(TenantMedia.Content);
                        if TenantMedia.Content.HasValue then begin
                            FileName := '';
                            FileName := StrSubstNo(REC."No." + '.png', TenantMedia.TableCaption);
                            TenantMedia.Content.CreateInStream(InstreamPic, TextEncoding::UTF8);
                            DownloadFromStream(InstreamPic, '', '', '', FileName)
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
                ToolTip = 'Delete Picture.';

                trigger OnAction()
                begin
                    Rec.TestField(Rec."No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec.Picture);
                    Rec.Modify(true);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
        if (rec."Approval Status" = rec."Approval Status"::Open) then begin
            RecordIsOpen := true;
        end;
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Camera: Codeunit Camera;
        RecordIsOpen: Boolean;
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing Passport picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        MimeTypeTok: Label 'image/jpeg', Locked = true;
        DownloadImageTxt: label 'Download image';

    procedure TakeNewPicture()
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.TestField(Rec."No.");

        if Rec."Picture 2".HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            // Clear(rec.Picture);
            rec.Picture.ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true)
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."Picture 2".HasValue;
    end;

}

