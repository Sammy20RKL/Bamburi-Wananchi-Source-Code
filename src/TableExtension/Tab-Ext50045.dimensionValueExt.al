tableextension 50045 "dimensionValueExt" extends "Dimension Value"
{
    fields
    {
        field(51516220; "Overdraft Account"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(51516221; "Overdraft Account Co mmission"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(51516290; "Account Code"; Code[20])
        {
        }
        field(51516291; "Banker Cheque Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(51516292; "Clearing Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(51516293; "No. Series"; Code[20])
        {
        }
        field(51516294; "Local Cheque Charges"; Decimal)
        {
        }
        field(51516295; "Upcountry Cheque Charges"; Decimal)
        {
        }
        field(51516296; "Bounced Cheque Charges"; Decimal)
        {
        }
        field(51516297; "G/L Account Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "G/L Account"."No.";
        }
        field(51516298; Amount; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("G/L Account Filter"),
                                                        "Source No." = field("Dimension Filter"),
                                                        "Global Dimension 2 Code" = const('NAIROBI')));
            FieldClass = FlowField;
        }
        field(51516299; "Dimension Filter"; Code[20])
        {
        }
        field(51516300; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(51516301; "G/L Account No."; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(51516302; "Total Count"; Integer)
        {
        }
        field(51516303; "Total Amount"; Decimal)
        {
        }
        field(51516304; Type; Option)
        {
            OptionCaption = 'Account,Loan,Transactions';
            OptionMembers = Account,Loan,Transactions;
        }
        field(51516305; "Use %"; Boolean)
        {
        }
        field(51516306; "% Of Amount"; Decimal)
        {
        }
    }

    keys
    {
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if CheckIfDimValueUsed then
            Error(Text000, GetCheckDimErr);

        DimValueComb.SetRange("Dimension 1 Code", "Dimension Code");
        DimValueComb.SetRange("Dimension 1 Value Code", Code);
        DimValueComb.DeleteAll(true);

        DimValueComb.Reset;
        DimValueComb.SetRange("Dimension 2 Code", "Dimension Code");
        DimValueComb.SetRange("Dimension 2 Value Code", Code);
        DimValueComb.DeleteAll(true);

        DefaultDim.SetRange("Dimension Code", "Dimension Code");
        DefaultDim.SetRange("Dimension Value Code", Code);
        DefaultDim.DeleteAll(true);

        SelectedDim.SetRange("Dimension Code", "Dimension Code");
        SelectedDim.SetRange("New Dimension Value Code", Code);
        SelectedDim.DeleteAll(true);

        AnalysisSelectedDim.SetRange("Dimension Code", "Dimension Code");
        AnalysisSelectedDim.SetRange("New Dimension Value Code", Code);
        AnalysisSelectedDim.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        TestField("Dimension Code");
        TestField(Code);
        GLSetup.Get;
        "Global Dimension No." := 0;
        if GLSetup."Global Dimension 1 Code" = "Dimension Code" then
            "Global Dimension No." := 1;
        if GLSetup."Global Dimension 2 Code" = "Dimension Code" then
            "Global Dimension No." := 2;

        if CostAccSetup.Get then begin
            CostAccMgt.UpdateCostCenterFromDim(Rec, Rec, 0);
            CostAccMgt.UpdateCostObjectFromDim(Rec, Rec, 0);
        end;
    end;

    trigger OnModify()
    begin
        if "Dimension Code" <> xRec."Dimension Code" then begin
            GLSetup.Get;
            "Global Dimension No." := 0;
            if GLSetup."Global Dimension 1 Code" = "Dimension Code" then
                "Global Dimension No." := 1;
            if GLSetup."Global Dimension 2 Code" = "Dimension Code" then
                "Global Dimension No." := 2;
        end;
        if CostAccSetup.Get then begin
            CostAccMgt.UpdateCostCenterFromDim(Rec, xRec, 1);
            CostAccMgt.UpdateCostObjectFromDim(Rec, xRec, 1);
        end;
    end;

    trigger OnRename()
    begin
        RenameBudgEntryDim;
        RenameAnalysisViewEntryDim;
        RenameItemBudgEntryDim;
        RenameItemAnalysisViewEntryDim;

        if CostAccSetup.Get then begin
            CostAccMgt.UpdateCostCenterFromDim(Rec, xRec, 3);
            CostAccMgt.UpdateCostObjectFromDim(Rec, xRec, 3);
        end;
    end;

    var
        Text000: label '%1\You cannot delete it.';
        Text002: label '(CONFLICT)';
        Text003: label '%1 can not be (CONFLICT). This name is used internally by the system.';
        Text004: label '%1\You cannot change the type.';
        Text005: label 'This dimension value has been used in posted or budget entries.';
        DimSetEntry: Record "Dimension Set Entry";
        DimValueComb: Record "Dimension Value Combination";
        DefaultDim: Record "Default Dimension";
        SelectedDim: Record "Selected Dimension";
        AnalysisSelectedDim: Record "Analysis Selected Dimension";
        GLSetup: Record "General Ledger Setup";
        CostAccSetup: Record "Cost Accounting Setup";
        CostAccMgt: Codeunit "Cost Account Mgt";
        Text006: label 'You cannot change the value of %1.';


    procedure CheckIfDimValueUsed(): Boolean
    begin
        DimSetEntry.SetCurrentkey("Dimension Value ID");
        DimSetEntry.SetRange("Dimension Value ID", "Dimension Value ID");
        exit(not DimSetEntry.IsEmpty);
    end;

    local procedure GetCheckDimErr(): Text[250]
    begin
        exit(Text005);
    end;

    local procedure RenameBudgEntryDim()
    var
        GLBudget: Record "G/L Budget Name";
        GLBudgetEntry: Record "G/L Budget Entry";
        GLBudgetEntry2: Record "G/L Budget Entry";
        BudgDimNo: Integer;
    begin
        GLBudget.LockTable;
        if GLBudget.Find('-') then
            repeat
            until GLBudget.Next = 0;
        for BudgDimNo := 1 to 4 do begin
            case true of
                BudgDimNo = 1:
                    GLBudget.SetRange("Budget Dimension 1 Code", "Dimension Code");
                BudgDimNo = 2:
                    GLBudget.SetRange("Budget Dimension 2 Code", "Dimension Code");
                BudgDimNo = 3:
                    GLBudget.SetRange("Budget Dimension 3 Code", "Dimension Code");
                BudgDimNo = 4:
                    GLBudget.SetRange("Budget Dimension 4 Code", "Dimension Code");
            end;
            if GLBudget.Find('-') then begin
                GLBudgetEntry.SetCurrentkey("Budget Name", "G/L Account No.", "Business Unit Code", "Global Dimension 1 Code");
                repeat
                    GLBudgetEntry.SetRange("Budget Name", GLBudget.Name);
                    case true of
                        BudgDimNo = 1:
                            GLBudgetEntry.SetRange("Budget Dimension 1 Code", xRec.Code);
                        BudgDimNo = 2:
                            GLBudgetEntry.SetRange("Budget Dimension 2 Code", xRec.Code);
                        BudgDimNo = 3:
                            GLBudgetEntry.SetRange("Budget Dimension 3 Code", xRec.Code);
                        BudgDimNo = 4:
                            GLBudgetEntry.SetRange("Budget Dimension 4 Code", xRec.Code);
                    end;
                    if GLBudgetEntry.Find('-') then
                        repeat
                            GLBudgetEntry2 := GLBudgetEntry;
                            case true of
                                BudgDimNo = 1:
                                    GLBudgetEntry2."Budget Dimension 1 Code" := Code;
                                BudgDimNo = 2:
                                    GLBudgetEntry2."Budget Dimension 2 Code" := Code;
                                BudgDimNo = 3:
                                    GLBudgetEntry2."Budget Dimension 3 Code" := Code;
                                BudgDimNo = 4:
                                    GLBudgetEntry2."Budget Dimension 4 Code" := Code;
                            end;
                            GLBudgetEntry2.Modify;
                        until GLBudgetEntry.Next = 0;
                    GLBudgetEntry.Reset;
                until GLBudget.Next = 0;
            end;
            GLBudget.Reset;
        end;
    end;

    local procedure RenameAnalysisViewEntryDim()
    var
        AnalysisView: Record "Analysis View";
        AnalysisViewEntry: Record "Analysis View Entry";
        AnalysisViewEntry2: Record "Analysis View Entry";
        AnalysisViewBudgEntry: Record "Analysis View Budget Entry";
        AnalysisViewBudgEntry2: Record "Analysis View Budget Entry";
        DimensionNo: Integer;
    begin
        AnalysisView.LockTable;
        if AnalysisView.Find('-') then
            repeat
            until AnalysisView.Next = 0;

        for DimensionNo := 1 to 4 do begin
            case true of
                DimensionNo = 1:
                    AnalysisView.SetRange("Dimension 1 Code", "Dimension Code");
                DimensionNo = 2:
                    AnalysisView.SetRange("Dimension 2 Code", "Dimension Code");
                DimensionNo = 3:
                    AnalysisView.SetRange("Dimension 3 Code", "Dimension Code");
                DimensionNo = 4:
                    AnalysisView.SetRange("Dimension 4 Code", "Dimension Code");
            end;
            if AnalysisView.Find('-') then
                repeat
                    AnalysisViewEntry.SetRange("Analysis View Code", AnalysisView.Code);
                    AnalysisViewBudgEntry.SetRange("Analysis View Code", AnalysisView.Code);
                    case true of
                        DimensionNo = 1:
                            begin
                                AnalysisViewEntry.SetRange("Dimension 1 Value Code", xRec.Code);
                                AnalysisViewBudgEntry.SetRange("Dimension 1 Value Code", xRec.Code);
                            end;
                        DimensionNo = 2:
                            begin
                                AnalysisViewEntry.SetRange("Dimension 2 Value Code", xRec.Code);
                                AnalysisViewBudgEntry.SetRange("Dimension 2 Value Code", xRec.Code);
                            end;
                        DimensionNo = 3:
                            begin
                                AnalysisViewEntry.SetRange("Dimension 3 Value Code", xRec.Code);
                                AnalysisViewBudgEntry.SetRange("Dimension 3 Value Code", xRec.Code);
                            end;
                        DimensionNo = 4:
                            begin
                                AnalysisViewEntry.SetRange("Dimension 4 Value Code", xRec.Code);
                                AnalysisViewBudgEntry.SetRange("Dimension 4 Value Code", xRec.Code);
                            end;
                    end;
                    if AnalysisViewEntry.Find('-') then
                        repeat
                            AnalysisViewEntry2 := AnalysisViewEntry;
                            case true of
                                DimensionNo = 1:
                                    AnalysisViewEntry2."Dimension 1 Value Code" := Code;
                                DimensionNo = 2:
                                    AnalysisViewEntry2."Dimension 2 Value Code" := Code;
                                DimensionNo = 3:
                                    AnalysisViewEntry2."Dimension 3 Value Code" := Code;
                                DimensionNo = 4:
                                    AnalysisViewEntry2."Dimension 4 Value Code" := Code;
                            end;
                            AnalysisViewEntry.Delete;
                            AnalysisViewEntry2.Insert;
                        until AnalysisViewEntry.Next = 0;
                    AnalysisViewEntry.Reset;
                    if AnalysisViewBudgEntry.Find('-') then
                        repeat
                            AnalysisViewBudgEntry2 := AnalysisViewBudgEntry;
                            case true of
                                DimensionNo = 1:
                                    AnalysisViewBudgEntry2."Dimension 1 Value Code" := Code;
                                DimensionNo = 2:
                                    AnalysisViewBudgEntry2."Dimension 2 Value Code" := Code;
                                DimensionNo = 3:
                                    AnalysisViewBudgEntry2."Dimension 3 Value Code" := Code;
                                DimensionNo = 4:
                                    AnalysisViewBudgEntry2."Dimension 4 Value Code" := Code;
                            end;
                            AnalysisViewBudgEntry.Delete;
                            AnalysisViewBudgEntry2.Insert;
                        until AnalysisViewBudgEntry.Next = 0;
                    AnalysisViewBudgEntry.Reset;
                until AnalysisView.Next = 0;
            AnalysisView.Reset;
        end;
    end;

    local procedure RenameItemBudgEntryDim()
    var
        ItemBudget: Record "Item Budget Name";
        ItemBudgetEntry: Record "Item Budget Entry";
        ItemBudgetEntry2: Record "Item Budget Entry";
        BudgDimNo: Integer;
    begin
        ItemBudget.LockTable;
        if ItemBudget.Find('-') then
            repeat
            until ItemBudget.Next = 0;

        for BudgDimNo := 1 to 3 do begin
            case true of
                BudgDimNo = 1:
                    ItemBudget.SetRange("Budget Dimension 1 Code", "Dimension Code");
                BudgDimNo = 2:
                    ItemBudget.SetRange("Budget Dimension 2 Code", "Dimension Code");
                BudgDimNo = 3:
                    ItemBudget.SetRange("Budget Dimension 3 Code", "Dimension Code");
            end;
            if ItemBudget.Find('-') then begin
                ItemBudgetEntry.SetCurrentkey(
                  "Analysis Area", "Budget Name", "Item No.", "Source Type", "Source No.", Date, "Location Code", "Global Dimension 1 Code");
                repeat
                    ItemBudgetEntry.SetRange("Analysis Area", ItemBudget."Analysis Area");
                    ItemBudgetEntry.SetRange("Budget Name", ItemBudget.Name);
                    case true of
                        BudgDimNo = 1:
                            ItemBudgetEntry.SetRange("Budget Dimension 1 Code", xRec.Code);
                        BudgDimNo = 2:
                            ItemBudgetEntry.SetRange("Budget Dimension 2 Code", xRec.Code);
                        BudgDimNo = 3:
                            ItemBudgetEntry.SetRange("Budget Dimension 3 Code", xRec.Code);
                    end;
                    if ItemBudgetEntry.Find('-') then
                        repeat
                            ItemBudgetEntry2 := ItemBudgetEntry;
                            case true of
                                BudgDimNo = 1:
                                    ItemBudgetEntry2."Budget Dimension 1 Code" := Code;
                                BudgDimNo = 2:
                                    ItemBudgetEntry2."Budget Dimension 2 Code" := Code;
                                BudgDimNo = 3:
                                    ItemBudgetEntry2."Budget Dimension 3 Code" := Code;
                            end;
                            ItemBudgetEntry2.Modify;
                        until ItemBudgetEntry.Next = 0;
                    ItemBudgetEntry.Reset;
                until ItemBudget.Next = 0;
            end;
            ItemBudget.Reset;
        end;
    end;

    local procedure RenameItemAnalysisViewEntryDim()
    var
        ItemAnalysisView: Record "Item Analysis View";
        ItemAnalysisViewEntry: Record "Item Analysis View Entry";
        ItemAnalysisViewEntry2: Record "Item Analysis View Entry";
        ItemAnalysisViewBudgEntry: Record "Item Analysis View Budg. Entry";
        ItemAnalysisViewBudgEntry2: Record "Item Analysis View Budg. Entry";
        DimensionNo: Integer;
    begin
        ItemAnalysisView.LockTable;
        if ItemAnalysisView.Find('-') then
            repeat
            until ItemAnalysisView.Next = 0;

        for DimensionNo := 1 to 3 do begin
            case true of
                DimensionNo = 1:
                    ItemAnalysisView.SetRange("Dimension 1 Code", "Dimension Code");
                DimensionNo = 2:
                    ItemAnalysisView.SetRange("Dimension 2 Code", "Dimension Code");
                DimensionNo = 3:
                    ItemAnalysisView.SetRange("Dimension 3 Code", "Dimension Code");
            end;
            if ItemAnalysisView.Find('-') then
                repeat
                    ItemAnalysisViewEntry.SetRange("Analysis Area", ItemAnalysisView."Analysis Area");
                    ItemAnalysisViewEntry.SetRange("Analysis View Code", ItemAnalysisView.Code);
                    ItemAnalysisViewBudgEntry.SetRange("Analysis Area", ItemAnalysisView."Analysis Area");
                    ItemAnalysisViewBudgEntry.SetRange("Analysis View Code", ItemAnalysisView.Code);
                    case true of
                        DimensionNo = 1:
                            begin
                                ItemAnalysisViewEntry.SetRange("Dimension 1 Value Code", xRec.Code);
                                ItemAnalysisViewBudgEntry.SetRange("Dimension 1 Value Code", xRec.Code);
                            end;
                        DimensionNo = 2:
                            begin
                                ItemAnalysisViewEntry.SetRange("Dimension 2 Value Code", xRec.Code);
                                ItemAnalysisViewBudgEntry.SetRange("Dimension 2 Value Code", xRec.Code);
                            end;
                        DimensionNo = 3:
                            begin
                                ItemAnalysisViewEntry.SetRange("Dimension 3 Value Code", xRec.Code);
                                ItemAnalysisViewBudgEntry.SetRange("Dimension 3 Value Code", xRec.Code);
                            end;
                    end;
                    if ItemAnalysisViewEntry.Find('-') then
                        repeat
                            ItemAnalysisViewEntry2 := ItemAnalysisViewEntry;
                            case true of
                                DimensionNo = 1:
                                    ItemAnalysisViewEntry2."Dimension 1 Value Code" := Code;
                                DimensionNo = 2:
                                    ItemAnalysisViewEntry2."Dimension 2 Value Code" := Code;
                                DimensionNo = 3:
                                    ItemAnalysisViewEntry2."Dimension 3 Value Code" := Code;
                            end;
                            ItemAnalysisViewEntry.Delete;
                            ItemAnalysisViewEntry2.Insert;
                        until ItemAnalysisViewEntry.Next = 0;
                    ItemAnalysisViewEntry.Reset;
                    if ItemAnalysisViewBudgEntry.Find('-') then
                        repeat
                            ItemAnalysisViewBudgEntry2 := ItemAnalysisViewBudgEntry;
                            case true of
                                DimensionNo = 1:
                                    ItemAnalysisViewBudgEntry2."Dimension 1 Value Code" := Code;
                                DimensionNo = 2:
                                    ItemAnalysisViewBudgEntry2."Dimension 2 Value Code" := Code;
                                DimensionNo = 3:
                                    ItemAnalysisViewBudgEntry2."Dimension 3 Value Code" := Code;
                            end;
                            ItemAnalysisViewBudgEntry.Delete;
                            ItemAnalysisViewBudgEntry2.Insert;
                        until ItemAnalysisViewBudgEntry.Next = 0;
                    ItemAnalysisViewBudgEntry.Reset;
                until ItemAnalysisView.Next = 0;
            ItemAnalysisView.Reset;
        end;
    end;


    procedure LookUpDimFilter(Dim: Code[20]; var Text: Text[1024]): Boolean
    var
        DimVal: Record "Dimension Value";
        DimValList: Page "Dimension Value List";
    begin
        if Dim = '' then
            exit(false);
        DimValList.LookupMode(true);
        DimVal.SetRange("Dimension Code", Dim);
        DimValList.SetTableview(DimVal);
        if DimValList.RunModal = Action::LookupOK then begin
            Text := DimValList.GetSelectionFilter;
            exit(true);
        end;
        exit(false)
    end;


    procedure LookupDimValue(DimCode: Code[20]; var DimValueCode: Code[20])
    var
        DimValue: Record "Dimension Value";
        DimValuesList: Page "Dimension Values";
    begin
        DimValue.SetRange("Dimension Code", DimCode);
        DimValuesList.LookupMode := true;
        DimValuesList.SetTableview(DimValue);
        if DimValue.Get(DimCode, DimValueCode) then
            DimValuesList.SetRecord(DimValue);
        if DimValuesList.RunModal = Action::LookupOK then begin
            DimValuesList.GetRecord(DimValue);
            DimValueCode := DimValue.Code;
        end;
    end;
}