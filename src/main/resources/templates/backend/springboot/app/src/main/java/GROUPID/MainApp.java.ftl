package ${ info.groupId };

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/*************************************************************
* @SpringBootApplication is a convenience annotation that adds all of the following:
* @Configuration tags the class as a source of bean definitions for the application context.
*	@EnableAutoConfiguration tells Spring Boot to start adding beans based on classpath settings, other beans, and various property settings.
*	Normally you would add @EnableWebMvc for a Spring MVC app, but Spring Boot adds it automatically when it sees spring-webmvc on the classpath.
*	This flags the application as a web application and activates key behaviors such as setting up a DispatcherServlet.
*	@ComponentScan tells Spring to look for other component, configurations, and service in the hello package, allowing it to find the controller.
* @EnableScheduling ensures that a background task executor is created. Without it, nothing gets scheduled.
**************************************************************/

@SpringBootApplication
@EnableScheduling
public class MainApp {

	public static void main(String[] args) {

		SpringApplication.run(MainApp.class, args);

	}

}
