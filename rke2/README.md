# **Rke2 Setup Local Env**

## **Description**

This project is the setup of a production environment based on a kubernetes cluster for the deployment of a Big Data stack. It automates the setup of a highly available k8s cluster on the RKE2 distribution and the installation of all software stacks.

**Features :**

- Scaling (up and down)
- Load balancer et proxy
- Nodes Security
- Backup (Etcd and PV)
- Idempotence

## **Resources**

**Nodes**
  - 1 master ansible (1 cpu, 2G RAM, 50G Disk)
  - 1 control-plane (1 cpu, 4G RAM, 100G Disk)
  - 2 data-plane (1 cpu, 4G RAM, 100G Disk)

## **Prerequises**

**OS**

- Ubuntu 22.10

**Network**

- All node must be in the same private network
- Nodes in the k8s cluster are not accessible via Internet
- All node have access to Internet via port 443
- The master ansible host (proxy & load balancer) is accessible via Internet

**Machine Access**

- The proxy (Load balancer) machine is accessible via SSH port 22
- All host in the k8s cluster are accessible via the proxy machine on port SSH port 22
- All machine must have a same user with root privileges

## **Playbooks**

`prerequises.playbook.yml` : All apps, modules required for the stack deployment

`cluster.playbook.yml` : Contains the roles for the creatin of the cluster (Server and agent)

`client.playbook.yml` : Contains locak software to manage cluster

`apps.playbook.yml` : Contains the differents applications of the stack to install

`main.playbook.yml` : Contains all previous playbooks and runs them in order.

## **Process**

1. If tou don't use proxy in your environment, set the common variable `use_proxy` to false (`roles/commun/default/main.yml`)
2. Copy the master ansible ip address in the commons variables `loadbalancer_public_address` (`roles/commun/default/main.yml`)
3. Test node connection : `ansible -i inventory.ini -m ping all`
4. Launch project : `ansible-playbook -i inventory.ini main.playbook.yml`

## **Test cluster**

```bash
# Get all nodes
kubectl get nodes -o wide

# Get nodes resource utilization
kubectl top nodes

# Get all pods
kubectl get pods -A -o wide

# Get pods resource utilization
kubectl top pods

# Get all failed pods
kubectl get pods -A --field-selector=status.phase=Failed

# Get all failed pods
kubectl get pods -A --field-selector=status.phase=Unknown
```
