# BASF  🚀

Welcome to the **BASF challenege** repository! This beta version is crafted with a blend of technologies and tools to facilitate streamlined deployments, 

## how to use 🌟

## prequisities
1- docker-ce, for building and running the image
2- python 3.8, preferbly installed in a conda env if you wish to test the app locally 
3- HARDware , 15GB of memory, ......

### how to the project structured 
- **make**: run ```make help`` for more information 
- **Terraform Files**: constructed modular or the aks,kuberenetes, congintive-services and also integrated with kustomize, checkout ./terraform/README.ME
- **Kustomize Files**: we have base project and dev verions, dev version spin up a deployment specifically for the development, 
- **Makefile**: A powerful tool to simplify Docker builds and orchestrate your deployments, be it locally or in a Kubernetes cluster.

## Project Structure 📂

```plaintext
Exam-Project/
├── Docker/
│   ├── Dockerfile
│   └── ...
├── Terraform/
│   ├── main.tf
│   └── ...
├── Kustomize/
│   ├── kustomization.yaml
|──src/dolly-v2-3b "source codes, model archiver, model runner API :8000/production <accept [POST] body txt instruction>"
│   └── ...
└── MAKEFILE




