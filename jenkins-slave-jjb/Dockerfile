FROM openshift/jenkins-slave-base-centos7:latest
MAINTAINER Ladislav Thon <lthon@redhat.com>

USER root

RUN yum -y install epel-release && \
    yum -y install python-pip && \
    yum clean all -y && \
    pip install --upgrade pip six 'jenkins-job-builder>=2.0.0' && \
    sed -i "s/return b'Basic ' + base64.b64encode(auth)/return b'Bearer ' + password/" /usr/lib/python2.7/site-packages/jenkins/__init__.py

COPY jenkins_jobs.ini /etc/jenkins_jobs/
COPY jjb /usr/local/bin/

USER 1001
