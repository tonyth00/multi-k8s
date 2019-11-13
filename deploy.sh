docker build -t tonyth00/multi-client:latest -t tonyth00/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tonyth00/multi-server:latest -t tonyth00/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tonyth00/multi-worker:latest -t tonyth00/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tonyth00/multi-client:latest
docker push tonyth00/multi-server:latest
docker push tonyth00/multi-worker:latest

docker push tonyth00/multi-client:$SHA
docker push tonyth00/multi-server:$SHA
docker push tonyth00/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=tonyth00/multi-server:$SHA
kubectl set image deployments/client-deployment client=tonyth00/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tonyth00/multi-worker:$SHA