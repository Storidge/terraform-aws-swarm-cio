# Terraform Template for AWS Swarm with Storidge CIO
This repo contains a [Terraform](https://www.terraform.io/) template for generating and managing clusters of AWS instances with the community edition of the [Storidge CIO](http://storidge.com/docs/) software.

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
If there are no errors, run the following command to build infrastructure:
```
terraform apply
```
Use the ssh key defined in `variables.tf` to access AWS instances.

### Maintenance

Check current infrastructure state:
```
terraform show terraform.tfstate
```

If the infrastructure has been changed outside terraform, update the state information:
```
terraform refresh
```						

To terminate the cluster run:
```
terraform destroy
```					
