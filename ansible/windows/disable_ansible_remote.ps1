# Close WinRM firewall
Remove-NetFirewallRule -DisplayName "WinRM HTTPS"

# Remove self-signed certificate for WinRM TLS
Get-ChildItem -Path "Cert:\LocalMachine\My" | Where-Object { $_.Subject -match "$env:COMPUTERNAME" } | Remove-Item -Force

# Stop winrm listener
winrm delete winrm/config/listener?Address=*+Transport=HTTPS

# Restore remote control permission for local accounts
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name LocalAccountTokenFilterPolicy -Value 0