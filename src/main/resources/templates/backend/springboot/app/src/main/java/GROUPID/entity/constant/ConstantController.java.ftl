package ${ info.groupId }.entity.constant;

import ${ info.groupId }.constant.AuthRole;
import io.swagger.v3.oas.annotations.Operation;

import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import static ${ info.groupId }.constant.RestMapping.AUTH_CONSTANTS;
import static ${ info.groupId }.constant.RestMapping.AUTH_CONSTANTS_CODE;

@RequiredArgsConstructor
@RestController
public class ConstantController {

	private final ConstantService constantService;

	@PreAuthorize("isAuthenticated()")
	@Operation(summary = "Returns all constants")
	@ResponseStatus(value = HttpStatus.OK)
	@GetMapping(AUTH_CONSTANTS)
	public ConstantDTO get_CONSTANTS() {

		return new ConstantDTO(constantService.findAll());

	}

	@PreAuthorize("hasAuthority('" + AuthRole.CONSTANT_MANAGE + "')")
	@Operation(summary = "Creates one Constant")
	@ResponseStatus(value = HttpStatus.CREATED)
	@PostMapping(AUTH_CONSTANTS)
	public ConstantDTO post_ADMIN_CONSTANTS(@RequestBody Constant constant) {

		return new ConstantDTO(constantService.create(constant));

	}

	@PreAuthorize("hasAuthority('" + AuthRole.CONSTANT_MANAGE + "')")
	@Operation(summary = "Deletes one Constant")
	@ResponseStatus(value = HttpStatus.OK)
	@DeleteMapping(AUTH_CONSTANTS_CODE)
	public ConstantDTO delete_ADMIN_CONSTANTS_CODE(@PathVariable String code) {

		constantService.deleteById(code);
		return new ConstantDTO(code);

	}

	@PreAuthorize("hasAuthority('" + AuthRole.CONSTANT_MANAGE + "')")
    @Operation(summary = "Patches a Constant")
    @ResponseStatus(value = HttpStatus.OK)
    @PatchMapping(AUTH_CONSTANTS_CODE)
    public ConstantDTO patch_CONSTANTS_ID(@PathVariable String code, @RequestBody Constant constant) {

        constant.setCode(code);
        return constantService
				.modify(constant)
				.map(ConstantDTO::new)
				.orElse(new ConstantDTO(code)); // new ...DTO(id) == empty DTO == EntityNotFoundException;

    }

}
