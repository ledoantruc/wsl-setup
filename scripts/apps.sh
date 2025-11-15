#!/bin/bash
#
### install applications ###

# update ubuntu
sudo apt update

# common packages
sudo apt install -y apt-transport-https ca-certificates gnupg curl wget tree unzip net-tools jq python3 python3-pip bash-completion

# git
sudo add-apt-repository -y ppa:git-core/ppa \
&& sudo apt update && sudo apt install -y git

# yq
sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq \
&& sudo chmod +x /usr/bin/yq

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh \
&& echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc

# terraform
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list \
&& sudo apt update \
&& sudo apt install -y terraform

# aws-cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
&& unzip awscliv2.zip \
&& sudo ./aws/install \
&& rm -rf awscliv2.zip aws \
&& aws --version

# gcloud-cli and gke-gcloud-auth-plugin
sudo apt-get update \
&& curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
&& sudo apt-get update \
&& sudo apt-get -y install google-cloud-cli google-cloud-cli-gke-gcloud-auth-plugin

# helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
&& chmod 700 get_helm.sh \
&& ./get_helm.sh \
&& rm -f get_helm.sh

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
&& sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
&& rm -f kubectl \
&& kubectl version --client --output=yaml

# kubectl - enable bash-completion
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null \
&& sudo chmod a+r /etc/bash_completion.d/kubectl

# docker
curl -fsSL https://get.docker.com -o get-docker.sh \
&& sudo sh get-docker.sh

# docker - add current user to docker group
sudo groupadd docker \
&& sudo usermod -aG docker $USER

# minikube
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64 \
&& sudo install minikube-linux-amd64 /usr/local/bin/minikube \
&& rm minikube-linux-amd64 \
&& minikube config set driver docker
