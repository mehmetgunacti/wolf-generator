FROM mysql

ENV MYSQL_DATABASE="${ info.artifactId.camel.lowercase }"
ENV MYSQL_USER="${ info.artifactId.camel.lowercase }"
ENV MYSQL_PASSWORD="${ info.artifactId.camel.lowercase }"
ENV MYSQL_ROOT_PASSWORD="secret"

COPY schema.sql /docker-entrypoint-initdb.d/a-schema.sql

COPY inserts.sql /docker-entrypoint-initdb.d/b-inserts.sql

# COPY random.sql /docker-entrypoint-initdb.d/b-random-data.sql
