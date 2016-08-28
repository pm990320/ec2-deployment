source env.sh

ssh -o "StrictHostKeyChecking no" -i ./patrick-ec2-keypair.pem $EC2_USER@$EC2_DNS_NAME -T < machine_create.sh
