$ssh_config = '
host github.com
 HostName github.com
 IdentityFile ~/.ssh/id_rsa_boltws
 StrictHostKeyChecking no
 User git
'

Write-Host "Configuring SSH for Bolt Workshop..."
New-Item -ItemType Directory -Force -Path ~/.ssh
If ( Get-Content ~/.ssh/config -ErrorAction SilentlyContinue | %{$_ -match "host github.com"} ) {
  Write-Host "~/.ssh/config is already configured, skipping modification."
}
Else {
  Add-Content -Value $ssh_config -Path ~/.ssh/config
}
iwr -Uri "https://raw.githubusercontent.com/kreeuwijk/workshop-control-repo/production/workshop_key.enc" -OutFile ~/workshop_key.enc
$content = Get-Content ~/workshop_key.enc
[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($content)) | Out-File -Encoding "ASCII" ~/.ssh/id_rsa_boltws
"$(& $Env:Programfiles\Git\usr\bin\ssh.exe -oStrictHostKeyChecking=no -T git@github.com 2>&1)"

Write-Host "Done configuring SSH."

cd ~
Write-Host "Cloning Workshop Control Repo to $((Get-Location).Path)\workshop-control-repo ..."
git clone -q git@github.com:kreeuwijk/workshop-control-repo
Write-Host "Done!"
