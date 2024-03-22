# Start session
`source /home/dev/projects/aws/sessioner.sh -p os -t 709740`
`export AWS_DEFAULT_REGION=eu-west-2`

# AWS
`aws-cli/2.9.19 Python/3.9.11 Linux/5.11.0-49-generic exe/x86_64.ubuntu.21 prompt/off`
# Terraform version
`1.6.2`
# Terragrunt version
`0.43.0`

# Documentation
# 

# Prepare ENVs
`cp terraform.tfvars.sample terraform.tfvars`


# Creating a Repository in Amazon ECR with AWS CLI
### aws cli command to create an amazon ecr repository
`aws ecr create-repository --repository-name rentzone --region eu-west-2`

### Pull docker images and test locally
`docker run --rm -it -p 80:80 nginxdemos/hello`
`curl localhost` 
  
### retag docker image 
`docker tag nginxdemos/hello 607126099281.dkr.ecr.eu-west-2.amazonaws.com/rentzone`

### login to ecr
`aws ecr get-login-password --profile os-mfa | docker login --username AWS --password-stdin 607126099281.dkr.ecr.eu-west-2.amazonaws.com/rentzone`

### push docker image to ecr repository 
`docker push 607126099281.dkr.ecr.eu-west-2.amazonaws.com/rentzone`
