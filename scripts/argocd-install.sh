#!/bin/bash
# Install ArgoCD into the k3d/k3s cluster
# Run AFTER k3d-setup.sh

set -euo pipefail

echo "=== Installing ArgoCD ==="

# Install ArgoCD CLI
if [ ! -f /usr/local/bin/argocd ]; then
  echo "Installing ArgoCD CLI..."
  sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/stable/argocd-linux-amd64
  sudo chmod +x /usr/local/bin/argocd
fi

# Create namespace first
kubectl create namespace argocd || true

# Install ArgoCD
kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for ArgoCD to be ready
echo "Waiting for ArgoCD server to be ready..."
kubectl wait --namespace argocd \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/name=argocd-server \
  --timeout=300s

# Configure ArgoCD server to run insecurely (so nginx ingress can terminate TLS)
kubectl patch deployment argocd-server \
  -n argocd \
  --type='json' \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--insecure"}]'

# Apply the Ingress for ArgoCD
kubectl apply -f argocd/ingress.yaml

# Get initial admin password
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo ""
echo "=== ArgoCD installed via Ingress! ==="
echo ""
echo "IMPORTANT: Add the following line to your /etc/hosts file:"
echo "127.0.0.1 argocd.local"
echo ""
echo "Access:  https://argocd.local:8443"
echo "User:    admin"
echo "Password: $ARGOCD_PASSWORD"
echo ""
echo "Next steps:"
echo "  1. Add your GitLab repo to ArgoCD:"
echo "     argocd login argocd.local:8443 --username admin --password '$ARGOCD_PASSWORD'"
echo "     argocd repo add https://gitlab.com/mquangpham575/DevOps.git \\"
echo "       --username <gitlab-user> \\"
echo "       --password <personal-access-token>"
echo ""
echo "  2. Or use kubectl to check applications:"
echo "     kubectl get application -n argocd"
echo "     kubectl get application blog-app -n argocd"
