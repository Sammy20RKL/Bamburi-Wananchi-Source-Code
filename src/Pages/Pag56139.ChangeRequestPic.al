#pragma warning disable AL0729
Page 56139 "Change Request Pic"
{
    Caption = 'New Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Change Request";

    layout
    {
        area(content)
        {
            field("Picture(New Value)"; Rec."Picture(New Value)")
            {
                ApplicationArea = All;
                Caption = 'New Picture';
                ToolTip = 'Specifies the picture of the Member.';
                ShowMandatory = true;
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
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                    //...............................................................
                    NameValueBuffer: Record "Name/Value Buffer";
                    TempNameValueBuffer: Record "Name/Value Buffer" temporary;
                    ToFile: Text;
                    ExportPath: Text;
                //................................................................
                begin

                    Rec.TestField(Rec.No);
                    //......if it finds a pic,throw message to confirm if override it
                    if Rec."Picture(New Value)".HasValue() then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    // FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(REC."Picture(New Value)");
                    // REC."Picture(New Value)".ImportFile(FileName, ClientFileName);
                    if not Rec.Modify(true) then
                        Rec.Insert(true);

                    // if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin

                    Rec.TestField(Rec.No);

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    //ExportPath := TemporaryPath + rec.No + Format(rec."Picture(New Value)".MediaId);
                    //rec."Picture(New Value)".ExportFile(ExportPath);

                    // FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete Picture.';

                trigger OnAction()
                begin
                    Rec.TestField(Rec.No);

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec."Picture(New Value)");
                    Rec.Modify(true);
                end;
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Camera: Codeunit Camera;
        [InDataSet]
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
        Rec.TestField(Rec.No);

        if Rec."Picture(New Value)".HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(rec."Picture(New Value)");
            Rec.Modify(true)
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Picture.HasValue;//Count > 0;
    end;
}

