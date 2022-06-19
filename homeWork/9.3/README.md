# Домашнее задание к занятию "09.03 CI\CD"


## Знакомоство с SonarQube

Скриншот успешного прохождения анализа SonarQube

![alt text](https://github.com/avloton/devops-netology/blob/main/homeWork/9.3/img/sonar.png?raw=true)

## Знакомство с Nexus

Файл maven-metadata.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<metadata modelVersion="1.1.0">
  <groupId>netology</groupId>
  <artifactId>java</artifactId>
  <versioning>
    <latest>8_282</latest>
    <release>8_282</release>
    <versions>
      <version>8_102</version>
      <version>8_282</version>
    </versions>
    <lastUpdated>20220619123224</lastUpdated>
  </versioning>
</metadata>
```

## Знакомство с Maven

Файл pom.xml

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
 
  <groupId>com.netology.app</groupId>
  <artifactId>simple-app</artifactId>
  <version>1.0-SNAPSHOT</version>
   <repositories>
    <repository>
      <id>my-repo</id>
      <name>maven-releases</name>
      <url>http://51.250.105.94:8081/repository/maven-releases/</url>
    </repository>
  </repositories>
  <dependencies>
    <dependency>
      <groupId>netology</groupId>
      <artifactId>java</artifactId>
      <version>8_282</version>
      <classifier>distrib</classifier>
      <type>jar</type>
    </dependency>
  </dependencies>
</project>
```