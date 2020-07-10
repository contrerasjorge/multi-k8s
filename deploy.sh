docker build -t contrerasjorge/multi-client:latest -f ./client/Dockerfile -t contrerasjorge/multi-client:$SHA ./client
docker build -t contrerasjorge/multi-server:latest -f ./server/Dockerfile -t contrerasjorge/multi-server:$SHA ./server
docker build -t contrerasjorge/multi-worker:latest -f ./worker/Dockerfile -t contrerasjorge/multi-worker:$SHA ./worker

docker push contrerasjorge/multi-client:latest
docker push contrerasjorge/multi-server:latest
docker push contrerasjorge/multi-worker:latest

docker push contrerasjorge/multi-client:$SHA
docker push contrerasjorge/multi-server:$SHA
docker push contrerasjorge/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=contrerasjorge/multi-server:$SHA
kubectl set image deployments/client-deployment client=contrerasjorge/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=contrerasjorge/multi-worker:$SHA