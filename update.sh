
target=spark-2.3.2-bin-custom-spark
sbt assembly
for n in ./target/scala-2.*/spatial-spark-assembly-*.jar; do
docker-machine  scp $n master:$target/
done
