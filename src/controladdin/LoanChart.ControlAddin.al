controladdin "Loan Chart AddIn"
{
    RequestedHeight = 320;
    MinimumHeight = 260;
    RequestedWidth = 700;
    VerticalStretch = true;
    HorizontalStretch = true;

    Scripts = 'src/controladdin/LoanChart/LoanChart.js';

    StartupScript = 'src/controladdin/LoanChart/startup.js';

    StyleSheets = 'src/controladdin/LoanChart/LoanChart.css';

    procedure LoadChart(DataJson: Text);
    event ChartClicked(ProductLabel: Text);
    event ControlReady();
}
