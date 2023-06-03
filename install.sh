#!/bin/sh

function log {
  echo "$@"
  return 0
}

TERRAFORM_VERSION="1.3.5"

# install kubectl, if not already installed
if ! command -v kubectl > /dev/null 2>&1; then
  log "✅ Installing kubectl"
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
else
  log "✅ kubectl is already installed"
fi

sleep 2s

# install helm, if not already installed
if ! command -v helm > /dev/null 2>&1; then
  log "✅ Installing Helm"
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
else
  log "✅ Helm is already installed"
fi

sleep 2s

# install yq if not already installed
if ! command -v yq > /dev/null 2>&1; then
  log "✅ Installing yq"
  sudo apt-get update
  sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
  sudo chmod a+x /usr/local/bin/yq
else
  log "✅ yq is already installed"
fi

sleep 2s

# install yq if not already installed
if ! command -v terraform > /dev/null 2>&1; then
  log "✅ Installing Terraform"
  wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -O terraform.zip
  unzip terraform.zip
  sudo install -o root -g root -m 0755 terraform /usr/local/bin/terraform
  rm terraform terraform.zip
else
  log "✅ Terraform is already installed"
fi