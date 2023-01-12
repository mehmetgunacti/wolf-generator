package ${ info.groupId }.security.component;

import ${ info.groupId }.configuration.AppConfiguration;
import ${ info.groupId }.entity.auth.AuthUser;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;

@Slf4j
@Component
public class JwtTokenProvider {

    private final AppConfiguration appConfiguration;
    private final Key              key;

    public JwtTokenProvider(AppConfiguration appConfiguration) {

        this.appConfiguration = appConfiguration;
        this.key = Keys.hmacShaKeyFor(appConfiguration.getJwtSecret().getBytes(StandardCharsets.UTF_8));

    }

    public String generateToken(Authentication authentication) {

        AuthUser userPrincipal = (AuthUser) authentication.getPrincipal();
        Date     now           = new Date();
        Date     expiryDate    = new Date(now.getTime() + appConfiguration.getJwtExpirationInMs());

        return Jwts.builder()
                .setSubject(Long.toString(userPrincipal.getId()))
                .setIssuedAt(new Date())
                .setExpiration(expiryDate)
                .signWith(key, SignatureAlgorithm.HS512)
                .compact();

    }

    public Long getUserIdFromJWT(String token) {

        return getSubject(token);

    }

    public Long getSubject(String token) {

        Claims claims = Jwts
                .parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token)
                .getBody();
        String subject = claims.getSubject();
        return subject == null ? null : Long.parseLong(subject);

    }

    public boolean validateToken(String authToken) {

        try {
            Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(authToken);
            return true;
        } catch (MalformedJwtException ex) {
            log.error("Invalid JWT token");
        } catch (ExpiredJwtException ex) {
            log.error("Expired JWT token");
        } catch (UnsupportedJwtException ex) {
            log.error("Unsupported JWT token");
        } catch (IllegalArgumentException ex) {
            log.error("JWT claims string is empty.");
        } catch (Exception e) {
            log.error("JWT validation failed", e);
        }
        return false;

    }

}