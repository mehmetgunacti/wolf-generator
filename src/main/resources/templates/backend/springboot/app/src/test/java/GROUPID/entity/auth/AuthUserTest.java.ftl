package ${ info.groupId }.entity.auth;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.restdocs.RestDocumentationExtension;

import java.time.Instant;
import java.time.temporal.ChronoUnit;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith({RestDocumentationExtension.class})
class AuthUserTest {

    private AuthUser user;

    @BeforeEach
    private void setUp() {

        this.user = new AuthUser();

    }

    @DisplayName("Account is not expired 10 seconds in the future")
    @Test
    void accountExpired_false_when_future() {

        Instant plus10Seconds = Instant.now().plus(10, ChronoUnit.SECONDS);
        user.setAccountExpiration(plus10Seconds);

        assertFalse(user.isAccountExpired());
        assertTrue(user.isAccountNonExpired());
        assertTrue(user.isEnabled());
        assertTrue(user.isAccountEnabled());

    }

    @DisplayName("Account is expired 10 seconds in the past")
    @Test
    void accountExpired_true_when_past() {

        Instant minus10Seconds = Instant.now().minus(10, ChronoUnit.SECONDS);
        user.setAccountExpiration(minus10Seconds);

        assertTrue(user.isAccountExpired());
        assertFalse(user.isAccountNonExpired());
        assertFalse(user.isEnabled());
        assertFalse(user.isAccountEnabled());

    }

    @DisplayName("Account is expired when no value set")
    @Test
    void accountExpired_true_when_null() {

        user.setAccountExpiration(null);

        assertTrue(user.isAccountExpired());
        assertFalse(user.isAccountNonExpired());
        assertFalse(user.isEnabled());
        assertFalse(user.isAccountEnabled());

    }

    @DisplayName("Password is not expired 10 seconds in the future")
    @Test
    void passwordExpired_false_when_future() {

        Instant plus10Seconds = Instant.now().plus(10, ChronoUnit.SECONDS);
        user.setPasswordExpiration(plus10Seconds);
        user.setPasswordAttempts(0);

        assertFalse(user.isPasswordExpired());
        assertFalse(user.isAccountLocked());
        assertTrue(user.isCredentialsNonExpired());

    }

    @DisplayName("Password is expired 10 seconds in the past")
    @Test
    void passwordExpired_true_when_past() {

        Instant minus10Seconds = Instant.now().minus(10, ChronoUnit.SECONDS);
        user.setPasswordExpiration(minus10Seconds);
        user.setPasswordAttempts(0);

        assertTrue(user.isPasswordExpired());
        assertTrue(user.isAccountLocked());
        assertFalse(user.isCredentialsNonExpired());

    }

    @DisplayName("Password is expired when no value set")
    @Test
    void passwordExpired_true_when_null() {

        user.setPasswordExpiration(null);

        assertTrue(user.isPasswordExpired());
        assertTrue(user.isAccountLocked());
        assertFalse(user.isCredentialsNonExpired());

    }

    @DisplayName("Password failed only true when 0 >= value <= 2")
    @Test
    void password_failed_only_true_when_lt_0_and_gt_2() {

        // -1 times
        user.setPasswordAttempts(-1);
        assertTrue(user.isPasswordFailed());

        // 0 times
        user.setPasswordAttempts(0);
        assertFalse(user.isPasswordFailed());

        // 2 times
        user.setPasswordAttempts(2);
        assertFalse(user.isPasswordFailed());

        // 3 times
        user.setPasswordAttempts(3);
        assertTrue(user.isPasswordFailed());

        // 4 times
        user.setPasswordAttempts(4);
        assertTrue(user.isPasswordFailed());

        // when null
        user.setPasswordAttempts(null);
        assertTrue(user.isPasswordFailed());

    }

    @DisplayName("Account locked")
    @Test
    void accountLocked() {

        // false false
        Instant minus10Seconds = Instant.now().minus(10, ChronoUnit.SECONDS);
        user.setPasswordExpiration(minus10Seconds);
        user.setPasswordAttempts(3);

        assertTrue(user.isPasswordFailed());
        assertTrue(user.isAccountLocked());
        assertFalse(user.isAccountNonLocked());

        // true false
        Instant plus10Seconds = Instant.now().plus(10, ChronoUnit.SECONDS);
        user.setPasswordExpiration(plus10Seconds);
        user.setPasswordAttempts(3);

        assertTrue(user.isPasswordFailed());
        assertTrue(user.isAccountLocked());
        assertFalse(user.isAccountNonLocked());

        // true true
        plus10Seconds = Instant.now().plus(10, ChronoUnit.SECONDS);
        user.setPasswordExpiration(plus10Seconds);
        user.setPasswordAttempts(2);

        assertFalse(user.isPasswordFailed());
        assertFalse(user.isAccountLocked());
        assertTrue(user.isAccountNonLocked());

    }


}