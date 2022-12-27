FROM tomcat:8.0.20-jre8

COPY target/myjob*.war /usr/local/tomcat/webapps/myjob.war
