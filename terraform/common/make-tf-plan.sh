#/bin/bash
# helper for terraform plan that provides a summary for the plan
# Contributor: Ross Ivanov
# Usage: ./make-tf-plan.sh 
# Recommended to make a symlink to this script in the root of the terraform project

# define color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# define logging function
log() {
    local level="$1"
    shift
    local message="$@" 
    case "$level" in
        "INFO")
            echo -e "${GREEN}[INFO] $message${NC}"
            ;;
        "WARNING")
            echo -e "${YELLOW}[WARNING] $message${NC}"
            ;;
        "ERROR")
            echo -e "${RED}[ERROR] $message${NC}"
            ;;
        *)
            echo -e "[UNKNOWN] $message"
            ;;
    esac
}


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
log "WARNING" "PLAN SUMMARY:"
echo "--------------------------------------------------"
terraform show ./plan.tfplan | grep " # "

echo "Validate the the plan above and run terraform apply ./plan.tfplan to apply the changes."
