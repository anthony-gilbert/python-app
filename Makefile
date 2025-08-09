APP_NAME=python-app
TAG=local
IMAGE=$(APP_NAME):$(TAG)
KUBE_DIR=kube-configs

.PHONY: start build load deploy redeploy ingress service-url ingress-host add-hosts logs clean

start:
	minikube start
	minikube addons enable ingress

# Build image using Minikube's Docker daemon for fastest iteration
build:
	@eval "$(shell minikube docker-env)" && docker build -t $(IMAGE) .

# If you built locally without minikube docker-env, load it into the cluster
load:
	minikube image load $(IMAGE)

deploy:
	kubectl apply -f $(KUBE_DIR)/deployment.yml
	kubectl apply -f $(KUBE_DIR)/srvc.yml

redeploy: build deploy

ingress:
	kubectl apply -f $(KUBE_DIR)/ingress.yml

service-url:
	minikube service $(APP_NAME) --url

# Get Minikube IP and print a hosts entry for Ingress usage (app.local)
ingress-host:
	@echo "$$(/bin/sh -c 'minikube ip') app.local"

# Append hosts entry (requires sudo)
add-hosts:
	MINIKUBE_IP=$$(minikube ip); echo "$$MINIKUBE_IP app.local" | sudo tee -a /etc/hosts

logs:
	kubectl logs -l app=$(APP_NAME) -f --tail=200

clean:
	kubectl delete -f $(KUBE_DIR)/ingress.yml || true
	kubectl delete -f $(KUBE_DIR)/srvc.yml || true
	kubectl delete -f $(KUBE_DIR)/deployment.yml || true
