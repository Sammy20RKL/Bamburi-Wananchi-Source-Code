#pragma warning disable AL0729
Page 56114 "Bosa Member Signature"
{
    Caption = 'Applicant "Specimen Signature"';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Bosa Member App Group Members";

    layout
    {
        area(content)
        {
            field("Specimen Signature"; Rec."Specimen Signature")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the "Specimen Signature" of the Member.';
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
                Image = "Specimen Signature";

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
                ToolTip = 'Import a "Specimen Signature" file.';

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

                    // Rec.TestField(Rec."No.");
                    // Rec.TestField(Rec."ID Number/Passport Number");
                    // Rec.TestField(Rec.Name);
                    //......if it finds a pic,throw message to confirm if override it
                    if Rec."Specimen Signature".HasValue() then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    //FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(REC."Specimen Signature");
                    // REC."Specimen Signature".ImportFile(FileName, ClientFileName);
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
                ToolTip = 'Export the "Specimen Signature" media to a file.';

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin

                    // Rec.TestField(Rec."No.");
                    Rec.TestField(rec.Name);

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    //  ExportPath := TemporaryPath + rec."ID Number/Passport Number" + Format(rec."Specimen Signature".MediaId);
                    //rec."Specimen Signature".ExportFile(ExportPath);

                    //FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete "Specimen Signature".';

                trigger OnAction()
                begin
                    // Rec.TestField(Rec."No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec."Specimen Signature");
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

    var

        Camera: Codeunit Camera;
        [InDataSet]
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing "Specimen Signature" media will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the "Specimen Signature" media?';
        SelectPictureTxt: Label 'Select a "Specimen Signature" media to upload';
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

        if Rec."Specimen Signature".HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            // Clear(rec."Specimen Signature");
            rec."Specimen Signature".ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true)
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."Specimen Signature".HasValue;
    end;
}

