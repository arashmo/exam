#!/bin/bash
### purpose of this script creating an interactive user friendly terrafom updated that ask user for the setting 
#as desired and updates the variable across the project, will be seprated in multiplle function accept my applogize 
# have to use the --flag insited of user prompt, nodees creation and and other stuff i wish i had time to create them all 

set -e 
# TODO: ask user for API key, location,,.... 
# create a backup dir 
function () updater_for_cognitive_servic{
    #!/bin/bash

# Script to run Terraform with user-provided input

# Function to prompt for variable input
prompt_for_input() {
    local var_name=$1
    local var_description=$2
    read -p "Enter ${var_description}: " input
    echo "${var_name} = \"${input}\""
}

#TODO: Collect input from the user TODO print out help and get them through flags as well sanity check
echo "Please provide the following information for Terraform deployment:"

resource_group_name=$(prompt_for_input "resource_group_name" "Resource Group Name")
location=$(prompt_for_input "location" "Azure Region Location (e.g., West Europe)")
vnet_name=$(prompt_for_input "vnet_name" "Virtual Network Name")
subnet_name=$(prompt_for_input "subnet_name" "Subnet Name")
cognitive_account_name=$(prompt_for_input "cognitive_account_name" "Cognitive Services Account Name")
private_endpoint_name=$(prompt_for_input "private_endpoint_name" "Private Endpoint Name")
vnet_address_space=$(prompt_for_input "vnet_address_space" "Virtual Network Address Space (e.g., 10.0.0.0/16)")

# Prepare Terraform variables TODO convevrt to array: for the () bugs
tf_vars=(
    "${resource_group_name}"
    "${location}"
    "${vnet_name}"
    "${subnet_name}"
    "${cognitive_account_name}"
    "${private_endpoint_name}"
    "${vnet_address_space}"
)

# Run Terraform init and apply
terraform init
terraform apply -var "${tf_vars[@]}"

}