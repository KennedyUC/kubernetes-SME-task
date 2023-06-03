## Kubernetes SME Task  
  
## Deliverables
1. Terraform Scripts for provisioning Amazon Elastic Kubernetes Service (EKS)  
2. Helm Chart for deploying Nginx container in the provisioned EKS Cluster  
3. Shell Script for creating/updating the Kubernetes Deployment
4. GitHub Action workflow for running the tasks as an automated end-to-end pipeline  
  
## Codebase Structure  
**terraform-modules**:  
I organized the terraform scripts as modules to make the management of the resources seamless.  

The modules included within this directory include:  
- **eks_network module** for provisioning the AWS Network resources needed for necessary network connections.  
- **eks_cluster module** for provisioning the AWS EKS Cluster resource and the necessary permission(s).  
- **eks_node_group module** for provisioning the Node Group that connects with the EKS Cluster and the necessary permission(s).  

There are some dependencies across the modules. I used the output resources to pass the parameters accordingly. 
  
**terraform-main**:  
This directory is the point of ingestion of the terraform modules. The modules' resources are provisioned from this point.  
  
**helm-chart**:  
This directory contains the kubernetes deployment template to be deployed by helm. To make the deployment a bit generic, I included some variables in the deployment and service manifests with their values set in the `values.yaml` file.  
  
**deployment script**:  
I included the bash script for running the deployment in the root directory. I had to add the end-to-end workflow in the script.  
  
## Running the Deployment Script  
**install the needed tools, if don't have them already installed**
``` 
chmod +x install.sh 
```  
  
```  
./install.sh  
```  
  
**authenticate to aws user account**  
```  
aws configure  
```  
  
**run the deployment script**  
```  
chmod +x deploy.sh  
```  
  
```  
./deploy.sh -image_tag "alpine3.17-slim"