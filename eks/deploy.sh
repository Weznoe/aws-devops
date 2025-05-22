# Deploy an EKS cluster
CLUSTER_NAME=${1:-'test-cluster'}
REGION=$2

sed -i "s/<initials-cluster>/$CLUSTER_NAME/" cluster.yaml

if [ -n "$REGION" ]
then
    sed -i "s/us-east-1/$REGION/" cluster.yaml
fi

# eksctl create cluster -f cluster.yaml