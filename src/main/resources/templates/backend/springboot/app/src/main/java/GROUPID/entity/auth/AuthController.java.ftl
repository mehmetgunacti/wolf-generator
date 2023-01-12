package ${ info.groupId }.entity.auth;

import ${ info.groupId }.constant.AuthRole;
import ${ info.groupId }.constant.EntityNames;
import ${ info.groupId }.constant.RestMapping;
import ${ info.groupId }.entity.BaseDTO;
import ${ info.groupId }.exception.InvalidJWTTokenException;
import ${ info.groupId }.exception.UserNotFoundException;
import ${ info.groupId }.security.component.JwtTokenProvider;
import ${ info.groupId }.security.dto.LoginDTO;
import ${ info.groupId }.security.dto.RegisterDTO;
import ${ info.groupId }.security.dto.RemindPasswordDTO;
import ${ info.groupId }.security.dto.ChangePasswordDTO;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

import java.time.LocalDate;

import static ${ info.groupId }.constant.RestMapping.AUTH_LOGIN;
import static ${ info.groupId }.constant.RestMapping.AUTH_REGISTER;
import static ${ info.groupId }.constant.RestMapping.AUTH_REMIND_PASSWORD;
import static ${ info.groupId }.constant.RestMapping.AUTH_CHANGE_PASSWORD;
import static ${ info.groupId }.constant.RestMapping.AUTH_USERS_ID_DISABLE;
import static ${ info.groupId }.constant.RestMapping.AUTH_USERS_ID_ENABLE;
import static ${ info.groupId }.constant.RestMapping.AUTH_USERS_ID_ROLES_ROLE;

@Slf4j
@RequiredArgsConstructor
@RestController
public class AuthController {

    private final AuthenticationManager authenticationManager;
    private final AuthUserService       authUserService;
    private final AuthService           authService;
    private final JwtTokenProvider      tokenProvider;
    private final SimpMessagingTemplate simpMessagingTemplate;

    @Operation(summary = "Login")
    @ResponseStatus(value = HttpStatus.CREATED)
    @PostMapping(AUTH_LOGIN)
    public BaseDTO post_AUTH_LOGIN(@RequestBody @Valid LoginDTO loginDTO) {

        // TODO : research how to properly test this method
        Authentication authentication = authenticationManager.authenticate(

                new UsernamePasswordAuthenticationToken(
                        loginDTO.getUsername(),
                        loginDTO.getPassword()
                )

        );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        AuthUser user = authUserService
                .findByUsername(loginDTO.getUsername())
                .orElseThrow(() -> new UserNotFoundException(loginDTO.getUsername()));

        AuthUserDTO dto = new AuthUserDTO(user);
        dto.setToken(tokenProvider.generateToken(authentication));
        return dto;

    }

    @Operation(summary = "Login (rememberMe)")
    @ResponseStatus(value = HttpStatus.CREATED)
    @PutMapping(AUTH_LOGIN)
    public BaseDTO put_AUTH_LOGIN(@RequestBody String token) {

        if (!tokenProvider.validateToken(token))
            throw new InvalidJWTTokenException();

        AuthUser user = authUserService
                .findById(tokenProvider.getUserIdFromJWT(token))
                .orElseThrow(() -> new BadCredentialsException("Login required"));

        AuthUserDTO dto = new AuthUserDTO(user);
        dto.setToken(token);
        return dto;

    }


    @Operation(summary = "Remind Password")
    @ResponseStatus(value = HttpStatus.ACCEPTED)
    @PutMapping(AUTH_REMIND_PASSWORD)
    public void put_AUTH_REMIND_PASSWORD(@RequestBody @Valid RemindPasswordDTO remindPasswordDTO) {

        try {

            authService.remindPassword(remindPasswordDTO.getUsername());

        } catch (UserNotFoundException unfe) {

            log.warn("Remind Password failed: {} : ", unfe.getMessage());
            // do nothing just return 202 Accepted

        }

    }

