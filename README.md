# Kubernetes Demo Application

A demonstration project showcasing Kubernetes deployment with a Node.js API. Features horizontal scaling, health checks, and resource management.

## Prerequisites

- [Docker](https://www.docker.com/get-started)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

## Project Structure

```
Kubernetes-Demo/
├── k8s/                    # Kubernetes manifests
│   ├── deployment.yaml     # Pod deployment configuration
│   └── service.yaml        # Service configuration
├── src/                    # Application source code
└── Dockerfile             # Container image definition
```

## Quick Start

1. Start your local Kubernetes cluster:
```bash
minikube start 
```

2. Deploy the application:
```bash
kubectl apply -f k8s
```

3. Get the service URL:
```bash
minikube service kubernetes-demo-api
```

## Features

- **Horizontal Scaling**: Running 2 replicas of the API service
- **Resource Management**: 
  - Memory: 128Mi-512Mi
  - CPU: 100m-500m
- **Health Monitoring**:
  - Readiness probe: `/ready` endpoint (5s initial delay, 10s period)
  - Liveness probe: `/health` endpoint (15s initial delay, 20s period)
- **Environment Variables**:
  - NODE_ENV=production
  - POD_NAME (from Kubernetes metadata)

## Deployment Details

### API Service
- Image: `<dockerhub name>/kubernetes-demo-api:latest`
- Port: 3000
- Type: NodePort (configurable to LoadBalancer for cloud deployment)

### Scaling

To scale the deployment:
```bash
kubectl scale deployment kubernetes-demo-api --replicas=3
```

### Monitoring

Check deployment status:
```bash
kubectl get deployments
kubectl get pods
kubectl get services
```

View pod logs:
```bash
kubectl logs -l app=kubernetes-demo-api
```

## Development

### Building the Image

```bash
docker build -t <dockerhub name>/kubernetes-demo-api:latest .
docker push <dockerhub name>/kubernetes-demo-api:latest
```

### Local Testing

1. Run locally with Docker:
```bash
docker run -p 3000:3000 <dockerhub name>/kubernetes-demo-api:latest
```

2. Test endpoints:
```bash
curl http://localhost:3000/health
curl http://localhost:3000/ready
```

## Cleanup

Remove the deployment:
```bash
kubectl delete -f k8s/
```

Stop Minikube:
```bash
minikube stop
```

## License

[MIT License](LICENSE)