#!/bin/sh

function log {
  echo "$@"
  return 0
}

APP_NAME="nginx"

# assign the entered image tag to a variable
while getopts ":t:" opt; do
  case $opt in
    t ) img_tag=$OPTARG;;
    \? ) log "Invalid option -$OPTARG" >&2;;
  esac
done

# run terraform script
log "✅ Provisioning the terraform resources..."
cd terraform-main
terraform init
terraform get -update
terraform apply -var-file='vars.tfvars' -auto-approve
cd ..

sleep 1m

# create namespace for the helm app
NS=$(kubectl get namespace $APP_NAME --ignore-not-found);
if [[ "$NS" ]]; then
  log "✅ Skipping creation of namespace $APP_NAME - already exists";
else
  log "✅ Creating namespace $APP_NAME";
  kubectl create namespace $APP_NAME;
fi;

sleep 2s

# update the tag for the helm deployment
log "✅ Updating the image tag for nginx..."
yq e -i ".app.tag |= \"${img_tag}\"" helm-chart/nginx/values.yaml

sleep 2s

# deploy helm app
log "✅ Deploying helm app from the helm chart package..."
helm upgrade $APP_NAME helm-chart/nginx --install --values helm-chart/nginx/values.yaml -n $APP_NAME
log "✅ $APP_NAME successfully deployed to k8s cluster"

sleep 10s

# view deployed app
log "✅ Displaying the deployed app..."
helm list -n $APP_NAME

sleep 2s

kubectl get all -n $APP_NAME