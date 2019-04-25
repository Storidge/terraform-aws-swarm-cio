# Terraform Template for AWS Swarm with Storidge CIO
This repo contains a [Terraform](https://www.terraform.io/) template for generating and managing clusters of AWS instances with the community edition of the [Storidge CIO](http://docs.storidge.com) software.

The terraform code will look for an AWS image to launch the cloud instances. This image can be easily created by following the steps in the [packer-cio](https://github.com/Storidge/packer-cio) repo.

## Configuration
Default cluster configuration (can be altered in the `variables.tf` and `instances.tf` files):

* 1 Swarm Master Node
  * t2.micro instance type
  * 3 20GB storage drives
* 3 Swarm Worker Nodes
  * t2.micro instance types
  * 3 20GB storage drives on each worker
* Default cluster region: `us-west-2`


## Usage
### Set-Up
[Download Terraform](https://www.terraform.io/downloads.html)

Download template into desired project repository:
```
git clone https://github.com/Storidge/terraform-aws-swarm-cio.git
```

Initiate terraform:
```
terraform init
```
Add credentials file `terraform.tfvars`:
```
cd terraform-aws-swarm-cio
cp terraform.tfvars.template terraform.tfvars
```
Add your AWS access id and secret key to `terraform.tfvars`.

Update `instances.tf` with correct AMI and instance arguments.

Check `variables.tf` uses correct region and ssh key.

To verify your configuration will work run:

```
terraform plan
```

### Deploy cluster
If there are no errors, run the following command to build infrastructure:
```
terraform apply
```
Use the ssh key defined in `variables.tf` to access AWS instances.

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

