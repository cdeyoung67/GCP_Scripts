#!/bin/bash

kubectl delete services --all 
gcloud -q container clusters delete vary-demo-1 --zone us-central1-b

echo "k8s cluster destroyed"
