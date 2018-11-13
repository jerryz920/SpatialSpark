bin/spark-submit \
  --master k8s://https://192.3.0.7:6443 \
  --deploy-mode cluster \
  --name spatial-spark \
  --class spatialspark.main.SpatialJoinApp \
  --conf spark.kubernetes.namespace=spark \
  --conf spark.executor.instances=5 \
  --conf spark.kubernetes.container.image=spark:v2.3 \
  --conf spark.kubernetes.authenticate.submission.caCertFile=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
  --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
  --conf spark.kubernetes.driver.pod.name=spatial-spark \
  "http://192.3.0.7:12345/examples/spatial-spark.jar" \
  --left hdfs://hdfs-1.latte.org:8020/data/point1k.tsv \
  --right hdfs://hdfs-1.latte.org:8020/data/nycb.tsv \
  --geom_left 1 --geom_right 0 --output hdfs://hdfs-1.latte.org:8020/data/output.tsv \
  --broadcast false --predicate within --method stp --conf 32:32:0.1 \
  --parallel_part false \

