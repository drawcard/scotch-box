#!/bin/bash

echo "***>> Initial Server Setup Script (starting in 3 seconds... Ctrl-C to abort)"
sleep 3

echo "***>> Performing routine updates..."
sleep 3

#sudo apt-get update
sudo apt-get install build-essential libssl-dev zsh git-core htop

echo "***>> Installing WP-CLI..."
sleep 3

cd ~
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
wp --info

echo "***>> Installing AutoMYSQLBackup..."
sleep 3

sudo apt-get install automysqlbackup

echo "***>> Finished! Reboot the server to complete setup."



echo "***>> Installing Oh My Zsh... Once installed, type "exit" to return to this script installation."
sleep 3

cd ~
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s 'which zsh'
source ~/.profile #reload bash session

echo "***>> Installing Antigen..."
sleep 3

cd ~
curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh > antigen.zsh
source antigen.zsh
source ~/.zshrc #reload session
# Install useful bundles
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git

echo "***>> Installing Liquid Prompt..."
sleep 3

cd ~
git clone https://github.com/nojhan/liquidprompt.git
source liquidprompt/liquidprompt

echo 'export LSCOLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"' >> .zshrc
echo 'zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}' >> .zshrc
echo "# Only load Liquid Prompt in interactive shells, not from a script or from scp" >> .bashrc
echo "[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt" >> .zshrc
source ~/.zshrc #reload session

# Update directory colour output to match solarized dark
dircolors -p > ~/.dircolors
mv ~/.dircolors ~/.dircolors-backup
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
mv dircolors.256dark .dircolors

source ~/.zshrc #reload session

cp ~/liquidprompt/liquidpromptrc-dist ~/.config/liquidpromptrc
source ~/.profile #reload bash session

echo "***>> Finished! Booting into ZSH..."
sleep 3
zsh
