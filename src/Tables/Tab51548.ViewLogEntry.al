#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51548 "View Log Entry"
{
    Caption = 'Change Log Entry';
    DrillDownPageID = "Change Log Entries";
    LookupPageID = "Change Log Entries";

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; Date; Date)
        {
            Caption = 'Date and Time';
        }
        field(3; Time; Time)
        {
            Caption = 'Time';
        }
        field(4; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "Polytech User Management";
            begin
                UserMgt.LookupUserID("User ID");
            end;
        }
        field(5; "Table No."; Integer)
        {
            Caption = 'Table No.';
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
        }
        field(6; "Table Caption"; Text[250])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Table), "Object ID" = field("Table No.")));
            Caption = 'Table Caption';
            FieldClass = FlowField;
        }
        field(22; "Record ID"; RecordID)
        {
            Caption = 'Record ID';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Table No.")
        {
        }
        key(Key3; "Table No.", Date)
        {
        }
    }

    fieldgroups
    {
    }


    procedure GetPrimaryKeyFriendlyName(): Text[250]
    var
        RecRef: RecordRef;
        FriendlyName: Text[250];
        p: Integer;
    begin


        FriendlyName := DelChr(FriendlyName, '=', '()');
        p := StrPos(FriendlyName, 'CONST');
        while p > 0 do begin
            FriendlyName := DelStr(FriendlyName, p, 5);
            p := StrPos(FriendlyName, 'CONST');
        end;
        exit(FriendlyName);
    end;


    procedure GetLocalOldValue(): Text
    begin
        // exit(GetLocalValue("Old Value"));
    end;


    procedure GetLocalNewValue(): Text
    begin
        // exit(GetLocalValue("New Value"));
    end;

    local procedure GetLocalValue(Value: Text): Text
    var
        ChangeLogManagement: Codeunit "Change Log Management";
        RecordRef: RecordRef;
        FieldRef: FieldRef;
        HasCultureNeutralValues: Boolean;
    begin
        // The culture neutral storage format was added simultaneously with the Record ID field
        HasCultureNeutralValues := Format("Record ID") <> '';

        if (Value <> '') and HasCultureNeutralValues then begin
            RecordRef.Open("Table No.");
            if ChangeLogManagement.EvaluateTextToFieldRef(Value, FieldRef) then
                exit(Format(FieldRef.Value, 0, 1));
        end;

        exit(Value);
    end;
}

