package ${ info.groupId }.configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;

// http://localhost:8080/api-docs/
// http://localhost:8080/swagger-ui-custom.html
// http://localhost:8080/swagger-ui/index.html
@Configuration
public class OpenAPIConfig {

    @Bean
    public OpenAPI customOpenAPI(@Value("${r"${springdoc.version}"}") String appVersion) {

        return new OpenAPI()
                .info(
                        new Info()
                                .title("${ info.title } API")
                                .version(appVersion)
                                .description("""
                                        This is a sample Foobar server created using springdocs - 
                                        a library for OpenAPI 3 with spring boot.""")
                                .termsOfService("http://swagger.io/terms/")
                                .license(
                                        new License()
                                                .name("Apache 2.0")
                                                .url("http://springdoc.org")
                                )

                );

    }

}
