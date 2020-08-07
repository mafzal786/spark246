# ARG ubuntu_version=16.04
#FROM ubuntu:${ubuntu_version}
#Use ubuntu 18:04 as your base image
FROM centos:centos7
#Any label to recognise this image.
#LABEL image=Spark-base-image
ENV SPARK_VERSION 2.4.6
ENV HADOOP_VERSION 2.7
ENV NB_USER=nbuser
ENV NB_UID=1011
#Run the following commands on my Linux machine
#install the below packages on the ubuntu image
RUN yum -y update && yum -y install gnupg2 wget java-1.8.0-openjdk java-1.8.0-openjdk-devel scala
#Download the Spark binaries from the repo

# RUN wget --no-verbose http://www.gtlib.gatech.edu/pub/apache/spark/spark-2.4.1/spark-2.4.1-bin-hadoop2.7.tgz
RUN wget --no-verbose http://www.trieuvan.com/apache/spark/spark-2.4.6/spark-2.4.6-bin-hadoop2.7.tgz
# Untar the downloaded binaries , move them the folder name spark and add the spark bin on my class path
RUN tar -xzf /spark-2.4.6-bin-hadoop2.7.tgz && \
    mv spark-2.4.6-bin-hadoop2.7 spark && \
    echo "export PATH=$PATH:/spark/bin" >> ~/.bashrc
#Expose the UI Port 4040

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini


EXPOSE 4040

ENV HOME /home/$NB_USER
USER $NB_UID


WORKDIR /
# ENTRYPOINT ["/tini", "--"]
ENTRYPOINT ["tail", "-f", "/dev/null"]