    @Operation(summary = "Change Password")
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    @PutMapping(AUTH_CHANGE_PASSWORD)
    public void put_AUTH_CHANGE_PASSWORD(@RequestBody @Valid ChangePasswordDTO dto) {

        try {

            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            dto.getUsername(),
                            dto.getPassword()
                    )
            );
            SecurityContextHolder.getContext().setAuthentication(authentication);

        } catch (CredentialsExpiredException cee) {
            // do nothing, user is here because credentials are expired
        } catch (LockedException le) {
            // do nothing, user is here because account is locked
        }

        authService.changePassword(
                dto.getUsername(),
                dto.getNewPassword()
        );

    }

    @Operation(summary = "Register new user")
    @ResponseStatus(value = HttpStatus.CREATED)
    @PostMapping(AUTH_REGISTER)
    public void put_AUTH_REGISTER(@RequestBody @Valid RegisterDTO registerDTO) {

        AuthUser newUser = new AuthUser();
        newUser.setName(registerDTO.getName());
        newUser.setUsername(registerDTO.getUsername());
        newUser.setTitle(registerDTO.getTitle());
        newUser.setBirthdate(registerDTO.getBirthdate());
        newUser.setMobile(registerDTO.getMobile());
        newUser.setPhone(registerDTO.getPhone());
        authUserService.create(newUser);

    }

    @PreAuthorize("hasAuthority('" + AuthRole.AUTH_USER_MANAGE + "')")
    @Operation(summary = "Enable user account")
    @ResponseStatus(value = HttpStatus.OK)
    @PatchMapping(AUTH_USERS_ID_ENABLE)
    public BaseDTO patch_AUTH_USERS_ID_ENABLE(@PathVariable Long id) {

        authService.enableAccount(id);
        return authUserService
                .findById(id)
                .map(AuthUserDTO::new)
                .orElse(new AuthUserDTO(id));

    }

    @PreAuthorize("hasAuthority('" + AuthRole.AUTH_USER_MANAGE + "')")
    @Operation(summary = "Disable user account")
    @ResponseStatus(value = HttpStatus.OK)
    @PatchMapping(AUTH_USERS_ID_DISABLE)
    public BaseDTO patch_AUTH_USERS_ID_DISABLE(@PathVariable Long id) {

        authService.disableAccount(id);
        return authUserService
                .findById(id)
                .map(AuthUserDTO::new)
                .orElse(new AuthUserDTO(id));

    }

    @PreAuthorize("hasAuthority('" + AuthRole.AUTH_USER_MANAGE + "')")
    @Operation(summary = "Toggle user role")
    @ResponseStatus(value = HttpStatus.OK)
    @PatchMapping(AUTH_USERS_ID_ROLES_ROLE)
    public BaseDTO patch_AUTH_USERS_ID_ROLES_ROLE(@PathVariable Long id, @PathVariable String role) {

        log.info("userid: " + id + "  role: " + role);

        // toggle user role
        authService.toggleRole(id, role);

        // find user
        AuthUserDTO authUserDTO = authUserService
                .findById(id)
                .map(AuthUserDTO::new)
                .orElse(new AuthUserDTO(id)); // This will delete AuthUser on client side

        log.info("sending to " + RestMapping.TOPIC_LOGGED_IN_USER_CHANGES.replace("{id}", id.toString()));
        log.info("roles: " + authUserDTO.getData().get(EntityNames.authUsers).getEntities().get(id));
        // send user instance with roles to connected client
        simpMessagingTemplate.convertAndSend(

                RestMapping.TOPIC_LOGGED_IN_USER_CHANGES.replace("{id}", id.toString()),
                authUserDTO

        );
        return authUserDTO;

    }

//    // @Secured(AuthRole.GRANT_REVOKE)
//    @Operation(summary = "Grant role to user")
//    @ResponseStatus(value = HttpStatus.OK)
//    @PostMapping(AUTH_USERS_ID_ROLES_ROLE)
//    public BaseDTO post_AUTH_USERS_ID_ROLES_ROLE(@PathVariable Long id, @PathVariable String role) {
//
//        log.info("userid: " + id + "  role: " + role);
//        authService.grantRole(id, role);
//        return authUserService
//                .findById(id)
//                .map(AuthUserDTO::new)
//                .orElse(new AuthUserDTO(id));
//
//    }
//
//    // @Secured(AuthRole.GRANT_REVOKE)
//    @Operation(summary = "Revoke role from user")
//    @ResponseStatus(value = HttpStatus.OK)
//    @DeleteMapping(AUTH_USERS_ID_ROLES_ROLE)
//    public BaseDTO delete_AUTH_USERS_ID_ROLES_ROLE(@PathVariable Long id, @PathVariable String role) {
//
//        authService.revokeRole(id, role);
//        return authUserService
//                .findById(id)
//                .map(AuthUserDTO::new)
//                .orElse(new AuthUserDTO(id));
//
//    }

}