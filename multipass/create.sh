multipass launch --cloud-init $(pwd)/multipass/cloud-init --cpus 1 --memory 2G --disk 50G --name master-ansible --mount $(pwd)/rke2:~/rke2 22.10 &
multipass launch --cloud-init $(pwd)/multipass/cloud-init --cpus 1 --memory 4G --disk 100G --name control-plane 22.10 &
multipass launch --cloud-init $(pwd)/multipass/cloud-init --cpus 1 --memory 4G --disk 100G --name data-plane-1 22.10 &
multipass launch --cloud-init $(pwd)/multipass/cloud-init --cpus 1 --memory 4G --disk 100G --name data-plane-2 22.10 &

wait

sh $(pwd)/multipass/initialize-ansible-cluster.sh