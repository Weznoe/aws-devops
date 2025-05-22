# Deploy an EKS cluster
INTIIALS=${1:-'tc'}
if [[ ${#INTIIALS} -gt 3 ]] 
then
    echo "Your initials can't be longer than 3 characters, try again"
    exit
fi
REGION=$2

sed -i "s/<initials-cluster>/$INTIIALS-cluster/" cluster.yaml
sed -i "s/<initials>/$INTIIALS/" cluster.yaml

if [ -n "$REGION" ]
then
    sed -i "s/us-east-1/$REGION/" cluster.yaml
fi

eksctl create cluster -f cluster.yaml