Page 56040 "Cheque Truncation details buff"
{
    ApplicationArea = All;
    Caption = 'Cheque Truncation details buff';
    PageType = ListPart;
    SourceTable = "Cheque Truncation Buffer";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ChequeDataId; Rec.ChequeDataId)
                {
                    ToolTip = 'Specifies the value of the AMOUNT field.';
                }
                field(SerialId; Rec.SerialId)
                {
                    ToolTip = 'Specifies the value of the BIMAGESIGN field.';
                }
                field(FilePathName; Rec.FilePathName)
                {
                    ToolTip = 'Specifies the value of the BIMAGESIZE field.';
                }
                field(RCODE; Rec.RCODE)
                {
                    ToolTip = 'Specifies the value of the CHQDGT field.';
                }
                field(VTYPE; Rec.VTYPE)
                {
                    ToolTip = 'Specifies the value of the COLLACC field.';
                }
                field(AMOUNT; Rec.AMOUNT)
                {
                    ToolTip = 'Specifies the value of the CURRENCYCODE field.';
                }
                field(ENTRYMODE; Rec.ENTRYMODE)
                {
                    ToolTip = 'Specifies the value of the ChequeDataId field.';
                }
                field(CURRENCYCODE; Rec.CURRENCYCODE)
                {
                    ToolTip = 'Specifies the value of the CreatedBy field.';
                }
                field(DESTBANK; Rec.DESTBANK)
                {
                    ToolTip = 'Specifies the value of the CreatedOn field.';
                }
                field(DESTBRANCH; Rec.DESTBRANCH)
                {
                    ToolTip = 'Specifies the value of the DESTACC field.';
                }
                field(DESTACC; Rec.DESTACC)
                {
                    ToolTip = 'Specifies the value of the DESTBANK field.';
                }
                field(CHQDGT; Rec.CHQDGT)
                {
                    ToolTip = 'Specifies the value of the DESTBRANCH field.';
                }
                field(PBANK; Rec.PBANK)
                {
                    ToolTip = 'Specifies the value of the ENTRYMODE field.';
                }
                field(PBRANCH; Rec.PBRANCH)
                {
                    ToolTip = 'Specifies the value of the FILLER field.';
                }
                field(FILLER; Rec.FILLER)
                {
                    ToolTip = 'Specifies the value of the FIMAGESIGN field.';
                }
                field(COLLACC; Rec.COLLACC)
                {
                    ToolTip = 'Specifies the value of the FIMAGESIGNBW field.';
                }
                field(MemberNo; Rec.MemberNo)
                {
                    ToolTip = 'Specifies the value of the FIMAGESIZE field.';
                }
                field(MembId; Rec.MembId)
                {
                    ToolTip = 'Specifies the value of the FIMAGESIZEBW field.';
                }
                field(MembShareId; Rec.MembShareId)
                {
                    ToolTip = 'Specifies the value of the FilePathName field.';
                }
                field(SNO; Rec.SNO)
                {
                    ToolTip = 'Specifies the value of the FrontBWImage field.';
                }
                field(PROCNO; Rec.PROCNO)
                {
                    ToolTip = 'Specifies the value of the FrontGrayScaleImage field.';
                }
                field(FIMAGESIZEBW; Rec.FIMAGESIZEBW)
                {
                    ToolTip = 'Specifies the value of the Imported to Receipt Lines field.';
                }
                field(FIMAGESIGNBW; Rec.FIMAGESIGNBW)
                {
                    ToolTip = 'Specifies the value of the IsFCY field.';
                }
                field(FIMAGESIZE; Rec.FIMAGESIZE)
                {
                    ToolTip = 'Specifies the value of the MembId field.';
                }
                field(FIMAGESIGN; Rec.FIMAGESIGN)
                {
                    ToolTip = 'Specifies the value of the MembShareId field.';
                }
                field(BIMAGESIZE; Rec.BIMAGESIZE)
                {
                    ToolTip = 'Specifies the value of the MemberNo field.';
                }
                field(BIMAGESIGN; Rec.BIMAGESIGN)
                {
                    ToolTip = 'Specifies the value of the ModifiedBy field.';
                }
                field(FrontBWImage; Rec.FrontBWImage)
                {
                    ToolTip = 'Specifies the value of the ModifiedOn field.';
                }
                field(FrontGrayScaleImage; Rec.FrontGrayScaleImage)
                {
                    ToolTip = 'Specifies the value of the PBANK field.';
                }
                field(RearImage; Rec.RearImage)
                {
                    ToolTip = 'Specifies the value of the PBRANCH field.';
                }
                field(IsFCY; Rec.IsFCY)
                {
                    ToolTip = 'Specifies the value of the PROCNO field.';
                }
                field(Supflag; Rec.Supflag)
                {
                    ToolTip = 'Specifies the value of the RCODE field.';
                }
                field(CreatedBy; Rec.CreatedBy)
                {
                    ToolTip = 'Specifies the value of the RearImage field.';
                }
                field(CreatedOn; Rec.CreatedOn)
                {
                    ToolTip = 'Specifies the value of the SNO field.';
                }
                field(UploadedFileId; Rec.UploadedFileId)
                {
                    ToolTip = 'Specifies the value of the SerialId field.';
                }
                field("Imported to Receipt Lines"; Rec."Imported to Receipt Lines")
                {
                    ToolTip = 'Specifies the value of the SupervisedBy field.';
                }

            }
        }
    }
}
