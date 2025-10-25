#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

echo "### Phase 1: Provisioning Infrastructure with Terraform... ###"
cd terraform # Navigate into the terraform directory

# Check if terraform executable exists here, otherwise assume it's in PATH
if [ -f "./terraform.exe" ]; then
    TERRAFORM_CMD="./terraform.exe"
elif [ -f "./terraform" ]; then
    TERRAFORM_CMD="./terraform"
else
    TERRAFORM_CMD="terraform" # Assume it's in the system PATH
fi

echo "Using Terraform command: $TERRAFORM_CMD"

$TERRAFORM_CMD init -upgrade # Initialize terraform, upgrade providers if needed
$TERRAFORM_CMD apply -auto-approve # Apply the terraform configuration

echo "Waiting a few seconds for infrastructure to stabilize..."
sleep 15

# Get the Manager IP from terraform output using JSON and jq
MANAGER_IP=$($TERRAFORM_CMD output -json swarm_nodes_public_ips | jq -r '.manager')

# Check if MANAGER_IP was successfully retrieved
if [ -z "$MANAGER_IP" ] || [ "$MANAGER_IP" == "null" ]; then
    echo "Error: Failed to retrieve Manager IP from Terraform output."
    # Optional: Display raw output for debugging
    echo "Raw Terraform output:"
    $TERRAFORM_CMD output -json swarm_nodes_public_ips
    exit 1
fi

echo "Manager IP: $MANAGER_IP"

cd .. # Go back to the project root directory (/mnt/d/devops-project)

echo "### Phase 2: Configuring Server with Ansible... ###"

# Dynamically create the inventory file for the single manager
mkdir -p ansible # Create ansible directory if it doesn't exist

echo "$MANAGER_IP" >> ansible/inventory.ini
echo "" >> ansible/inventory.ini
echo "[all:vars]" >> ansible/inventory.ini
echo "ansible_user=ec2-user" >> ansible/inventory.ini # Use correct username
# Use the correct key path within WSL (Update 'sanjana' if needed)
echo "ansible_ssh_private_key_file=/home/sanjana/.ssh/sanju_key.pem" >> ansible/inventory.ini
echo "ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'" >> ansible/inventory.ini # Avoid host key prompts

echo "Created ansible/inventory.ini:"
cat ansible/inventory.ini

echo "Running Ansible playbooks from local WSL..."
# Add '-v' for more verbose output if needed
ansible-playbook -i ansible/inventory.ini ansible/install-docker.yml
ansible-playbook -i ansible/inventory.ini ansible/swarm-init.yml

echo "### Phase 3: Initial Deployment (Handled by CI/CD on first push) ###"
echo "Ansible configuration complete. Push code to GitHub branch to deploy the application."
echo "### Bootstrap Complete! ###"
echo "You can now connect to your server:"
echo "ssh -i /home/sanjana/.ssh/sanju_key.pem ec2-user@$MANAGER_IP"

