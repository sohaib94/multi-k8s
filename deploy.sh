docker build -t sohaibashraf/multi-client:latest -t sohaibashraf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sohaibashraf/multi-server:latest -t sohaibashraf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sohaibashraf/multi-worker:latest -t sohaibashraf/multi-worker:$SHA -f ./server/Dockerfile ./worker

docker push sohaibashraf/multi-client:latest
docker push sohaibashraf/multi-server:latest
docker push sohaibashraf/multi-worker:latest

docker push sohaibashraf/multi-client:$SHA
docker push sohaibashraf/multi-server:$SHA
docker push sohaibashraf/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sohaibashraf/multi-server:$SHA
kubectl set image deployments/client-deployment client=sohaibashraf/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sohaibashraf/multi-worker:$SHA