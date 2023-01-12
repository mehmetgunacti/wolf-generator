version: "3.7"

services:

<#if appComponents.backend.springBoot.run>
  springboot:
    container_name: ${ info.artifactId }-springboot
    build: ../backend/springboot
    ports:
      - "8080:8080"
    volumes:
      - ${ info.artifactId }-logs:/app/logs
    networks:
      - ${ info.artifactId }-network
    <#if appComponents.database.mysql.run>
    depends_on:
      - mysql
    </#if>
</#if>

<#if appComponents.frontend.angular.run>
  angular:
    container_name: ${ info.artifactId }-angular
    build: ../frontend/angular
    ports:
      - "4500:80"
    networks:
      - ${ info.artifactId }-network
    <#if appComponents.backend.springBoot.run>
    depends_on:
      - springboot
    </#if>
</#if>

<#if appComponents.database.mysql.run>
  mysql:
    container_name: ${ info.artifactId }-mysql
    build:
      context: ../database/mysql
      dockerfile: mysql.dockerfile
    volumes:
      - ${ info.artifactId }-mysql:/var/lib/mysql
    networks:
      - ${ info.artifactId }-network
    ports:
      - "3306:3306"
    restart: always

  <#if appComponents.database.mysql.phpMyAdmin>
  phpmyadmin:
    container_name: ${ info.artifactId }-phpmyadmin
    build:
      context: ../database/mysql
      dockerfile: phpMyAdmin.dockerfile
    restart: always
    environment:
      PMA_HOST: mysql
      PMA_PORT: 3306
    ports:
      - "7500:80"
    networks:
      - ${ info.artifactId }-network
    depends_on:
      - mysql
    </#if>
</#if>

volumes:
  <#if appComponents.database.mysql.run>${ info.artifactId }-mysql:</#if>
  ${ info.artifactId }-logs:

networks:
  ${ info.artifactId }-network:

<#--
  adminer:
    image: adminer
    restart: always
    ports:
      - "7000:8080"
    networks:
      - ${ info.artifactId }-network
    depends_on:
      - mysql
-->