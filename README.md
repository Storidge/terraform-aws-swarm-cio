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

### Install Terraform and configure

[Download Terraform](https://www.terraform.io/downloads.html)

Download template into desired project repository:
```
git clone https://github.com/Storidge/terraform-aws-swarm-cio.git
```

Initialize Terraform for project directory:
```
terraform init
```

**Add credentials**

Add your AWS credentials (access id and secret key) to file `terraform.tfvars`:
```
cd terraform-aws-swarm-cio
cp terraform.tfvars.template terraform.tfvars
```

**Configure instance**

Check `variables.tf` uses desired region.

Check `instances.tf` uses desired instance type and AMI. 

### Start ssh-agent and add deployment key

Terraform will use your local SSH key for the deployment. Start `ssh-agent` and add the deployment key: 
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

Login to cluster at the IP addresses listed. For example below, `ssh 18.237.46.2` to login master node: 

```
null_resource.ansible_deploy (local-exec): PLAY RECAP *********************************************************************
null_resource.ansible_deploy (local-exec): swarm-master-00            : ok=10   changed=8    unreachable=0    failed=0
null_resource.ansible_deploy (local-exec): swarm-worker-00            : ok=6    changed=4    unreachable=0    failed=0
null_resource.ansible_deploy (local-exec): swarm-worker-01            : ok=5    changed=4    unreachable=0    failed=0
null_resource.ansible_deploy (local-exec): swarm-worker-02            : ok=5    changed=4    unreachable=0    failed=0

null_resource.ansible_deploy: Creation complete after 2m41s (ID: 5166922584995052323)

Apply complete! Resources: 41 added, 0 changed, 0 destroyed.

Outputs:

swarm_master_address = 18.237.46.2
swarm_worker_address = 54.70.9.178,35.167.209.220,34.219.180.109
```

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
	

