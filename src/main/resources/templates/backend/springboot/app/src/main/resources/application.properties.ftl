# ===============================
# = DATA SOURCE
# ===============================

# Set here configurations for the database connection
spring.datasource.driver-class-name                = com.mysql.cj.jdbc.Driver

# Connection url for the database "${ info.artifactId.camel.lowercase }"
spring.datasource.url                              = jdbc:mysql://mysql:3306/${ info.artifactId.camel.lowercase }?useSSL=true&characterEncoding=utf8

# Username and password
spring.datasource.username                         = ${ info.artifactId.camel.lowercase }
spring.datasource.password                         = ${ info.artifactId.camel.lowercase }

# Keep the connection alive if idle for a long time (needed in production)
spring.datasource.testWhileIdle                    = true
spring.datasource.validationQuery                  = SELECT 1

# ===============================
# = MYBATIS
# ===============================

mybatis.config-location                            = classpath:mybatis-config.xml

# ===============================
# = FILE UPLOAD
# ===============================
spring.servlet.multipart.max-file-size             = 20MB
spring.servlet.multipart.max-request-size          = 20MB

# ===============================
# = MAIL
# ===============================
spring.mail.host                                   = smtp.gmail.com
spring.mail.port                                   = 587
spring.mail.username                               = falkebm@gmail.com
spring.mail.password                               = gy1m_n23!aL!
spring.mail.properties.mail.smtp.auth              = true
spring.mail.properties.mail.smtp.starttls.enable   = true

# ===============================
# = WEB RESOURCE
# ===============================
# https://docs.spring.io/spring-boot/docs/current/reference/html/common-application-properties.html

# ===============================
# = ACTUATOR
# ===============================
# management.server.port=8081

# =============================================================================================================
# =============================================================================================================
# =============================================================================================================
#                                              ${ info.title }
# =============================================================================================================
# =============================================================================================================
# =============================================================================================================

#environment
${ info.artifactId.camel.lowercase }.environmentType                                = DEV

${ info.artifactId.camel.lowercase }.adminEmail                                     = ${r"${spring.mail.username}"}
${ info.artifactId.camel.lowercase }.falkecomtr                                     = ____falke.com.tr
${ info.artifactId.camel.lowercase }.emailSeparator                                 = ;

# ===============================
# = JWT
# ===============================
${ info.artifactId.camel.lowercase }.jwtSecret                                      = JWTSuperSecretKeyJWTSuperSecretKeyJWTSuperSecretKeyJWTSuperSecretKeyJWTSuperSecretKeyJWTSuperSecretKey
${ info.artifactId.camel.lowercase }.jwtExpirationInMs                              = 604800000
${ info.artifactId.camel.lowercase }.jwtExpirationInMsForDownload                   = 60000

# ===============================
# = FILE UPLOAD
# ===============================
${ info.artifactId.camel.lowercase }.pathToDokumanlar                               = ${ workingDirectory.path }/${ info.artifactId.camel.lowercase }basefolder/dokumanlar
${ info.artifactId.camel.lowercase }.pathToVesikaliklar                             = ${ workingDirectory.path }/${ info.artifactId.camel.lowercase }basefolder/vesikaliklar

# ===============================
# = LOGGING
# ===============================
${ info.artifactId.camel.lowercase }.log.file.location                              = ${ workingDirectory.path }/${ info.artifactId.camel.lowercase }/logs/

${ info.artifactId.camel.lowercase }.defaultPasswordExpiration                      = 90
${ info.artifactId.camel.lowercase }.defaultAccountExpiration                       = 90

# ===============================
# = SCHEDULED JOBS
# ===============================
${ info.artifactId.camel.lowercase }.scheduler.mailer.interval                          = 5000
${ info.artifactId.camel.lowercase }.scheduler.raporlar.interval                        = 60000

# ===============================
# = SERVER CONFIG
# ===============================
# server.address                                     = 192.168.2.21
# cors.allowed.origins : comma seperated, no space
${ info.artifactId.camel.lowercase }.corsAllowedOrigins[0]                              = http://localhost:4200
${ info.artifactId.camel.lowercase }.corsAllowedOrigins[1]                              = http://localhost:4500
${ info.artifactId.camel.lowercase }.corsAllowedOrigins[2]                              = http://192.168.2.23:4200

# custom path for swagger-ui
springdoc.swagger-ui.path=/swagger-ui-custom.html
springdoc.swagger-ui.operationsSorter=method

# custom path for api docs
springdoc.api-docs.path=/api-docs

## for com.baeldung.restdocopenapi ##
springdoc.version=@springdoc.version@
spring.jpa.hibernate.ddl-auto=none
######################################