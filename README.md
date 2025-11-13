***

# 🎼 Music Store Microservice on AWS EKS

A cloud-native, production-ready web app deployed on Amazon EKS.  
This project demonstrates Kubernetes orchestration, automated HTTPS, CI/CD, dynamic DNS, and scalable infrastructure using modern DevOps practices.

***

## 🚀 Live Demo

- **Application:** https://github.com/user-attachments/assets/c192fb3c-0ae4-4c32-9a5d-4390197a09e7
- **Domain:** [https://musicstore.duckdns.org](https://musicstore.duckdns.org) (*currently offline / demo*)
- **AWS Region:** `us-east-1`
- **Container Registry:** Amazon ECR

***

## 🧰 Tech Stack Overview

| Component       | Purpose                              | Notes                      |
|-----------------|--------------------------------------|----------------------------|
| AWS EKS         | Managed Kubernetes cluster           | Cloud orchestration        |
| Docker & ECR    | App containerization and registry    | Private image hosting      |
| NGINX Ingress   | HTTPS routing, load balancing        | Helm install               |
| AWS NLB         | Network Load Balancer (external)     | Managed by EKS             |
| cert-manager    | TLS certificate automation           | Let’s Encrypt integration  |
| DuckDNS         | Dynamic DNS routing                  | Maps domain → NLB IP       |
| Helm            | Kubernetes package management        | Chart installs             |
| GitHub Actions  | CI/CD pipeline                      | Build > ECR > Deploy       |

***

## 🏗️ Architecture

### Flow Overview

[User] ⇄ [musicstore.duckdns.org] ⇄ [AWS NLB] ⇄ [NGINX Ingress] ⇄ [K8s Service] ⇄ [Pods]

- cert-manager provisions TLS via Let’s Encrypt for HTTPS on Ingress
- DuckDNS keeps domain records current with NLB’s external IP
- GitHub Actions builds & pushes images, deploys to cluster

***

## ⚙️ Prerequisites

- `kubectl`, `awscli`, `eksctl`, `helm` (latest versions)
- DuckDNS domain mapped to NLB

***

## 🚀 Deployment Steps

1. **Create EKS Cluster**
   ```bash
   eksctl create cluster --name music-store --region us-east-1 --nodes 2
   aws eks update-kubeconfig --region us-east-1 --name music-store
   kubectl get nodes
   ```
2. **Deploy Application**
   ```bash
   kubectl apply -f k8s/deployment.yaml -n music-store
   kubectl apply -f k8s/service.yaml -n music-store
   ```
3. **Configure HTTPS & Ingress**
   ```bash
   kubectl apply -f k8s/cluster-issuer.yaml
   kubectl apply -f k8s/ingress.yaml -n music-store
   kubectl get certificate -n music-store # READY: True
   ```
4. **Validate DNS & HTTPS**
   - Check NLB entry with DuckDNS
   - Access via browser at https://musicstore.duckdns.org

***

## 🧩 CI/CD Automation

- **Build:** Docker images for the app
- **Publish:** Push images to ECR
- **Deploy:** Kubectl applies to EKS cluster
- *GitHub Actions handles all CI/CD workflow, including AWS credentials and Kubernetes manifests*

***

## 🛡️ Security & Scalability

- Automated HTTPS certificates (cert-manager + Let’s Encrypt)
- RBAC & IAM for cluster access
- Images in private ECR registry
- Pod autoscaling & update strategies supported (HPA; ready for rolling/blue-green)

***

## 👨‍💻 Author & Contributers: Kkrish Singh, Kaustubh Chavan, Utkarsh Vanjari
  
**MIT License** – Free to use and modify
