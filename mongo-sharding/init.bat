docker exec -i configSrv mongosh --port 27017 --eval "rs.initiate({_id : 'config_server', configsvr: true, members: [{ _id : 0, host : 'configSrv:27017' }]}); exit();"
docker exec -i shard1 mongosh --port 27018 --eval "rs.initiate({_id : 'shard1', members: [{ _id : 0, host : 'shard1:27018' }]}); exit();"
docker exec -i shard2 mongosh --port 27019 --eval "rs.initiate({_id : 'shard2', members: [{ _id : 1, host : 'shard2:27019' }]}); exit();"

docker exec -i mongos_router_1 mongosh --port 27020 --eval "sh.addShard('shard1/shard1:27018'); sh.addShard('shard2/shard2:27019'); sh.enableSharding('somedb'); sh.shardCollection('somedb.helloDoc', { 'name' : 'hashed' }); exit();"

docker exec -i mongos_router_2 mongosh --port 27021 --eval "sh.addShard('shard1/shard1:27018'); sh.addShard('shard2/shard2:27019'); sh.enableSharding('somedb'); sh.shardCollection('somedb.helloDoc', { 'name' : 'hashed' }); use('somedb'); for(var i = 0; i < 1000; i++) db.helloDoc.insert({age:i, name:'ly'+i}); exit();"