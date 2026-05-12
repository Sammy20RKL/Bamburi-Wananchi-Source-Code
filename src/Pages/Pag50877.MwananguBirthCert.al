#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50877 "Mwanangu Birth Cert"
{
    PageType = CardPart;
    SourceTable = 51430;

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = Basic;
                Caption = 'Birth Certificate';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                begin
                    ImportFromDevice;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    NameValueBuffer: Record "Name/Value Buffer";
                    TempNameValueBuffer: Record "Name/Value Buffer" temporary;
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    Rec.TestField("No.");
                    //TESTFIELD(Description);

                    NameValueBuffer.DeleteAll;
                    ExportPath := TemporaryPath + Rec."No." + Format(Rec.Picture.MediaId);
                    Rec.Picture.ExportFile(ExportPath);
                    FileManagement.GetServerDirectoryFilesList(TempNameValueBuffer, TemporaryPath);
                    TempNameValueBuffer.SetFilter(Name, StrSubstNo('%1*', ExportPath));
                    TempNameValueBuffer.FindFirst;
                    ToFile := StrSubstNo('%1 %2.jpg', Rec."No.", ConvertStr(Rec."No.", '"/\', '___'));
                    Download(TempNameValueBuffer.Name, DownloadImageTxt, '', '', ToFile);
                    if FileManagement.DeleteServerFile(TempNameValueBuffer.Name) then;
                end;
            }
        }
    }

    var
        OverrideImageQst: label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: label 'Select a picture to upload';
        DownloadImageTxt: label 'Download image';

    procedure ImportFromDevice()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;
    begin
        Rec.Find;
        Rec.TestField("No.");
        //TESTFIELD(Description);

        if Rec.Picture.HasValue then
            if not Confirm(OverrideImageQst) then
                Error('');

        ClientFileName := '';
        FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
        if FileName = '' then
            Error('');

        Clear(Rec.Picture);
        Rec.Picture.ImportFile(FileName, ClientFileName);
        if not Rec.Insert(true) then
            Rec.Modify(true);

        if FileManagement.DeleteServerFile(FileName) then;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        //DeleteExportEnabled := Picture.COUNT <> 0;
    end;

    procedure SetHideActions()
    begin
        //HideActions := TRUE;
    end;
}

