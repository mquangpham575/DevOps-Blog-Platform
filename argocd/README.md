# ArgoCD Configuration

This folder contains ArgoCD resources used by the platform.

## Files

- `project.yaml`: ArgoCD AppProject (`blog-platform`)
- `postgres.yaml`: ArgoCD Application for Bitnami PostgreSQL Helm Chart
- `seaweedfs.yaml`: ArgoCD Application for official SeaweedFS Helm Chart
- `blog-app.yaml`: ArgoCD Application for `k8s/overlays/dev` to namespace `blog-app`
- `monitoring.yaml`: ArgoCD Application for `k8s/monitoring` to namespace `monitoring`
- `ingress.yaml`: Ingress for ArgoCD server at `argocd.local`
- `gitlab-repo-secret.yaml.template`: template for Git repository credential secret

## Setup

1. Install ArgoCD in cluster:

```bash
bash scripts/argocd-install.sh
```

2. Create repo secret from template:

```bash
cp argocd/gitlab-repo-secret.yaml.template argocd/gitlab-repo-secret.yaml
```

3. Fill in credentials in `argocd/gitlab-repo-secret.yaml`:

- Replace `<YOUR_GITLAB_PAT_TOKEN>` with your GitLab PAT.
- Keep the repo URL and username aligned with your repository.

4. Apply secret and applications:

```bash
kubectl apply -f argocd/gitlab-repo-secret.yaml
kubectl apply -f argocd/project.yaml
kubectl apply -f argocd/postgres.yaml
kubectl apply -f argocd/seaweedfs.yaml
kubectl apply -f argocd/blog-app.yaml
kubectl apply -f argocd/monitoring.yaml
```

## Access

- ArgoCD URL: `https://argocd.local:8443`
- Host entry (local): `127.0.0.1 argocd.local`

Get initial admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## Secret Safety

- Do not commit `argocd/gitlab-repo-secret.yaml`.
- Commit only `argocd/gitlab-repo-secret.yaml.template`.
- `.gitignore` already excludes local secret files.
