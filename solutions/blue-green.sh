#!/bin/bash
kubectl delete svc green-svc
kubectl apply -f ../starter/apps/blue-green/green.yml
kubectl apply -f ./green-svc.yml


# declare -r GREEN="$(kubectl get svc green-svc -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')"
# echo "$(curl -s -o /dev/null -L -w ''%{http_code}'' ${GREEN})" != "200"
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' "$(kubectl get svc green-svc -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')")" != "200" ]];
do
echo "Waiting for server"
sleep 5
done
curl "$(kubectl get svc green-svc -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')"