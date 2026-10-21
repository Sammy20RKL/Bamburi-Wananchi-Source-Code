function lpcEnsureLayout() {
    if (document.getElementById('lpc-root')) return;

    var root = document.createElement('div');
    root.id = 'lpc-root';
    root.className = 'lpc-card';

    var kpis = document.createElement('div');
    kpis.id = 'lpc-kpis';
    kpis.className = 'lpc-kpis';
    root.appendChild(kpis);

    var bars = document.createElement('div');
    bars.id = 'lpc-bars';
    bars.className = 'lpc-bars';
    root.appendChild(bars);

    document.body.appendChild(root);
}

window.onload = function () {
    lpcEnsureLayout();
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlReady', []);
};
