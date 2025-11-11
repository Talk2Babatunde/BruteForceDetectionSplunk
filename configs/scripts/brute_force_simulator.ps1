<#
.brief
 PowerShell simulator to generate repeated failed interactive logon attempts (EventID 4625).
 Usage: Run as Administrator on a Windows test VM:
  .\brute_force_simulator.ps1 -User 'BadUser' -Attempts 20 -DelayMs 500

#>

param(
    [string]$User = "BadUser",
    [int]$Attempts = 20,
    [int]$DelayMs = 500
)

Write-Host "Starting brute-force simulator: user=$User attempts=$Attempts delay=${DelayMs}ms" -ForegroundColor Cyan

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class WinLogon {
    [DllImport("advapi32.dll", SetLastError=true, CharSet=CharSet.Unicode)]
    public static extern bool LogonUser(string lpszUsername, string lpszDomain, string lpszPassword, int dwLogonType, int dwLogonProvider, out IntPtr phToken);
}
"@

$domain = $env:COMPUTERNAME
$badPass = "WrongPassword123"  # test password only

for ($i=1; $i -le $Attempts; $i++) {
    $token = [IntPtr]::Zero
    $success = [WinLogon]::LogonUser($User, $domain, $badPass, 2, 3, [ref]$token)
    if ($success) {
        Write-Host "Unexpected success on attempt $i (this should not happen in a simulated bad credential scenario)" -ForegroundColor Yellow
        if ($token -ne [IntPtr]::Zero) {
            [System.Runtime.InteropServices.Marshal]::FreeHGlobal($token)
        }
    } else {
        Write-Host "Attempt $i: failed (expected)" -ForegroundColor Gray
    }
    Start-Sleep -Milliseconds $DelayMs
}

Write-Host "Simulation complete. Recent 4625 events:" -ForegroundColor Green

# Show the last few 4625 events to confirm generation
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 10 |
    Select-Object TimeCreated, Id, @{Name='Account';Expression={$_.Properties[5].Value}}, @{Name='IpAddress';Expression={$_.Properties[18].Value}} |
    Format-Table -AutoSize
