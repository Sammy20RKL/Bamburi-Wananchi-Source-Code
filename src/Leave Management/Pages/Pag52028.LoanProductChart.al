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
            usercontrol(LoanChart; "Loan Chart AddIn")
            {
                ApplicationArea = All;

                trigger ChartClicked(ProductLabel: Text)
                begin
                    LoanChartMgt.DrillDownByName(CopyStr(ProductLabel, 1, 249));
                end;

                trigger ControlReady()
                begin
                    IsChartAddInReady := true;
                    if IsChartDataReady then begin
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
            StatusText := 'Error loading chart: ' + GetLastErrorText()
        else
            StatusText := 'Loan Book — Outstanding Balance & Active Loans per Product';
        NeedsUpdate := false;
    end;

    [TryFunction]
    local procedure TryUpdateChart()
    var
        ChartDataJson: Text;
    begin
        ChartDataJson := LoanChartMgt.GetChartDataJson();
        CurrPage.LoanChart.LoadChart(ChartDataJson);
    end;
}
