package ${ info.groupId }.security.component;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;

@Slf4j
@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint, Serializable {

    public static final String AUTH_CREDENTIALS_BAD     = "AUTH_CREDENTIALS_BAD";
    public static final String AUTH_CREDENTIALS_EXPIRED = "AUTH_CREDENTIALS_EXPIRED";
    public static final String AUTH_ACCOUNT_LOCKED      = "AUTH_ACCOUNT_LOCKED";
    public static final String AUTH_ACCOUNT_DISABLED    = "AUTH_ACCOUNT_DISABLED";
    public static final String AUTH_ACCOUNT_EXPIRED     = "AUTH_ACCOUNT_EXPIRED";

    @Override
    public void commence(HttpServletRequest request,
                         HttpServletResponse response,
                         AuthenticationException authException) throws IOException {

        authException.printStackTrace();
        String message = "Unauthorized";
        if (authException instanceof BadCredentialsException)
            message = AUTH_CREDENTIALS_BAD;

        else if (authException instanceof CredentialsExpiredException)
            message = AUTH_CREDENTIALS_EXPIRED;

        else if (authException instanceof LockedException)
            message = AUTH_ACCOUNT_LOCKED;

        else if (authException instanceof DisabledException)
            message = AUTH_ACCOUNT_DISABLED;

        else if (authException instanceof AccountExpiredException)
            message = AUTH_ACCOUNT_EXPIRED;

        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, message);
    }
}