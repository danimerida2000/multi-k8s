docker build -t danimerida2000/multi-client:latest -t danimerida2000/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t danimerida2000/multi-server:latest -t danimerida2000/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t danimerida2000/multi-worker:latest -t danimerida2000/multi-worker:$SHA -f ./client/Dockerfile ./worker
docker push danimerida2000/multi-client:latest
docker push danimerida2000/multi-server:latest
docker push danimerida2000/multi-worker:latest
docker push danimerida2000/multi-client:$SHA
docker push danimerida2000/multi-server:$SHA
docker push danimerida2000/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=danimerida2000/multi-server:$SHA
kubectl set image deployments/client-deployment server=danimerida2000/multi-client:$SHA
kubectl set image deployments/worker-deployment server=danimerida2000/multi-worker:$SHA
