echo "Configuring SSH for Bolt Workshop..."

if [ ! -d ~/.ssh ]
then
  mkdir ~/.ssh
fi

cat ~/.ssh/config | grep "host github.com"
if [ $? -eq 0 ]; then
  echo '~/.ssh/config is already configured, skipping modification.'
else
cat << EOF >> ~/.ssh/config
host github.com
 HostName github.com
 IdentityFile ~/.ssh/id_rsa_boltws
 StrictHostKeyChecking no
 User git
EOF
fi

curl "https://raw.githubusercontent.com/kreeuwijk/workshop-control-repo/production/workshop_key.enc" -L -o ~/workshop_key.enc
rm -rf ~/.ssh/id_rsa_boltws
base64 --decode ~/workshop_key.enc > ~/.ssh/id_rsa_boltws
chmod 0600 ~/.ssh/id_rsa_boltws
chmod 0600 ~/.ssh/config
ssh -oStrictHostKeyChecking=no -T git@github.com

echo "Done configuring SSH."

cd ~
echo "Cloning Workshop Control Repo to $(pwd)/workshop-control-repo ..."
git clone -q git@github.com:kreeuwijk/workshop-control-repo
echo "Done!"
