#ARG ubuntu_version=18.04
#FROM ubuntu:${ubuntu_version}
#Use ubuntu 18:04 as your base image
FROM ubuntu:latest
#Any label to recognise this image.
LABEL image=Spark-base-image
ENV SPARK_VERSION=2.4.6
ENV HADOOP_VERSION=2.7
RUN date –s 20-08-01 30:00:00
#Run the following commands on my Linux machine
#install the below packages on the ubuntu image
RUN apt-get update && apt-get -y install gnupg2 wget openjdk-8-jdk scala
#Download the Spark binaries from the repo
WORKDIR /
# RUN wget --no-verbose http://www.gtlib.gatech.edu/pub/apache/spark/spark-2.4.1/spark-2.4.1-bin-hadoop2.7.tgz
RUN wget --no-verbose http://www.trieuvan.com/apache/spark/spark-2.4.6/spark-2.4.6-bin-hadoop2.7.tgz
# Untar the downloaded binaries , move them the folder name spark and add the spark bin on my class path
RUN tar -xzf /spark-2.4.6-bin-hadoop2.7.tgz && \
    mv spark-2.4.6-bin-hadoop2.7 spark && \
    echo "export PATH=$PATH:/spark/bin" >> ~/.bashrc
#Expose the UI Port 4040
EXPOSE 4040
