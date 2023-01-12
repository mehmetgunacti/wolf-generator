<?xml version="1.0" encoding="UTF-8"?>
<configuration>

	<property name="LOGS" value="/home/mserkan/Temporary/logs" />

	<appender name="Console"
		class="ch.qos.logback.core.ConsoleAppender">
		<layout class="ch.qos.logback.classic.PatternLayout">
			<Pattern>
				%black(%d{ISO8601}) %highlight(%-5level) [%blue(%t)] %yellow(%C{1.}@%method\(%line\)): %msg%n%throwable
			</Pattern>
		</layout>
	</appender>

	<appender name="RollingFile"
		class="ch.qos.logback.core.rolling.RollingFileAppender">
		<file>${r"${LOGS}"}/${ info.artifactId }.log</file>
		<encoder
			class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
			<Pattern>%d %p %C{1.}@%method\(%line\) [%t] %m%n</Pattern>
		</encoder>

		<rollingPolicy
			class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
			<!-- rollover daily and when the file reaches 10 MegaBytes -->
			<fileNamePattern>${r"${LOGS}"}/archived/${ info.artifactId }-%d{yyyy-MM-dd}.%i.log
			</fileNamePattern>
			<timeBasedFileNamingAndTriggeringPolicy
				class="ch.qos.logback.core.rolling.SizeAndTimeBasedFNATP">
				<maxFileSize>10MB</maxFileSize>
			</timeBasedFileNamingAndTriggeringPolicy>
		</rollingPolicy>
	</appender>

	<!-- LOG everything at INFO level -->
	<root level="info">
		<appender-ref ref="RollingFile" />
		<appender-ref ref="Console" />
	</root>

	<!-- LOG "${ info.groupId }" at TRACE level -->
	<logger name="${ info.groupId }" level="trace" additivity="false">
		<appender-ref ref="RollingFile" />
		<appender-ref ref="Console" />
	</logger>

</configuration>