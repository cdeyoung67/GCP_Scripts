#!/bin/bash -x

#update
gcloud --quiet components update

#Auth
gcloud -q config set project vary-demo

gcloud -q auth activate-service-account --key-file /Users/cdeyoung/Vary-demo-766c9156a8f3.json

#Load services & APIs
gcloud -q services enable compute.googleapis.com; gcloud -q services enable container.googleapis.com

#Create Cluster & app
gcloud -q components install kubectl
gcloud -q container clusters create vary-demo-1 -z us-central1-b
#kubectl run web-app --image gcr.io/google-samples/hello-app:1.0 --port 8080
#kubectl run nginx --image nginx 
#kubectl scale deployment nginx --replicas 3; kubectl get pods
#kubectl expose deployment nginx --port=80 --target-port=8080 --type=LoadBalancer
Kubectl run nginx-chris --image cdeyoung67/vary:varytry --port 80
kubectl scale deployment nginx-chris --replicas 3; sleep 10; kubectl get pods
kubectl expose deployment nginx-chris --type LoadBalancer --port 80

kubectl apply -f kubernetes-ci-cd/manifests/registry.yml
#kubectl expose deployment registry-ui --type LoadBalancer --port 8080
kubectl expose deployment registry --type=LoadBalancer --name=registry-ui-service






echo "Ended Prematurly for test"
exit

#kubectl expose deployment nginx --type NodePort --port 80

kubectl apply -f kubernetes-ci-cd/manifests/registry.yml
kubectl rollout status deployments/registry


#echo "sleeping 30 seconds to assure app is installed"
# sleep 30

kubectl get pods

#Scaling cluster
#kubectl scale deployment web-app --replicas 3; kubectl get pods
#kubectl expose deployment web-app --port=80 --target-port=8080 --type=LoadBalancer

#echo "sleeping 60"
#sleep 60

#kubectl get service web-app

###How to delete###

echo "once demo is complete:   1. kubectl delete services --all  2.  cloud -q container clusters delete vary-demo-1 --zone us-central1-b"
echo "to conect to k8s console type kubectl proxy"
