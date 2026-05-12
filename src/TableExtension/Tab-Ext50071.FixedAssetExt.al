tableextension 50071 "FixedAssetExt" extends "Fixed Asset"
{
    fields
    {

        field(51516830; "Project No."; Code[20])
        {
            TableRelation = "Fixed Asset"."No." where("Project Asset" = const(true));
        }
        field(51516831; "Project Name"; Text[50])
        {
        }
        field(51516832; "Project Acreage"; Decimal)
        {
        }
        field(51516833; "Property Acreage"; Decimal)
        {
        }
        field(51516834; Invoiced; Boolean)
        {
        }
        field(51516835; "Invoice No"; Code[20])
        {
        }
        field(51516836; "Invoiced To"; Text[50])
        {
        }
        field(51516837; "Property Type"; Code[20])
        {
        }
        field(51516838; Issued; Boolean)
        {
        }
        field(51516839; "Issured To"; Code[20])
        {
        }
        field(51516840; "Asset Type"; Option)
        {
            OptionCaption = ' ,Normal,Property';
            OptionMembers = " ",Normal,Property;
        }
        field(51516841; "Useful Acreage"; Decimal)
        {
        }
        field(51516842; "Project Asset"; Boolean)
        {
        }
        field(51516843; "Property Asset"; Boolean)
        {
        }
        field(51516844; "Project Plan"; Blob)
        {
        }
        field(51516845; Surveyor; Code[50])
        {
        }
        field(51516846; "Certified By"; Code[50])
        {
        }
        field(51516847; "Total Property Acres"; Decimal)
        {
            CalcFormula = sum("Fixed Asset"."Property Acreage" where("Project No." = field("No."),
                                                                      "Property Asset" = const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(51516848; "Initial Acq Cost"; Decimal)
        {
            Editable = false;
        }
        field(51516849; Closed; Boolean)
        {
            Editable = false;
        }
        field(51516850; "Closed By"; Code[20])
        {
            Editable = false;
        }
        field(51516851; "Close Date"; Date)
        {
            Editable = false;
        }
        field(51516852; "Close Time"; Time)
        {
            Editable = false;
        }
        field(51516853; Receipted; Boolean)
        {
            Editable = false;
        }
        field(51516854; "Receipt No"; Code[20])
        {
            Editable = false;
        }
        field(51516855; "Customer No"; Code[20])
        {
            Editable = false;
        }
        field(51516856; "Customer Name"; Text[50])
        {
            Editable = false;
        }
        field(51516857; "Selling Price"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Selling Price" <> 0) and ("Customer Balance" <> 0) then begin
                    "Customer Balance" := "Selling Price";
                end;
                if "Customer Balance" < 0 then begin
                    "Customer Balance" := "Customer Balance" + "Selling Price";
                end;
            end;
        }
        field(51516858; "Customer Balance"; Decimal)
        {
        }
        field(51516859; "Title No"; Code[20])
        {

            trigger OnValidate()
            begin

            end;
        }
        field(51516860; Amount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("No."),
                                                                        "FA Posting Date" = field("FA Posting Date Filter"),
                                                                         Reversed = const(false)));
        }
    }


    trigger OnDelete()
    begin
        LockTable;
        FADeprBook.LockTable;
        MainAssetComp.LockTable;
        InsCoverageLedgEntry.LockTable;
        if "Main Asset/Component" = "main asset/component"::"Main Asset" then
            Error(Text000);
        FAMoveEntries.MoveFAInsuranceEntries("No.");
        FADeprBook.SetCurrentkey("FA No.");
        FADeprBook.SetRange("FA No.", "No.");
        FADeprBook.DeleteAll(true);
        if FADeprBook.FindFirst then
            Error(Text001, TableCaption, "No.");

        MainAssetComp.SetCurrentkey("FA No.");
        MainAssetComp.SetRange("FA No.", "No.");
        MainAssetComp.DeleteAll;
        if "Main Asset/Component" = "main asset/component"::Component then begin
            MainAssetComp.Reset;
            MainAssetComp.SetRange("Main Asset No.", "Component of Main Asset");
            MainAssetComp.SetRange("FA No.", '');
            MainAssetComp.DeleteAll;
            MainAssetComp.SetRange("FA No.");
            if not MainAssetComp.FindFirst then begin
                FA.Get("Component of Main Asset");
                FA."Main Asset/Component" := FA."main asset/component"::" ";
                FA."Component of Main Asset" := '';
                FA.Modify;
            end;
        end;

        MaintenanceRegistration.SetRange("FA No.", "No.");
        MaintenanceRegistration.DeleteAll;

        CommentLine.SetRange("Table Name", CommentLine."table name"::"Fixed Asset");
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll;

        //  DimMgt.DeleteDefaultDim(Database::"Fixed Asset","No.");
    end;

    trigger OnInsert()
    begin
        // if "No." = '' then begin
        //   FASetup.Get;
        //   FASetup.TestField("Fixed Asset Nos.");
        //   NoSeriesMgt.InitSeries(FASetup."Fixed Asset Nos.",xRec."No. Series",0D,"No.","No. Series");
        // end;

        "Main Asset/Component" := "main asset/component"::" ";
        "Component of Main Asset" := '';

        // DimMgt.UpdateDefaultDim(
        //   Database::"Fixed Asset","No.",
        //   "Global Dimension 1 Code","Global Dimension 2 Code");
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    var
        Text000: label 'A main asset cannot be deleted.';
        Text001: label 'You cannot delete %1 %2 because it has associated depreciation books.';
        CommentLine: Record "Comment Line";
        FA: Record "Fixed Asset";
        FASetup: Record "FA Setup";
        MaintenanceRegistration: Record "Maintenance Registration";
        FADeprBook: Record "FA Depreciation Book";
        MainAssetComp: Record "Main Asset Component";
        InsCoverageLedgEntry: Record "Ins. Coverage Ledger Entry";
        FAMoveEntries: Codeunit "FA MoveEntries";


    procedure AssistEdit(OldFA: Record "Fixed Asset"): Boolean
    begin
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        // DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        // DimMgt.SaveDefaultDim(Database::"Fixed Asset","No.",FieldNumber,ShortcutDimCode);
        // Modify(true);
    end;
}
