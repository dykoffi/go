# PUBLIC IP
master_ansible_ip=$(multipass exec master-ansible -- hostname -i)
control_plane_ip=$(multipass exec control-plane -- hostname -i)
data_plane_1_ip=$(multipass exec data-plane-1 -- hostname -i)
data_plane_2_ip=$(multipass exec data-plane-2 -- hostname -i)
data_plane_3_ip=$(multipass exec data-plane-3 -- hostname -i)

# Generer la paire de clé ssh du master ansible
multipass exec master-ansible -- "echo -e 'y\n' | ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''"

# Recuperer la clé publique du master ansible
master_ansible_pub_key=$(multipass exec master-ansible -- "cat ~/.ssh/id_rsa.pub")

# Ajouter la clé publique du master ansible aux clés autorisées des nodes ansible
ssh data354@$control_plane_ip "echo $master_ansible_pub_key > ~/.ssh/authorized_keys" &
ssh data354@$data_plane_1_ip "echo $master_ansible_pub_key > ~/.ssh/authorized_keys" &
ssh data354@$data_plane_2_ip "echo $master_ansible_pub_key > ~/.ssh/authorized_keys" &
ssh data354@$data_plane_3_ip "echo $master_ansible_pub_key > ~/.ssh/authorized_keys" &

wait

# Ajouter les adresses ip des nodes ansibles aux hotes connues du master pour faciliter la connexion sans interruption
ssh data354@$master_ansible_ip "
ssh-keyscan -H control-plane-1 > ~/.ssh/known_hosts && \
ssh-keyscan -H data-plane-1 >> ~/.ssh/known_hosts && \
ssh-keyscan -H data-plane-2 >> ~/.ssh/known_hosts && \
ssh-keyscan -H data-plane-3 >> ~/.ssh/known_hosts
"

echo "Master Ansible Public Ip : $master_ansible_ip"
