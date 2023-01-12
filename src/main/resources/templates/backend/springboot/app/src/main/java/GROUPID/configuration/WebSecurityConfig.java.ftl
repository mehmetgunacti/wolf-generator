package ${ info.groupId }.configuration;

import ${ info.groupId }.security.component.JwtAuthenticationEntryPoint;
import ${ info.groupId }.security.filter.JwtAuthenticationFilter;

import lombok.RequiredArgsConstructor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.BeanIds;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@RequiredArgsConstructor
@Configuration

// This is the primary spring security annotation that is used to enable web security in a project.
@EnableWebSecurity

// This is used to enable method level security based on annotations.
// securedEnabled : enables the @Secured
// jsr250Enabled : enables the @RolesAllowed
// prePostEnabled : enables more complex expression based access control syntax with @PreAuthorize and @PostAuthorize
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    private final UserDetailsService userDetailsService;

    // This class is used to return a 401 unauthorized error to clients that try to access a protected resource without proper authentication
    // = unauthorizedHandler
    private final JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;

    // is the main Spring Security interface for authenticating a user
    @Override
    @Bean(BeanIds.AUTHENTICATION_MANAGER)
    public AuthenticationManager authenticationManagerBean() throws Exception {

        return super.authenticationManagerBean();

    }

    // - you can build
    // 		- in-memory authentication,
    // 		- LDAP authentication,
    // 		- JDBC authentication,
    // 		- or add your custom authentication provider
    // We'll use the configured AuthenticationManager to authenticate a user in the login API.
    @Override
    public void configure(AuthenticationManagerBuilder authenticationManagerBuilder) throws Exception {

        authenticationManagerBuilder
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder());

    }

    // - reads JWT authentication token from the Authorization header of all the requests
    // - validates the token
    // - loads the user details associated with that token.
    // - Sets the user details in Spring Security’s SecurityContext.
    // 		- Spring Security uses the user details to perform authorization checks.
    // 		- We can also access the user details stored in the SecurityContext in our controller to perform our business logic.
    @Bean
    public JwtAuthenticationFilter jwtAuthenticationFilter() {

        return new JwtAuthenticationFilter();

    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {

        return new BCryptPasswordEncoder();

    }

    // used to configure security functionalities like
    // - csrf,
    // - sessionManagement,
    // - and add rules to protect resources based on various conditions
    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.cors().and().csrf().disable()
                .exceptionHandling().authenticationEntryPoint(jwtAuthenticationEntryPoint).and()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()

                // authorize these
                .authorizeRequests()
                .antMatchers(
                        "/list",
                        "/online",
                        "/online/**",
                        "/online/list",
                        "/auth/login",
                        "/auth/online",
                        "/auth/online/list",
                        "/auth/change-password",
                        "/auth/remind-password",
                        "/auth/register",
                        "/auth/users/**",
                        "/auth/constants/**",
                        "/download/**",
                        "/instantfiles/**",
                        "/pictures/**",
                        "/jserror/**",
                        "/actuator/**",
                        "/webjars/**",
                        "/v2/*",
                        "/csrf",
                        "/swagger-resources/**",
                        "/swagger-ui.html",
                        "/swagger-ui/**",
                        "/api-docs/**",
                        "/swagger-ui-custom.html",
                        "/v2/**",
                        <#list entities as entity>
                        "/${ entity.name.plural.kebab }/**"<#sep>,</#sep>
                        </#list>
                )
                .permitAll()

                // do not authorize the rest
                .anyRequest().authenticated();

        // Add our custom JWT security filter
        http.addFilterBefore(jwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);

    }

}