#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50343 "Cheque Transactions Card."
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Cheque Truncation Buffer";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(SerialId; Rec.SerialId)
                {
                    ApplicationArea = Basic;
                }
                field(RCODE; Rec.RCODE)
                {
                    ApplicationArea = Basic;
                }
                field(VTYPE; Rec.VTYPE)
                {
                    ApplicationArea = Basic;
                }
                field(AMOUNT; Rec.AMOUNT)
                {
                    ApplicationArea = Basic;
                }
                field(ENTRYMODE; Rec.ENTRYMODE)
                {
                    ApplicationArea = Basic;
                }
                field(CURRENCYCODE; Rec.CURRENCYCODE)
                {
                    ApplicationArea = Basic;
                }
                field(DESTBANK; Rec.DESTBANK)
                {
                    ApplicationArea = Basic;
                }
                field(DESTBRANCH; Rec.DESTBRANCH)
                {
                    ApplicationArea = Basic;
                }
                field(DESTACC; Rec.DESTACC)
                {
                    ApplicationArea = Basic;
                }
                field(CHQDGT; Rec.CHQDGT)
                {
                    ApplicationArea = Basic;
                }
                field(PBANK; Rec.PBANK)
                {
                    ApplicationArea = Basic;
                }
                field(PBRANCH; Rec.PBRANCH)
                {
                    ApplicationArea = Basic;
                }
                field(COLLACC; Rec.COLLACC)
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec.MemberNo)
                {
                    ApplicationArea = Basic;
                }
                field(SNO; Rec.SNO)
                {
                    ApplicationArea = Basic;
                }
                field(FrontBWImage; Rec.FrontBWImage)
                {
                    ApplicationArea = Basic;
                }
                field(FrontGrayScaleImage; Rec.FrontGrayScaleImage)
                {
                    ApplicationArea = Basic;
                }
                field(RearImage; Rec.RearImage)
                {
                    ApplicationArea = Basic;
                }
                field(IsFCY; Rec.IsFCY)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(UploadFile)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    DestinationFile: Text[100];
                begin
                    // DestinationFile := FileMgt.OpenFileDialog('Family Cheque file', '*.J70', UserId + '(*.*)|(*.J70)');

                    Message(DestinationFile);
                    //UPLOADINTOSTREAM('Import','','All Files (*.*)|*.*',DestinationFile,USERID+'(*.*)|(*.J70)');
                end;
            }
        }
    }

    var
        FileMgt: Codeunit "File Management";
}

