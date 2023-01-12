package ${ info.groupId }.entity.auth;

import ${ info.groupId }.constant.AuthRole;
import ${ info.groupId }.entity.BaseDTO;
import ${ info.groupId }.security.component.JwtTokenProvider;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import static ${ info.groupId }.constant.RestMapping.AUTH_USERS;
import static ${ info.groupId }.constant.RestMapping.AUTH_USERS_ID;

@Slf4j
@RequiredArgsConstructor
@RestController
public class AuthUserController {

    private final AuthenticationManager authenticationManager;
    private final AuthUserService       authUserService;
    private final JwtTokenProvider      tokenProvider;

    @PreAuthorize("hasAuthority('" + AuthRole.AUTH_USER_VIEW + "')")
    @Operation(summary = "List all users (admin)")
    @ResponseStatus(value = HttpStatus.OK)
    @GetMapping(AUTH_USERS)
    public BaseDTO get_AUTH_USERS() {

        return new AuthUserDTO(authUserService.findAll());

    }

    @PreAuthorize("hasAuthority('" + AuthRole.AUTH_USER_VIEW + "')")
    @Operation(summary = "Returns one AuthUser")
    @ResponseStatus(value = HttpStatus.OK)
    @GetMapping(AUTH_USERS_ID)
    public BaseDTO get_AUTH_USERS_ID(@PathVariable Long id) {

        return authUserService
                .findById(id)
                .map(AuthUserDTO::new)
                .orElse(new AuthUserDTO(id));

    }

    @PreAuthorize("hasAuthority('" + AuthRole.AUTH_USER_EDIT + "')")
    @Operation(summary = "Creates one AuthUser")
    @ResponseStatus(value = HttpStatus.CREATED)
    @PostMapping(AUTH_USERS)
    public BaseDTO post_AUTH_USERS(@RequestBody AuthUser auth) {

        return new AuthUserDTO(authUserService.create(auth));

    }

    @PreAuthorize("hasAuthority('" + AuthRole.AUTH_USER_EDIT + "')")
    @Operation(summary = "Patches one AuthUser")
    @ResponseStatus(value = HttpStatus.OK)
    @PatchMapping(AUTH_USERS_ID)
    public BaseDTO patch_AUTH_USERS_ID(@PathVariable Long id, @RequestBody AuthUser authUser) {

        authUser.setId(id);
        return authUserService
                .modify(authUser)
                .map(AuthUserDTO::new)
                .orElse(new AuthUserDTO(id)); // new ...DTO(id) == empty DTO == EntityNotFoundException;

    }

    @PreAuthorize("hasAuthority('" + AuthRole.AUTH_USER_EDIT + "')")
    @Operation(summary = "Deletes one AuthUser")
    @ResponseStatus(value = HttpStatus.OK)
    @DeleteMapping(AUTH_USERS_ID)
    public BaseDTO delete_AUTH_USERS_ID(@PathVariable Long id) {

        authUserService.deleteById(id);
        return new AuthUserDTO(id);

    }

}