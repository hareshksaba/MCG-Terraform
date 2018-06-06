# This Terraform will perfom the following tasks
1. Create A highly available autoscaling group
    Min 2 EC2s, max 5 EC2s in 2 different zones
    CPU at 85% triggers the scaling.
2. Create One S3 bucket
3. Attach IAM role to allow access to the S3 bucket
4. Create and configure an Application Load Balancer with a target group that will contain the EC2s from the autoscaling group

