page 52028 "Loan Products Chart"
{
    Caption = 'Loan Products Performance';
    PageType = CardPart;
    SourceTable = "Business Chart Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            field(StatusText; StatusText)
            {
                ApplicationArea = All;
                Caption = 'Status Text';
                Editable = false;
                ShowCaption = false;
            }
            usercontrol(BusinessChart; BusinessChart)
            {
                ApplicationArea = All;

                trigger DataPointClicked(Point: JsonObject)
                var
                    Token: JsonToken;
                    ValueArray: JsonArray;
                    XValueString: Text[249];
                    YValue: Decimal;
                    MeasureName: Text[249];
                begin
                    // Parse JSON directly — never touch the DotNet DataTable
                    if Point.Get('Measures', Token) then begin
                        ValueArray := Token.AsArray();
                        ValueArray.Get(0, Token);
                        MeasureName := CopyStr(Token.AsValue().AsText(), 1, 249);
                    end;

                    if Point.Get('XValueString', Token) then
                        XValueString := CopyStr(Token.AsValue().AsText(), 1, 249);

                    if Point.Get('YValues', Token) then begin
                        ValueArray := Token.AsArray();
                        ValueArray.Get(0, Token);
                        YValue := Token.AsValue().AsDecimal();
                    end;

                    // Drill down using X label directly — no DataTable needed
                    LoanChartMgt.DrillDownByName(XValueString);
                end;

                trigger DataPointDoubleClicked(Point: JsonObject)
                begin
                end;

                trigger AddInReady()
                begin
                    IsChartAddInReady := true;
                    if IsChartDataReady then begin
                        NeedsUpdate := true;
                        UpdateChart();
                    end;
                end;

                trigger Refresh()
                begin
                    if IsChartAddInReady then begin
                        NeedsUpdate := true;
                        UpdateChart();
                    end;
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RefreshChart)
            {
                ApplicationArea = All;
                Caption = 'Refresh';
                Image = Refresh;
                ToolTip = 'Reload the latest loan data.';

                trigger OnAction()
                begin
                    IsChartAddInReady := true;
                    IsChartDataReady := true;
                    NeedsUpdate := true;
                    UpdateChart();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IsChartAddInReady := false;
        IsChartDataReady := false;
        NeedsUpdate := false;
        // Initialize the source record once here
        if not Rec.Get(0) then begin
            Rec.Init();
            Rec.ID := 0;
            Rec.Insert();
        end;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        if not IsChartDataReady then begin
            IsChartDataReady := true;
            NeedsUpdate := true;
        end;
        if IsChartAddInReady then
            UpdateChart();
        exit(true);
    end;

    var
        LoanChartMgt: Codeunit "Loan Products Chart Mgt.";
        StatusText: Text;
        NeedsUpdate: Boolean;
        IsChartAddInReady: Boolean;
        IsChartDataReady: Boolean;

    local procedure UpdateChart()
    begin
        if not NeedsUpdate then
            exit;
        if not IsChartAddInReady then
            exit;
        if not IsChartDataReady then
            exit;
        if not TryUpdateChart() then
            StatusText := 'Error loading chart. Please refresh.'
        else
            StatusText := 'Loan Book — Outstanding Balance & Active Loans per Product';
        NeedsUpdate := false;
    end;

    [TryFunction]
    local procedure TryUpdateChart()
    begin
        // UpdateData loads into Rec and keeps DotNet object alive for drill-down
        LoanChartMgt.UpdateData(Rec);
        Rec.UpdateChart(CurrPage.BusinessChart);
    end;
}