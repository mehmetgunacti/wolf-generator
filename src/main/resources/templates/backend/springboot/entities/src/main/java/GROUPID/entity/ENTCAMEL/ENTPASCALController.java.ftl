package ${ info.groupId }.entity.${ entity.name.singular };

import ${ info.groupId }.constant.AuthRole;
import ${ info.groupId }.entity.BaseDTO;

import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import static ${ info.groupId }.constant.RestMapping.${ entity.name.plural.snake.uppercase };
import static ${ info.groupId }.constant.RestMapping.${ entity.name.plural.snake.uppercase }_ID;

@RequiredArgsConstructor
@RestController
public class ${ entity.name.singular.pascal }Controller {

    private final ${ entity.name.singular.pascal }Service ${ entity.name.singular }Service;

    @PreAuthorize("hasAuthority('" + AuthRole.${ entity.name.singular.snake.uppercase }_VIEW + "')")
    @Operation(summary = "Returns all ${ entity.name.plural.pascal }")
    @ResponseStatus(value = HttpStatus.OK)
    @GetMapping(${ entity.name.plural.snake.uppercase })
    public BaseDTO get_${ entity.name.plural.snake.uppercase }() {

        return new ${ entity.name.singular.pascal }DTO(${ entity.name.singular }Service.findAll());

    }

    @PreAuthorize("hasAuthority('" + AuthRole.${ entity.name.singular.snake.uppercase }_VIEW + "')")
    @Operation(summary = "Returns one ${ entity.name.singular.pascal }")
    @ResponseStatus(value = HttpStatus.OK)
    @GetMapping(${ entity.name.plural.snake.uppercase }_ID)
    public BaseDTO get_${ entity.name.plural.snake.uppercase }_ID(@PathVariable Long id) {

        return ${ entity.name.singular }Service
                .findById(id)
                .map(${ entity.name.singular.pascal }DTO::new)
                .orElse(new ${ entity.name.singular.pascal }DTO(id)); // new ...DTO(id) == empty DTO == EntityNotFoundException

    }

    @PreAuthorize("hasAuthority('" + AuthRole.${ entity.name.singular.snake.uppercase }_ADD + "')")
    @Operation(summary = "Creates one ${ entity.name.singular.pascal }")
    @ResponseStatus(value = HttpStatus.CREATED)
    @PostMapping(${ entity.name.plural.snake.uppercase })
    public BaseDTO post_${ entity.name.plural.snake.uppercase }(@RequestBody ${ entity.name.singular.pascal } ${ entity.name.singular }) {

        return new ${ entity.name.singular.pascal }DTO(${ entity.name.singular }Service.create(${ entity.name.singular }));

    }

//    @Operation(summary = "Updates one ${ entity.name.singular.pascal }")
//    @ResponseStatus(value = HttpStatus.OK)
//    @PutMapping(${ entity.name.plural.snake.uppercase }_ID)
//    public BaseDTO put_${ entity.name.plural.snake.uppercase }_ID(@PathVariable Long id, @RequestBody ${ entity.name.singular.pascal } ${ entity.name.singular }) {
//
//        ${ entity.name.singular }.setId(id);
//        return new ${ entity.name.singular.pascal }DTO(${ entity.name.singular }Service.save(${ entity.name.singular }));
//
//    }

    @PreAuthorize("hasAuthority('" + AuthRole.${ entity.name.singular.snake.uppercase }_EDIT + "')")
    @Operation(summary = "Patches one ${ entity.name.singular.pascal }")
    @ResponseStatus(value = HttpStatus.OK)
    @PatchMapping(${ entity.name.plural.snake.uppercase }_ID)
    public BaseDTO patch_${ entity.name.plural.snake.uppercase }_ID(@PathVariable Long id, @RequestBody ${ entity.name.singular.pascal } ${ entity.name.singular }) {

        ${ entity.name.singular }.setId(id);
        return ${ entity.name.singular }Service
                .modify(${ entity.name.singular })
                .map(${ entity.name.singular.pascal }DTO::new)
                .orElse(new ${ entity.name.singular.pascal }DTO(id)); // new ...DTO(id) == empty DTO == EntityNotFoundException

    }

    @PreAuthorize("hasAuthority('" + AuthRole.${ entity.name.singular.snake.uppercase }_DELETE + "')")
    @Operation(summary = "Deletes one ${ entity.name.singular.pascal }")
    @ResponseStatus(value = HttpStatus.OK)
    @DeleteMapping(${ entity.name.plural.snake.uppercase }_ID)
    public BaseDTO delete_${ entity.name.plural.snake.uppercase }_ID(@PathVariable Long id) {

        ${ entity.name.singular }Service.deleteById(id);
        return new ${ entity.name.singular.pascal }DTO(id);

    }

}
