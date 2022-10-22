# oci-terraform

## Prerequisites
Things you need before starting:
* `OCI account`
* `Terraform`

## Project structure
```
oci-terraform
|── compute.tf
|── datasources.tf
|── env-vars
|── provides.tf
|── network.tf
└── variables.tf
└── scripts
     └── setup.sh
```
## Tasks to accomplish
- The idea of this project is to create some infraestructure in `OCI` using `Terraform`

## How to setup this project locally
- First we should download it with either `git clone` or as `.zip`.
- Then we will execute `setup.sh` in order to install `terraform` and generate `RSA Keys`. You will have to add the public key to your user account in `OCI`. If you any doubt you can always check [this](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.html) out.
- Then you will have to modify `env-vars` with your data account.

## Infraestructure
  - 1 Virtual Cloud Network
     + Security List (Ingress and Egress rules)
     + Internet Gateway
     + Route Table
     + Public Subnet
  - 1 Compute Instance
     + 1 OCPU
     + 15 Gb of memory
     + 50 Gb of storage

## Commands
````
terraform init
terraform plan
terraform apply
terraform destroy
````
