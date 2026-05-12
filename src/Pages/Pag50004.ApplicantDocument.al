#pragma warning disable AL0729
page 50004 "Applicant Document"
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
            field("Identification Image"; Rec."Identification Image")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the Identification Document of the member.';
                ShowMandatory = true;
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
                ToolTip = 'Import Document file.';
                Enabled = RecordIsOpen;

                trigger OnAction()
                var
                    DialogTittle: Label 'Select The Media File...';
                    FileName: Text;
                    InstreamFile: InStream;
                //................................................................
                begin
                    Rec.TestField(Rec."No.");
                    if UploadIntoStream(DialogTittle, '', 'All Files (*.*)|*.*', FileName, InstreamFile) then begin
                        if Rec."Identification Image".HasValue() then begin
                            if Confirm(OverrideImageQst, false) = false then begin
                                exit;
                            end else begin
                                Clear(REC."Identification Image");
                                rec.Modify();
                            end;
                        end;
                        rec."Identification Image".ImportStream(InstreamFile, FileName);
                        if not Rec.Modify(true) then
                            Rec.Insert(true);
                    end;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled and RecordIsOpen;
                ;
                Image = Delete;
                ToolTip = 'Delete Document.';

                trigger OnAction()
                begin
                    Rec.TestField(Rec."No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec."Identification Image");
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


    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."Identification Image".HasValue;
    end;

}

