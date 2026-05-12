var loanChart = null;
var productCodes = [];

function LoadChart(dataJson) {
    var data = JSON.parse(dataJson);
    productCodes = data.codes;

    var canvas = document.getElementById('loanCanvas');
    if (!canvas) return;

    // Destroy existing chart before redraw
    if (loanChart) {
        loanChart.destroy();
        loanChart = null;
    }

    var ctx = canvas.getContext('2d');

    loanChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: data.labels,
            datasets: [
                {
                    label: 'Outstanding Balance',
                    data: data.balances,
                    backgroundColor: 'rgba(32, 178, 170, 0.85)',  // Sea Green
                    borderColor: 'rgba(32, 178, 170, 1)',
                    borderWidth: 1,
                    borderRadius: 4
                },
                {
                    label: 'Active Loans',
                    data: data.counts,
                    backgroundColor: 'rgba(32, 178, 120, 0.6)',   // Lighter Sea Green
                    borderColor: 'rgba(32, 178, 120, 1)',
                    borderWidth: 1,
                    borderRadius: 4
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'top' },
                tooltip: {
                    callbacks: {
                        label: function (context) {
                            if (context.datasetIndex === 0)
                                return ' Balance: ' +
                                    Number(context.raw).toLocaleString();
                            return ' Loans: ' + context.raw;
                        }
                    }
                }
            },
            onClick: function (evt, elements) {
                if (elements.length > 0) {
                    var index = elements[0].index;
                    var code = productCodes[index];
                    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
                        'ChartClicked', [code]);
                }
            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
}