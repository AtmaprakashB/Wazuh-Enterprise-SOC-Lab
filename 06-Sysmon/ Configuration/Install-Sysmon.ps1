# =============================================================================
# Microsoft Hybrid SOC Lab
# Sysmon Installation Script
# =============================================================================

$SysmonPath = "C:\Tools\Sysmon\Sysmon64.exe"
$ConfigPath = "C:\Tools\Sysmon\sysmonconfig.xml"

Write-Host ""
Write-Host "========================================"
Write-Host " Installing Microsoft Sysmon"
Write-Host "========================================"
Write-Host ""

if (!(Test-Path $SysmonPath)) {
    Write-Host "[ERROR] Sysmon64.exe not found." -ForegroundColor Red
    exit
}

if (!(Test-Path $ConfigPath)) {
    Write-Host "[ERROR] sysmonconfig.xml not found." -ForegroundColor Red
    exit
}

& $SysmonPath -accepteula -i $ConfigPath

Write-Host ""
Write-Host "Checking Sysmon service..."
Get-Service Sysmon64

Write-Host ""
Write-Host "Installation completed."
