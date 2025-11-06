set -e

NAME="kubernetes-demo-api"
USERNAME="dennispoh"
IMAGE="$USERNAME/$NAME:latest"

echo "Building Docker image..."
docker build -t $IMAGE .

echo "Pushing Docker image to Docker Hub..."
docker push $IMAGE
echo "Deploying to kubernetes manifests..."
kubectl apply -f k8s/

echo "Getting POD names..."
kubectl get pods

echo "Getting Service details..."
kubectl get services

echo "Fetching main service..."
kubectl get services $NAME

echo "Launched services."
minikube service $NAME
