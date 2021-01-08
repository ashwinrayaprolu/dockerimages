# Solr Cluster 

## Using default solr provided docker compose

Below docker file was not updated to fix zookeeper connection issue
```
mkdir /opt/mycluster
cd /opt/mycluster

curl --output docker-compose.yml https://raw.githubusercontent.com/docker-solr/docker-solr-examples/master/docker-compose/docker-compose.yml

docker-compose up -d
```

## Using file provided in this repo

```
docker-compose -f docker-compose-solr.yml up -d
```

**Create a collection*
```
docker exec -it --user=solr solr1 bin/solr create_collection -c gettingstarted
```

**Post example data to collection *
```
docker exec -it --user=solr solr1 bin/post -c gettingstarted example/exampledocs/manufacturers.xml
```

**Create a Data Import Handler Collection*

```
docker exec -it --user=solr solr1 bin/solr create_collection -c dih
```