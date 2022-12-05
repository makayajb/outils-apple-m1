
#!/bin/bash
# sudo apt update
# sudo apt-get -y upgrade
apt-get install -y python3-pip
apt-get install -y build-essential libssl-dev libffi-dev python3-dev

if [ $1 == "master" ]
then

  # install ansible
  pip3 install ansible

  sudo apt-get install -y git

  if [[ !(-z "$ENABLE_ZSH")  &&  ($ENABLE_ZSH == "true") ]]
    then
      echo "We are going to install zsh"
      sudo apt-get -y install zsh
      echo "vagrant" | chsh -s /bin/zsh vagrant
      su - vagrant  -c  'echo "Y" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
      su - vagrant  -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
      sed -i 's/^plugins=/#&/' /home/vagrant/.zshrc
      echo "plugins=(git  colored-man-pages aliases copyfile  copypath zsh-syntax-highlighting jsontools)" >> /home/vagrant/.zshrc
      sed -i "s/^ZSH_THEME=.*/ZSH_THEME='agnoster'/g"  /home/vagrant/.zshrc
    else
      echo "The zsh is not installed on this server"
  fi

fi

if [ $1 == "node" ]
then
  
  # https://www.ansiblepilot.com/articles/open-firewall-ports-in-debian-like-systems-ansible-module-ufw/
  apt-get install -y ufw curl

  ufw app list
  
  ufw status

  # To do in docker container
  # apt install -y apache2
  # ufw allow 'Apache' 
  # systemctl start apache2
  # systemctl status apache2

  # apt install -y apache2 && ufw allow 'Apache' && systemctl start apache2 && systemctl status apache2
fi
echo "For this Stack, you will use $(hostname -I) IP Address"
