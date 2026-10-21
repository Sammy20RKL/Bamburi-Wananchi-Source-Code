function lpcEscapeHtml(value) {
    var div = document.createElement('div');
    div.textContent = value === null || value === undefined ? '' : String(value);
    return div.innerHTML;
}

function LoadChart(dataJson) {
    var data = JSON.parse(dataJson);

    if (typeof lpcEnsureLayout === 'function') lpcEnsureLayout();

    var kpis = document.getElementById('lpc-kpis');
    var bars = document.getElementById('lpc-bars');
    if (!kpis || !bars) return;

    kpis.innerHTML =
        '<div class="lpc-kpi"><span class="lpc-kpi-label">Outstanding Balance</span>' +
        '<span class="lpc-kpi-value">' + lpcEscapeHtml(data.totalBalanceLabel) + '</span></div>';

    var items = data.items || [];
    var rowsHtml = '';
    for (var i = 0; i < items.length; i++) {
        var item = items[i];
        var selectedClass = i === 0 ? ' lpc-selected' : '';
        rowsHtml +=
            '<div class="lpc-bar-row' + selectedClass + '" data-label="' + lpcEscapeHtml(item.label) + '">' +
                '<span class="lpc-bar-label">' + lpcEscapeHtml(item.label) + '</span>' +
                '<div class="lpc-bar-track"><div class="lpc-bar-fill" style="width:' + item.pct + '%"></div></div>' +
                '<span class="lpc-bar-value">' + lpcEscapeHtml(item.valueLabel) + '</span>' +
            '</div>';
    }
    bars.innerHTML = rowsHtml || '<div class="lpc-empty">No posted loans yet.</div>';

    var rows = bars.querySelectorAll('.lpc-bar-row');
    for (var r = 0; r < rows.length; r++) {
        rows[r].addEventListener('click', function () {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ChartClicked', [this.getAttribute('data-label')]);
        });
    }
}
