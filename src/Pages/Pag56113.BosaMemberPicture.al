#pragma warning disable AL0729
Page 56113 "Bosa Member Picture"
{
    Caption = 'Applicant Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Bosa Member App Group Members";

    layout
    {
        area(content)
        {
            field("Specimen Passport"; Rec."Specimen Passport")
            {
                ApplicationArea = All;
                ShowCaption = false;
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


                    // Rec.TestField(Rec."Specimen Passport");
                    // Rec.TestField(Rec.Name);
                    //......if it finds a pic,throw message to confirm if override it
                    if Rec."Specimen Passport".HasValue() then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    //FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(REC."Specimen Passport");
                    //REC."Specimen Passport".ImportFile(FileName, ClientFileName);
                    if not Rec.Modify(true) then
                        Rec.Insert(true);

                    //if FileManagement.DeleteServerFile(FileName) then;



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


                    Rec.TestField(rec.Name);

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    //ExportPath := TemporaryPath + rec."ID Number/Passport Number" + Format(rec."Specimen Passport".MediaId);
                    //rec."Specimen Passport".ExportFile(ExportPath);

                    //FileManagement.ExportImage(ExportPath, ToFile);
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
                    // Rec.TestField(Rec."No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec."Specimen Passport");
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
        // Rec.TestField(Rec."No.");
        Rec.TestField(rec.Name);

        if Rec."Specimen Passport".HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            //  Clear(rec.Picture);
            rec."Specimen Passport".ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true)
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."Specimen Passport".HasValue;
    end;
}



