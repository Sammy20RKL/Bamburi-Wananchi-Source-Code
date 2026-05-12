#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50876 "Member Signature-Uploaded"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = 51364;

    layout
    {
        area(content)
        {
            field(Signature; Rec.Signature)
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                Enabled = false;
                Importance = Promoted;
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the signature.';
            }
        }
    }

    actions
    {
        area(processing)
        {
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

        if Rec.Signature.Count > 0 then
            if not Confirm(OverrideImageQst) then
                Error('');

        ClientFileName := '';
        FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
        if FileName = '' then
            Error('');

        Clear(Rec.Signature);
        Rec.Signature.ImportFile(FileName, ClientFileName);
        if not Rec.Insert(true) then
            Rec.Modify(true);

        if FileManagement.DeleteServerFile(FileName) then;
    end;
}

