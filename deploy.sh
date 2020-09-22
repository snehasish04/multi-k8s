docker build -t snehasish4/multi-client:latest -t snehasish4/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t snehasish4/muiti-server:latest -t snehasish4/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t snehasish4/multi-worker:latest -t snehasish4/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push snehasish4/multi-client:latest
docker push snehasish4/multi-server:latest
docker push snehasish4/multi-worker:latest

docker push snehasish4/multi-client:$SHA
docker push snehasish4/multi-server:$SHA
docker push snehasish4/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=snehasish4/multi-server:$SHA
kubectl set image deployments/client-deployment client=snehasish4/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=snehasish4/multi-worker:$SHA