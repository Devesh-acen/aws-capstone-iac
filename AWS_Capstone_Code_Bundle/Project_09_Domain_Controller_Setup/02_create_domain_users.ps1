# Run AFTER reboot (logged in as CAPSTONE\Administrator)
$UserPassword = ConvertTo-SecureString "UserPass@123!" -AsPlainText -Force

New-ADUser `
  -Name "Domain User One" `
  -GivenName "Domain" `
  -Surname "User1" `
  -SamAccountName "user1" `
  -UserPrincipalName "user1@capstone.local" `
  -AccountPassword $UserPassword `
  -Enabled $true `
  -PasswordNeverExpires $true

New-ADUser `
  -Name "Domain User Two" `
  -GivenName "Domain" `
  -Surname "User2" `
  -SamAccountName "user2" `
  -UserPrincipalName "user2@capstone.local" `
  -AccountPassword $UserPassword `
  -Enabled $true `
  -PasswordNeverExpires $true

# Allow domain users to test RDP login on the Domain Controller (for lab proof)
Add-ADGroupMember -Identity "Remote Desktop Users" -Members "user1","user2"

Get-ADUser -Filter "SamAccountName -eq 'user1' -or SamAccountName -eq 'user2'" | Format-Table Name, SamAccountName, Enabled
