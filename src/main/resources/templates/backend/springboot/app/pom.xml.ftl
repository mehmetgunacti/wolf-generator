<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		 xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>

	<groupId>${ info.groupId }</groupId>
	<artifactId>${ info.artifactId }</artifactId>
	<name>${ info.title }</name>
	<description>${ info.description }</description>
	<version>1.0-SNAPSHOT</version>

	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>${ version.springBootStarterParent }</version>
		<relativePath/>
	</parent>

	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
		<java.version>${ version.javaVersion }</java.version>
		<openapi.version>${ version.openApi }</openapi.version>
		<mockito.version>${ version.mockito }</mockito.version>
		<mybatis-spring-boot-starter.version>${ version.mybatisSpringBootStarter }</mybatis-spring-boot-starter.version>
		<mybatis.version>${ version.mybatis }</mybatis.version>
		<apache.poi-ooxml.version>${ version.apachePoiOoxml }</apache.poi-ooxml.version>
		<apache.commons-lang3.version>${ version.apacheCommonsLang3 }</apache.commons-lang3.version>
		<flying-saucer-pdf-openpdf.version>${ version.flyingSaucerPdfOpenpdf }</flying-saucer-pdf-openpdf.version>
		<jjwt.version>${ version.jjwt }</jjwt.version>
		<lombok.version>${ version.lombok }</lombok.version>
		<spring-restdocs.version>${ version.springRestdocs }</spring-restdocs.version>
		<asciidoctor.version>${ version.asciidoctor }</asciidoctor.version>
		<spring-messaging.version>${ version.springMessaging }</spring-messaging.version>
	</properties>

	<dependencies>

		<!-- *************************************** -->
		<!-- SPRING BOOT STARTER WEB -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>

		<!-- *************************************** -->
		<!-- SECURITY -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-security</artifactId>
		</dependency>

		<!-- *************************************** -->
		<!-- VALIDATION -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-validation</artifactId>
		</dependency>

		<!-- *************************************** -->
		<!-- QUARTZ -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-quartz</artifactId>
		</dependency>

		<!-- *************************************** -->
		<!-- THYMELEAF -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-thymeleaf</artifactId>
		</dependency>

		<!-- *************************************** -->
		<!-- EMAIL -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-mail</artifactId>
		</dependency>

		<!-- *************************************** -->
		<!-- ACTUATOR -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-actuator</artifactId>
		</dependency>

		<!-- *************************************** -->
		<!-- LIQUIBASE -->
		<!-- *************************************** -->
		<!--<dependency>-->
		<!--	<groupId>org.liquibase</groupId>-->
		<!--	<artifactId>liquibase-core</artifactId>-->
		<!--</dependency>-->

		<!-- *************************************** -->
		<!-- APACHE POI for Excel  -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.apache.poi</groupId>
			<artifactId>poi-ooxml</artifactId>
			<version>${r"${apache.poi-ooxml.version}"}</version>
		</dependency>

		<!-- *************************************** -->
		<!-- APACHE Commons Lang for Pwd Generator  -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.apache.commons</groupId>
			<artifactId>commons-lang3</artifactId>
			<version>${r"${apache.commons-lang3.version}"}</version>
		</dependency>


		<!-- *************************************** -->
		<!-- FLYING SAUCER PDF -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.xhtmlrenderer</groupId>
			<artifactId>flying-saucer-pdf-openpdf</artifactId>
			<version>${r"${flying-saucer-pdf-openpdf.version}"}</version>
		</dependency>

		<!-- *************************************** -->
		<!-- SECURITY : JSON WEB TOKEN JWT -->
		<!-- *************************************** -->
		<dependency>
			<groupId>io.jsonwebtoken</groupId>
			<artifactId>jjwt-api</artifactId>
			<version>${r"${jjwt.version}"}</version>
		</dependency>
		<dependency>
			<groupId>io.jsonwebtoken</groupId>
			<artifactId>jjwt-impl</artifactId>
			<version>${r"${jjwt.version}"}</version>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>io.jsonwebtoken</groupId>
			<artifactId>jjwt-jackson</artifactId>
			<version>${r"${jjwt.version}"}</version>
			<scope>runtime</scope>
		</dependency>

		<!-- *************************************** -->
		<!-- MYSQL JDBC DRIVER -->
		<!-- *************************************** -->
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<scope>runtime</scope>
		</dependency>

		<!-- *************************************** -->
		<!-- MYBATIS -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.mybatis.spring.boot</groupId>
			<artifactId>mybatis-spring-boot-starter</artifactId>
			<version>${r"${mybatis-spring-boot-starter.version}"}</version>
		</dependency>
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis</artifactId>
			<version>${r"${mybatis.version}"}</version>
		</dependency>

		<!-- *************************************** -->
		<!-- OpenAPI -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.springdoc</groupId>
			<artifactId>springdoc-openapi-data-rest</artifactId>
			<version>${r"${openapi.version}"}</version>
		</dependency>
		<dependency>
			<groupId>org.springdoc</groupId>
			<artifactId>springdoc-openapi-ui</artifactId>
			<version>${r"${openapi.version}"}</version>
		</dependency>

		<!-- *************************************** -->
		<!-- LOMBOK -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.projectlombok</groupId>
			<artifactId>lombok</artifactId>
			<version>${r"${lombok.version}"}</version>
			<optional>true</optional>
		</dependency>

		<!-- *************************************** -->
		<!-- WebSocket -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-websocket</artifactId>
			<version>${r"${spring-messaging.version}"}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-messaging</artifactId>
			<version>${r"${spring-messaging.version}"}</version>
		</dependency>

		<!-- *************************************** -->
		<!-- TESTS -->
		<!-- *************************************** -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>org.springframework.restdocs</groupId>
			<artifactId>spring-restdocs-mockmvc</artifactId>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>org.mockito</groupId>
			<artifactId>mockito-core</artifactId>
			<version>${r"${mockito.version}"}</version>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>org.mockito</groupId>
			<artifactId>mockito-junit-jupiter</artifactId>
			<version>${r"${mockito.version}"}</version>
			<scope>test</scope>
		</dependency>

	</dependencies>

	<build>
		<defaultGoal>spring-boot:run</defaultGoal>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
				<configuration>
					<executable>true</executable>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.asciidoctor</groupId>
				<artifactId>asciidoctor-maven-plugin</artifactId>
				<version>${r"${asciidoctor.version}"}</version>
				<executions>
					<execution>
						<id>generate-docs</id>
						<phase>prepare-package</phase>
						<goals>
							<goal>process-asciidoc</goal>
						</goals>
						<configuration>
							<backend>html</backend>
							<doctype>book</doctype>
							<logHandler>
								<outputToConsole>true</outputToConsole>
								<failIf>
									<severity>DEBUG</severity>
								</failIf>
							</logHandler>
						</configuration>
					</execution>
				</executions>
				<dependencies>
					<dependency>
						<groupId>org.springframework.restdocs</groupId>
						<artifactId>spring-restdocs-asciidoctor</artifactId>
						<version>${r"${spring-restdocs.version}"}</version>
					</dependency>
				</dependencies>
			</plugin>
			<plugin>
				<artifactId>maven-resources-plugin</artifactId>
				<executions>
					<!-- The resource plugin must be declared after the Asciidoctor plugin as they are bound -->
					<!-- to the same phase (prepare-package) and the resource plugin must run after the Asciidoctor -->
					<!-- plugin to ensure that the documentation is generated before it's copied.-->
					<execution>
						<id>copy-asciidoctor-resources-to-classes</id>
						<phase>prepare-package</phase>
						<goals>
							<goal>copy-resources</goal>
						</goals>
						<configuration>
							<outputDirectory>${r"${project.build.outputDirectory}"}/static/docs</outputDirectory>
							<resources>
								<resource>
									<directory>${r"${project.build.directory}"}/generated-docs</directory>
								</resource>
							</resources>
						</configuration>
					</execution>
					<execution>
						<id>copy-asciidoctor-resources-to-frontend</id>
						<phase>prepare-package</phase>
						<goals>
							<goal>copy-resources</goal>
						</goals>
						<configuration>
							<outputDirectory>../${ info.artifactId }-frontend/apidoc</outputDirectory>
							<resources>
								<resource>
									<directory>${r"${project.build.directory}"}/generated-docs</directory>
								</resource>
							</resources>
						</configuration>
					</execution>
					<!-- Add this because mybatis xml files have to be copied to target folder -->
					<execution>
						<id>copy-maven-mapper-xml</id>
						<phase>process-classes</phase>
						<goals>
							<goal>copy-resources</goal>
						</goals>
						<configuration>
							<outputDirectory>${r"${basedir}"}/target/classes</outputDirectory>
							<encoding>UTF-8</encoding>
							<resources>
								<resource>
									<directory>${r"${basedir}"}/src/main/java</directory>
									<includes>
										<include>**/*.xml</include>
									</includes>
								</resource>
							</resources>
						</configuration>
					</execution>
				</executions>
			</plugin>
		</plugins>
	</build>

</project>