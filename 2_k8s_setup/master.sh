export WEAVE_NET_IP_RANGE=10.32.0.0/12
export KUBE_MASTER_IP_ADDRESS=172.16.16.200

kubeadm init --pod-network-cidr $WEAVE_NET_IP_RANGE --apiserver-advertise-address=$KUBE_MASTER_IP_ADDRESS
export KUBECONFIG=/etc/kubernetes/admin.conf
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> /etc/bash.bashrc
# weavenet 설치
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
# kubectl 자동완성
source /usr/share/bash-completion/bash_completion
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc