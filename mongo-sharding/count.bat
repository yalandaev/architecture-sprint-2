docker exec -i mongos_router_2 mongosh --port 27021 --eval "use('somedb'); print('All documents: ' + db.helloDoc.countDocuments());"
docker exec -i shard1 mongosh --port 27018 --eval "use('somedb'); print('shard1: ' + db.helloDoc.countDocuments());"
docker exec -i shard2 mongosh --port 27019 --eval "use('somedb'); print('shard2: ' + db.helloDoc.countDocuments());"