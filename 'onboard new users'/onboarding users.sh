#! /bin/bash

usergroup='developers'
while IFS=, read -r line;
do 
    echo "${line,,}";
    if id "${line,,}" &>/dev/null; then
        echo 'user already exist'
    else
        sudo useradd -s /bin/bash -d "/home/${line,,}" -m -G ${usergroup} ${line,,}
        sudo mkdir /home/${line,,}/.ssh
        sudo chmod 0700 /home/${line,,}/.ssh
        sudo -- sh -c "cat /home/$USER/.ssh/id_rsa.pub > /home/${line,,}/.ssh/authorized_keys"
        sudo chown -R ${line,,}:${line,,} /home/${line,,}/.ssh
    fi
done < names.csv