docker build -t bblaise/multi-client:latest -t bblaise/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bblaise/multi-server:latest -t bblaise/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bblaise/multi-worker:latest -t bblaise/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bblaise/multi-client:latest
docker push bblaise/multi-server:latest 
docker push bblaise/multi-worker:latest

docker push bblaise/multi-client:$SHA
docker push bblaise/multi-server:$SHA 
docker push bblaise/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bblaise/multi-server:$SHA
kubectl set image deployments/client-deployment client=bblaise/multi-clien:$SHA
kubectl set image deployments/worker-deployment worker=bblaise/multi-worker:$SHA