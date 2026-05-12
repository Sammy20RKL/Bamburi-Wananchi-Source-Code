#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50092 "DO Payment Credit Card Number"
{
    Caption = 'DO Payment Credit Card Number';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "DO Payment Credit Card"."No.";
        }
        field(2; Data; Blob)
        {
            Caption = 'Data';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
    // DOEncryptionMgt: Codeunit "DO Encryption Mgt.";


    procedure SetData(Value: Text[1024])
    var
        DataStream: OutStream;
        DataText: BigText;
    begin
        // Clear(Data);
        // DataText.AddText(DOEncryptionMgt.Encrypt(Value));
        // Data.CreateOutstream(DataStream);
        // DataText.Write(DataStream);
    end;


    procedure GetData() Value: Text[1024]
    var
        DataStream: InStream;
        DataText: BigText;
    begin
        // Value := '';
        // CalcFields(Data);
        // if Data.Hasvalue then begin
        //   Data.CreateInstream(DataStream);
        //   DataText.Read(DataStream);
        //   DataText.GetSubText(Value,1);
        // end;
        // exit(DOEncryptionMgt.Decrypt(Value));
    end;
}

