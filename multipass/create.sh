multipass launch --cloud-init $(pwd)/multipass/cloud-init --cpus 1 --memory 2G --disk 50G --name master-ansible --mount $(pwd)/rke2:~/rke2 22.10 &
multipass launch --cloud-init $(pwd)/multipass/cloud-init --cpus 2 --memory 8G --disk 150G --name control-plane 22.10 &
multipass launch --cloud-init $(pwd)/multipass/cloud-init --cpus 2 --memory 8G --disk 150G --name data-plane 22.10 &

wait

echo "All instances created"

# sh $(pwd)/multipass/initialize-ansible-cluster.sh