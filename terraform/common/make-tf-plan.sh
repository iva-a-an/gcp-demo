#/bin/bash
# helper for terraform plan that provides a summary for the plan
# Contributor: Ross Ivanov
# Usage: ./make-tf-plan.sh 
# Recommended to make a symlink to this script in the root of the terraform project

# chec if terraform is installed
if ! command -v terraform
then
    echo "Terraform is not installed. Please install Terraform to proceed."
    exit 1
fi

rm -f ./plan.tfplan.out
terraform plan -out=./plan.tfplan

if [ $? -ne 0 ]; then
    echo "Terraform plan failed. Please check the output for errors."
    exit 1
fi

# show the plan summary
terraform show ./plan.tfplan | grep " # "

echo "Validate the the plan above and run terraform apply ./plan.tfplan to apply the changes."
