# Run in PowerShell as Administrator on Windows Server 2019/2022
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

$SafeModePassword = ConvertTo-SecureString "Admin@Capstone123!" -AsPlainText -Force

Install-ADDSForest `
  -DomainName "capstone.local" `
  -DomainNetbiosName "CAPSTONE" `
  -SafeModeAdministratorPassword $SafeModePassword `
  -InstallDns:$true `
  -Force:$true
# The server will automatically reboot upon completion.
