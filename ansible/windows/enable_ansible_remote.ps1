# Open PowerShell Remoting for ansible remote login
Enable-PSRemoting -Force

# Open firewall for WinRm TLS endpoint (Default port 5986) 
New-NetFirewallRule -DisplayName "WinRM HTTPS" -Direction Inbound -Protocol TCP -LocalPort 5986 -Action Allow

# Create self-signed certificate for WinRM TLS authentication
$certificite = New-SelfSignedCertificate -DnsName "$env:COMPUTERNAME" -CertStoreLocation "Cert:\LocalMachine\My"
$thumbprint = $certificate.Thumbprint

# Listen remote control request
winrm create winrm/config/Listener?Address=*+Transport=HTTPS "@{Hostname=`"$env:COMPUTERNAME`";CertificateThumbprint=`"$thumbprint`"}"

# Enable remote controll permission for local acounts
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name LocalAccountTokenFilterPolicy -Value 1
