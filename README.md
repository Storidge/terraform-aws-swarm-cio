# Terraform Template for AWS Swarm with Storidge CIO
This repo contains a [Terraform](https://www.terraform.io/) template for generating and managing clusters of AWS instances with the community edition of the [Storidge CIO](http://docs.storidge.com) software.

The terraform code will look for an AWS image to launch the cloud instances. This image can be easily created by following the steps in the [packer-cio](https://github.com/Storidge/packer-cio) repo.

## Configuration
Default cluster configuration (can be altered in the `variables.tf` and `instances.tf` files):

* 1 Swarm Master Node
  * t3.large instance type
  * 3 100GB storage drives
* 3 Swarm Worker Nodes
  * t3.large instance types
  * 3 100GB storage drives on each worker
* Default cluster region: `us-west-2`


## Usage

### Set-Up

[Download Terraform](https://www.terraform.io/downloads.html)

Download template into desired project repository:
```
git clone https://github.com/Storidge/terraform-aws-swarm-cio.git
```

Initialize Terraform for project directory:
```
terraform init
```
Add credentials file `terraform.tfvars`:
```
cd terraform-aws-swarm-cio
cp terraform.tfvars.template terraform.tfvars
```
Add your AWS access id and secret key to `terraform.tfvars`.

Update `instances.tf` with desired AMI and instance arguments.

Check `variables.tf` uses correct region and ssh key.

### Start ssh-agent and add deployment key

```
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
echo $SSH_AGENT_SOCK
ssh-add -l
```

### Verify build 

Before deploying, check what Terraform will build:

```
terraform plan
```

### Deploy cluster
If there are no errors, run the following command to build infrastructure:
```
terraform apply
```

Login to cluster at the IP addresses listed. 

### Update state

Check current infrastructure state:
```
terraform show terraform.tfstate
```

If the infrastructure has been changed outside terraform, update the state information:
```
terraform refresh
```						

### Terminate cluster

To terminate the cluster run:
```
terraform destroy
```					

