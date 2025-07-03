#!/bin/bash
# This script retrieves the kubeconfig from GKE (Google Kubernetes Engine) using Terraform outputs.
# contributors: Ross Ivanov
# Usage: ./get_kubeconfig.sh

# check if jq, terraform, gcloud and kubectl are installed
for tool in jq terraform gcloud kubectl; do
    if ! command -v $tool &> /dev/null; then
        echo "Error: $tool is not installed. Please install it and try again."
        exit 1
    fi
done

#Validate glcoud gke-gcloud-auth-plugin is installed and configured
if ! gcloud components list --filter="gke-gcloud-auth-plugin" --format="value(name)" | grep -q "gke-gcloud-auth-plugin"; then
    echo "Error: gke-gcloud-auth-plugin is not installed. Please install it using 'gcloud components install gke-gcloud-auth-plugin'."
    exit 1
fi



# Read the Terraform output
terraform_output=$(terraform output -json)
if [ $? -ne 0 ]; then
    echo "Error: Failed to retrieve Terraform output."
    exit 1
fi

# Extract the EKS cluster name and region from the Terraform output
cluster_name=$(echo $terraform_output | jq -r '.cluster_name.value')
cluster_location=$(echo $terraform_output | jq -r '.cluster_location.value')
if [ -z "$cluster_name" ] || [ -z "$cluster_location" ]; then
    echo "Error: cluster_name or cluster_region is not set in Terraform output."
    exit 1
fi

echo "Retrieving kubeconfig for GKE cluster: $cluster_name in region: $cluster_location"
# Update kubeconfig using gcloud command
gcloud container clusters get-credentials "$cluster_name" --region "$cluster_location"
if [ $? -ne 0 ]; then
    echo "Error: Failed to update kubeconfig for GKE cluster."
    exit 1
fi

echo "Kubeconfig updated successfully for EKS cluster: $cluster_name"
# Verify the kubeconfig by getting the cluster info
kubectl cluster-info
if [ $? -ne 0 ]; then
    echo "Error: Failed to retrieve cluster info. Please check your kubeconfig."
    exit 1
fi
