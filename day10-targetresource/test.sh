# b) for multiple resources
#!/bin/bash
resources=(
     "aws_s3_bucket.bucket"
    #  "aws_instance.ec2"
)

for resource in "${resources[@]}"; do
    targets+=" -target=$resource"
done

terraform destroy $targets -auto-approve

# run the script sh test.sh in commnad line
