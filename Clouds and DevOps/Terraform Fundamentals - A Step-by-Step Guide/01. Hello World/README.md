# Terraform Hello World Example

This is a basic "Hello World" example using Terraform to provision an AWS EC2 instance. It demonstrates the use of Terraform to define and manage infrastructure as code.

## What This Code Does
- Provisions an EC2 instance in the **us-east-1** region
- Uses the **t2.micro** instance type
- Tags the instance with the name **HelloWorld**

## Usage
1. Initialize Terraform working directory to download necessary providers:
    - ```terraform init```
2. Review the execution plan:
    - ```terraform plan```
3. Apply the configuration to provision the resources:
    - ```terraform apply``` 
    - Confirm the prompt by typing "yes"
4. Destroy the resources when done:
    - ```terraform destroy```
    - Confirm the prompt by typing "yes"

### **Expected Output**
- A t2.micro EC2 instance will be created in the us-east-1 region using the specified Amazon Machine Image (AMI).
- The instance will have the tag Name = HelloWorld.

## **Notes**
- The AMI ID used in this example is specific to the us-east-1 region. Update the ami value if using a different region.
- Modify the instance_type or tags as required to customize the instance.