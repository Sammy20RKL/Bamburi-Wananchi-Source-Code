xmlport 50107 "Bulk SMS Phones"
{
    Format = VariableText;
    Direction = Import;

    schema
    {
        textelement(Root)
        {
            tableelement(BulkSMSLines; "Bulk SMS Lines")
            {
                AutoSave = false;

                fieldelement(TelephoneNo; BulkSMSLines.Code)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    if StrLen(BulkSMSLines.Code) = 9 then
                        BulkSMSLines.Code := '0' + BulkSMSLines.Code;

                    BulkSMSLines.No := BatchNo;
                    BulkSMSLines.Description := '';
                    if BulkSMSLines.Code <> '' then
                        if not BulkSMSLines.Get(BatchNo, BulkSMSLines.Code) then begin
                            BulkSMSLines.No := BatchNo;
                            BulkSMSLines.Insert;
                        end;
                end;
            }
        }
    }

    var
        BatchNo: Code[20];

    procedure SetBatchNo(pBatchNo: Code[20])
    begin
        BatchNo := pBatchNo;
    end;
}