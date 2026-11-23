# Run on the Windows DNS / Domain Controller from Project 9
param(
  [string]$WebServerIP = "10.0.1.10"
)

Add-DnsServerResourceRecordA `
  -Name "web" `
  -ZoneName "capstone.local" `
  -IPv4Address $WebServerIP `
  -CreatePtr:$false

Write-Host "Testing DNS resolution:"
nslookup web.capstone.local 127.0.0.1
