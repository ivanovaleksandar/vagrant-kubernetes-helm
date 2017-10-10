#!/bin/bash
case "$1" in
  cluster-destroy)
    if [ $USER != "root" ]; then 
      echo "The command can only be executed with root user" 
    else 
      systemctl stop kubelet 
      rm -rf /var/lib/kubelet/pki 
      kubeadm reset; 
    fi
    ;;

  cluster-create)
    if [ $USER != "root" ]; then 
      echo 'The command can only be executed with root user' 
    else 
      kubeadm init --apiserver-advertise-address=192.168.10.30 --pod-network-cidr=192.168.0.0/16
    fi 
    ;;

  cluster-init)
    if [ $USER = "root" ]; then 
      echo "The command cannot be executed with root user"
    else 
      mkdir -p $HOME/.kube
      sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
      sudo chown $(id -u):$(id -g) $HOME/.kube/config
      kubectl apply -f http://docs.projectcalico.org/v2.4/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml
    fi
  ;;
  *)
    echo $"Usage: $0 {cluster-init|cluster-create|cluster-destroy}"
    exit 1
esac