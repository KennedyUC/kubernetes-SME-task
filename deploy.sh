#!/bin/sh

function log {
  echo "$@"
  return 0
}

APP_NAME="nginx"

# set a default value for the nginx image tag
img_tag="latest"

while getopts ":image_tag:" opt; do
  case $opt in
    image_tag) img_tag=$OPTARG;;
    \?) log "Invalid option: -$OPTARG" >&2;;
  esac
done

# run terraform script
cd terraform-main
terraform apply -var-file='vars.tfvars' -auto-approve

sleep 2m

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
yq e -i ".app.tag = $img_tag" ./helm-chart/nginx/values.yaml

sleep 2s

# deploy helm app
log "✅ deploying helm app from the helm chart package..."
helm upgrade $APP_NAME helm-chart/ngnix --install --values ./helm-chart/ngnix/values.yaml -n $APP_NAME
log "✅ $APP_NAME successfully deployed to k8s cluster"

sleep 10s

# view deployed app
log "✅ displaying the deployed app..."
helm list -n $APP_NAME

sleep 2s

kubectl get all -n $APP_NAME