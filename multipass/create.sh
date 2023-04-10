multipass launch --cpus 1 --memory 2G --disk 50G --name master-ansible --mount /home/dy/Projets/Labs/k8s/rke2:~/rke2 22.10
multipass launch --cpus 1 --memory 4G --disk 100G --name control-plane 22.10
multipass launch --cpus 1 --memory 4G --disk 100G --name data-plane-1 22.10
multipass launch --cpus 1 --memory 4G --disk 100G --name data-plane-2 22.10
