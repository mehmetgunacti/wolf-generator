package ${ info.groupId }.security.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ChangePasswordDTO {

	private String username;
	private String password;

	@Size(min = 6, max = 20, message="Password must be at least 6 characters long")
	@NotBlank
	private String newPassword;

}
