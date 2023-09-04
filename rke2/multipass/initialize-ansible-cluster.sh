# PUBLIC IP
master_ansible_ip=$(multipass exec master-ansible -- hostname -I)
control_plane_ip=$(multipass exec control-plane -- hostname -I)
data_plane_ip=$(multipass exec data-plane -- hostname -I)
user=ubuntu

echo
echo "Veuillez ajouter les adresses ip des noeuds ansible aux hosts du master ansible."
echo "Les commandes suivantes doivent être effectuées sur le master ansible en étant sudo."
echo "Une fois fait cliquez sur ENTRER pour continuer."
echo
echo "echo '#Ansible cluster config' >> /etc/hosts"
echo "echo '$control_plane_ip control-plane' >> /etc/hosts"
echo "echo '$data_plane_ip data-plane' >> /etc/hosts"
echo

read ENTRER

# Generer la paire de clé ssh du master ansible
echo "echo -e 'y\n' | ssh-keygen -f /home/${user}/.ssh/id_rsa -t rsa -N ''" | multipass shell master-ansible

# Recuperer la clé publique du master ansible
master_ansible_pub_key=$(multipass exec master-ansible -- cat /home/${user}/.ssh/id_rsa.pub)

# Ajouter la clé publique du master ansible aux clés autorisées des nodes ansible
echo "echo $master_ansible_pub_key >> /home/${user}/.ssh/authorized_keys" | multipass shell control-plane &
echo "echo $master_ansible_pub_key >> /home/${user}/.ssh/authorized_keys" | multipass shell data-plane &

wait

# Install pip3 and Ansible
echo "sudo apt install python3-pip -y && \
python3 -m pip install ansible && \
export PATH=\$PATH:/home/ubuntu/.local/bin
" | multipass shell master-ansible

# Ajouter les adresses ip des nodes ansibles aux hotes connues du master pour faciliter la connexion sans interruption

# echo "
# ssh-keyscan -H control-plane-1 >> /home/${user}/.ssh/known_hosts && \
# ssh-keyscan -H data-plane >> /home/${user}/.ssh/known_hosts && \
# ssh-keyscan -H data-plane-2 >> /home/${user}/.ssh/known_hosts 
# " | multipass shell master-ansible

echo "multipass shell master-ansible"
