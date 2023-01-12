package ${ info.groupId }.entity.auth;

import com.fasterxml.jackson.annotation.JsonIgnore;
import ${ info.groupId }.entity.user.User;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.security.Principal;
import java.time.Instant;
import java.util.Collection;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Getter
@Setter
@ToString
public class AuthUser extends User implements UserDetails {

    protected Set<String> roles;
    protected Instant     accountExpiration;
    protected Instant     passwordExpiration;
    protected Integer     passwordAttempts;
    protected Instant     lastLogin;

    @JsonIgnore
    protected String password;

    @JsonIgnore
    public Collection<? extends GrantedAuthority> getAuthorities() {

        return roles
                .stream()
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());

    }

    @JsonIgnore
    public Principal getPrincipal() {

        return () -> username;

    }

    public AuthUser() {

        this.roles = new HashSet<>();

    }

    public boolean isAccountExpired() {

        return Optional
                .ofNullable(accountExpiration)
                .filter(date -> Instant.now().isBefore(date))
                .isEmpty();

    }

    public boolean isPasswordExpired() {

        return Optional
                .ofNullable(passwordExpiration)
                .filter(date -> Instant.now().isBefore(date))
                .isEmpty();

    }

    public boolean isPasswordFailed() {

        return Optional
                .ofNullable(passwordAttempts)
                .filter(count -> count >= 0 && count <= 2)
                .isEmpty();

    }

    /* with 'account' they mean 'password' */
    public boolean isAccountLocked() {

        return isPasswordExpired() || isPasswordFailed();

    }

    public boolean isAccountEnabled() {

        return isEnabled();

    }

    /* account related */
    @JsonIgnore
    public boolean isAccountNonExpired() {

        return !isAccountExpired();

    }

    /* with 'account' they mean 'password' */
    @JsonIgnore
    public boolean isAccountNonLocked() {

        return !isAccountLocked();

    }

    /* with 'credentials' they mean 'password' */
    @JsonIgnore
    public boolean isCredentialsNonExpired() {

        return !isPasswordExpired();

    }

    /*
        Enabled account = 'accountExpired' must have a value of an instant in the future.
        To disable an account, set its 'accountExpired' to null.
    */
    @JsonIgnore
    public boolean isEnabled() {

        return !isAccountExpired();

    }

}