package ${ info.groupId }.security.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.time.LocalDate;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class RegisterDTO implements Serializable {

    @NotBlank(message = "Enter name")
    private String name;

    @NotBlank(message = "Enter email address")
    private String username;

    private String    title;
    private LocalDate birthdate;
    private String    mobile;
    private String    phone;

}