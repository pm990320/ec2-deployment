source env.sh

REPO_URL=$1

git clone $REPO_URL deploying_repo

dos2unix deploying_repo/deploy.sh

rsync -avz -e 'ssh -o "StrictHostKeyChecking no" -i ./patrick-ec2-keypair.pem' deploying_repo $EC2_USER@$EC2_DNS_NAME:/home/ubuntu/deploymentscripts
ssh -o "StrictHostKeyChecking no" -i ./patrick-ec2-keypair.pem $EC2_USER@$EC2_DNS_NAME -T < ./deploying_repo/deploy.sh

rm -r -f deploying_repo
