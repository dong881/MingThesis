# Installation Guide

## Minimum Requirements

| Component       | Requirement                  |
|-----------------|------------------------------|
| **K8s Cluster** | v1.20+, Access to Host Network|
| **Storage**     | PVC support (optional for persistence)|
| **Network**     | Flat network ensuring Pod can SSH to OAI servers|

## System Setup

### 1. Clone Repository
```bash
git clone https://github.com/your-repo/ming-nfapi-debugger.git
cd ming-nfapi-debugger
```

### 2. Configure Values
Edit `deploy/nfapi-debugger/values.yaml` to match your environment.

```yaml
global:
  servers:
    cn_server:
      host: "192.168.1.10"
      user: "ubuntu"
      identity_file: "/root/.ssh/id_rsa"
    pnf_server:
      host: "192.168.1.11"
      user: "root"
    vnf_server:
      host: "192.168.1.10"
      user: "root"

rapp:
  config:
    active_selection:
      pc: "your_pc_name"
      ue: "your_ue_name"
```

### 3. Deploy via Helm
Use the provided rebuild script or Helm directly.

```bash
# Using helper script
./rebuild.sh

# OR using Helm
helm install nfapi-debugger ./deploy/nfapi-debugger -n default
```

### 4. Verify Deployment
Check if the pod is running:

```bash
kubectl get pods -l app=nfapi-debugger
```

Access the shell if needed:
```bash
kubectl exec -it <pod-name> -- bash
```
