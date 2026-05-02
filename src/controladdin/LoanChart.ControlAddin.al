controladdin "Loan Chart AddIn"
{
    RequestedHeight = 300;
    MinimumHeight = 200;
    RequestedWidth = 700;
    VerticalStretch = true;
    HorizontalStretch = true;

    Scripts = 'https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js',
              'src/controladdin/LoanChart/LoanChart.js';

    StartupScript = 'src/controladdin/LoanChart/startup.js';

    StyleSheets = 'src/controladdin/LoanChart/LoanChart.css';

    procedure LoadChart(DataJson: Text);
    event ChartClicked(ProductCode: Text);
    event ControlReady();
}