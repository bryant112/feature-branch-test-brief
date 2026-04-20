param(
    [Parameter(Mandatory = $true)]
    [string]$HtmlPath,

    [Parameter(Mandatory = $true)]
    [string]$PdfPath
)

$browserCandidates = @(
    'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe',
    'C:\Program Files\Microsoft\Edge\Application\msedge.exe',
    'C:\Program Files\Google\Chrome\Application\chrome.exe',
    'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
)

$browser = $browserCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $browser) {
    throw 'No supported browser found. Install Microsoft Edge or Google Chrome.'
}

$htmlFullPath = (Resolve-Path -LiteralPath $HtmlPath).Path
$pdfDirectory = Split-Path -Parent $PdfPath
if (-not [string]::IsNullOrWhiteSpace($pdfDirectory)) {
    New-Item -ItemType Directory -Force -Path $pdfDirectory | Out-Null
}

$pdfFullPath = [System.IO.Path]::GetFullPath($PdfPath)
if (Test-Path $pdfFullPath) {
    Remove-Item $pdfFullPath -Force
}

$htmlUri = 'file:///' + ($htmlFullPath -replace '\\', '/')
& $browser '--headless' '--disable-gpu' '--no-pdf-header-footer' "--print-to-pdf=$pdfFullPath" $htmlUri | Out-Null

if (-not (Test-Path $pdfFullPath)) {
    throw 'Browser PDF render did not produce an output file.'
}

$pdfInfo = Get-Item $pdfFullPath
if ($pdfInfo.Length -le 0) {
    throw 'Browser PDF render produced an empty PDF file.'
}
