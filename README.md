# Cloud Engineer Challenge - Main API & Auxiliary Service

## Description
Déploiement d'un projet microservices avec **Main API** et **Auxiliary Service**, intégrant Kubernetes, Argo CD, Terraform et AWS.  

- **Main API** : expose les endpoints AWS (S3, Parameter Store) et communique avec Auxiliary Service.  
- **Auxiliary Service** : gère les interactions avec AWS et fournit les données au Main API.

---

## Prérequis
- Kubernetes (Minikube ou Kind)  
- `kubectl` installé et configuré  
- Helm (optionnel pour simplifier les déploiements)  
- Argo CD (optionnel pour gestion déclarative)  
- Docker et accès à AWS ECR  
- GitHub Actions pour CI/CD  

---

## Structure du projet

```bash
projet/
├── Terraform/
│   ├── modules/
│   │   ├── s3/
│   │   ├── parameter_store/
│   │   └── service_account/
│   ├── main.tf
│   └── variables.tf
├── api/
│   ├── Dockerfile
│   ├── main.py
│   └── requirements.txt
├── auxiliary/
│   ├── Dockerfile
│   ├── main.py
│   └── requirements.txt
├── kubernetes/
│   ├── api/
│   │   ├── Chart.yaml
│   │   └── templates/
│   └── auxiliary/
│       ├── Chart.yaml
│       └── templates/
└── README.md
```

## Terraform
 # Modules

- s3/ : création des buckets S3 pour stockage des données.
- parameter_store/ : création des paramètres AWS (ex: secrets ou configurations) dans Parameter Store.
- service_account/ : création des IAM Roles et policies pour permettre aux pods d’accéder aux services AWS.

 #Variables

- region : région AWS où déployer les ressources
- bucket_name : nom du bucket S3
- parameter_name : nom du paramètre AWS
- service_account_name : nom du rôle IAM pour les pods

 # Exemple d’utilisation

```bash
cd Terraform
terraform init
terraform apply
```

## Image Docker
```bash
# Build les images
docker build -t auxiliary-service:latest ./auxiliary
docker build -t main-api:latest ./api


# Login dans AWS ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 231838751459.dkr.ecr.us-east-1.amazonaws.com

# Tagger et push
docker tag auxiliary-service:latest 231838751459.dkr.ecr.us-east-1.amazonaws.com/auxiliary-service:latest
docker tag main-api:latest 231838751459.dkr.ecr.us-east-1.amazonaws.com/main-api:latest

docker push 231838751459.dkr.ecr.us-east-1.amazonaws.com/auxiliary-service:latest
docker push 231838751459.dkr.ecr.us-east-1.amazonaws.com/main-api:latest
```


## Déploiement Kubernetes
# Création des namespaces
```bash
kubectl create ns main-api
kubectl create ns auxiliary
```

# Déploiement avec Helm
```bash
helm upgrade --install auxiliary ./kubernetes/auxiliary -n auxiliary
helm upgrade --install main-api ./kubernetes/api -n main-api
```

# Vérification
```bash
kubectl get pods -n auxiliary
kubectl get pods -n main-api
kubectl get svc -n auxiliary
kubectl get svc -n main-api
```

## Configuration des services

- Auxiliary Service : port 8082 (ClusterIP)
- Main API : port 8080 (ClusterIP)

Versions incluses dans chaque réponse JSON :

```json
{
  "version":"main-api-1.0.0",
  "auxiliary-version":"auxiliary-1.0.0"
}
```

## Test des services
 # Auxiliary Service
```bash
kubectl exec -it <main-api-pod> -n main-api -- curl http://auxiliary-svc.auxiliary.svc.cluster.local:8082/version
```

# Main API
```bash
curl http://<main-api-service>:<port>/buckets
curl http://<main-api-service>:<port>/parameters
curl http://<main-api-service>:<port>/parameters/<name>
```


## Argo CD 

# Installer Argo CD dans le cluster :
```bash
kubectl create ns argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

# Déclarer les applications :
```bash
kubectl apply -f kubernetes/argocd/main-api-app.yaml
kubectl apply -f kubernetes/argocd/auxiliary-app.yaml
```

# Vérifier le déploiement via UI ou CLI :
```bash
argocd app list
argocd app get main-api
```
<img width="953" height="405" alt="image" src="https://github.com/user-attachments/assets/425be9b0-ab5d-49b1-b99d-2ce88d2c1906" />

## CI/CD GitHub Actions

Workflow typique :
- Build & Push Docker Images vers AWS ECR
- Update Deployments Kubernetes via kubectl ou Helm
- Update ConfigMap pour versioning des services

```yaml

name: CI/CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Login to ECR
        uses: aws-actions/amazon-ecr-login@v1
      - name: Build & Push Docker images
        run: |
          docker build -t main-api ./api
          docker tag main-api:latest <ECR_REPO>/main-api:latest
          docker push <ECR_REPO>/main-api:latest
      - name: Deploy to Kubernetes
        run: |
          kubectl apply -f k8s/deployment.yaml
```

Observabilité (Prometheus & Grafana)

```bash
kubectl create ns monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm install prometheus prometheus-community/prometheus -n monitoring
helm install grafana grafana/grafana -n monitoring \
  --set adminUser=admin \
  --set adminPassword=admin \
  --set service.type=NodePort
```

- Grafana : minikube service grafana -n monitoring
- Prometheus : kubectl --namespace monitoring port-forward svc/prometheus-server 9090

## Notes importantes

L’accès AWS se fait via OIDC/GitHub ou IAM Roles temporaires pour plus de sécurité.


