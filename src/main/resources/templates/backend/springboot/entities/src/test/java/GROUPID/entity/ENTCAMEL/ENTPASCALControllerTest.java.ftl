package ${ info.groupId }.entity.${ entity.name.singular };

import ${ info.groupId }.entity.AbstractRestControllerTest;
import ${ info.groupId }.exception.EntityNotFoundException;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import org.springframework.http.MediaType;
import org.springframework.restdocs.RestDocumentationContextProvider;
import org.springframework.restdocs.RestDocumentationExtension;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.Optional;

import static ${ info.groupId }.constant.RestMapping.${ entity.name.plural.snake.uppercase };
import static ${ info.groupId }.constant.RestMapping.${ entity.name.plural.snake.uppercase }_ID;

import static org.hamcrest.collection.IsCollectionWithSize.hasSize;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.willThrow;
import static org.mockito.Mockito.verify;

import static org.springframework.restdocs.mockmvc.MockMvcRestDocumentation.document;
import static org.springframework.restdocs.payload.PayloadDocumentation.fieldWithPath;
import static org.springframework.restdocs.payload.PayloadDocumentation.responseFields;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.patch;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith({RestDocumentationExtension.class, MockitoExtension.class})
class ${ entity.name.singular.pascal }ControllerTest extends AbstractRestControllerTest {

    @Mock
    private ${ entity.name.singular.pascal }Service ${ entity.name.singular }Service;

    @InjectMocks
    private ${ entity.name.singular.pascal }Controller ${ entity.name.singular }Controller;

    private MockMvc mockMvc;

    public ${ entity.name.singular.pascal }ControllerTest() {

        super("${ entity.name.singular }", "${ entity.name.plural }");

    }

    @BeforeEach
    private void setUp(RestDocumentationContextProvider restDocumentation) {

        mockMvc = buildMockMvc(restDocumentation, ${ entity.name.singular }Controller);

    }

    @DisplayName("GET " + ${ entity.name.plural.snake.uppercase } + ": get list of all ${ entity.name.plural.pascal } -> '200 Ok'")
    @Test
    void getAll() throws Exception {

        given(
                ${ entity.name.singular }Service.findAll()
        ).willReturn(
                Arrays.asList(
                        setId(1, new ${ entity.name.singular.pascal }()),
                        setId(2, new ${ entity.name.singular.pascal }()),
                        setId(3, new ${ entity.name.singular.pascal }())
                )
        );

        mockMvc
                .perform(
                        get(${ entity.name.plural.snake.uppercase })
                )
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.{NAME}.ids".replace("{NAME}", ENTITY_NAME_PLURAL), hasSize(3)))
                .andDo(document("{class-name}/{method-name}"));

        verify(${ entity.name.singular }Service).findAll();
    }

    @DisplayName("GET " + ${ entity.name.plural.snake.uppercase }_ID + ": return ${ entity.name.singular.pascal } -> '200 Ok'")
    @Test
    void getOne() throws Exception {

        final String anyId = "1234";

        given(
                ${ entity.name.singular }Service.findById(Long.parseLong(anyId))
        ).willReturn(
                Optional.of(setId(anyId, new ${ entity.name.singular.pascal }()))
        );

        mockMvc
                .perform(

                        get(
                                ${ entity.name.plural.snake.uppercase }_ID.replace("{id}", anyId)
                        )

                )
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPathToId().value(anyId))
                .andExpect(jsonPathToEntity(anyId).exists())
                .andDo(
                        document("{class-name}/{method-name}",
                                responseFields(
                                        fieldWithPath("data.${ entity.name.plural }.entities").description("List of all entities"),
                                        fieldWithPath("data.${ entity.name.plural }.ids").description("List of returning ${ entity.name.singular.pascal } IDs"),
                                        fieldWithPath("data.${ entity.name.plural }.entities['1234'].id").description("${ entity.name.singular.pascal } ID"),
                                        fieldWithPath("data.${ entity.name.plural }.entities['1234'].created").description("Creation date"),
                                        fieldWithPath("data.${ entity.name.plural }.entities['1234'].modified").description("Last modification date"),
                                        <#list entity.fields as field>
                                        fieldWithPath("data.${ entity.name.plural }.entities['1234'].${ field.name }").description("${ entity.name.singular.pascal }.${ field.name }")<#sep>,</#sep>
                                        </#list>
                                )
                        )
                );

        verify(${ entity.name.singular }Service).findById(anyLong());

    }

    @DisplayName("POST " + ${ entity.name.plural.snake.uppercase } + ": create ${ entity.name.singular.pascal } -> '201 Created'")
    @Test
    void createOne() throws Exception {

        ${ entity.name.singular.pascal } ${ entity.name.singular }  = setId(1, new ${ entity.name.singular.pascal }());
        ${ entity.name.singular.pascal } returnValue = setId(1000, new ${ entity.name.singular.pascal }());

        given(
                ${ entity.name.singular }Service.create(any())
        ).willReturn(
                returnValue
        );

        mockMvc
                .perform(

                        post(${ entity.name.plural.snake.uppercase })
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(asJsonString(${ entity.name.singular }))

                )
                .andDo(print())
                .andExpect(status().isCreated())
                .andExpect(jsonPathToId().value(returnValue.getId()))
                .andDo(document("{class-name}/{method-name}"));

        verify(${ entity.name.singular }Service).create(any());

    }

    @DisplayName("DELETE " + ${ entity.name.plural.snake.uppercase }_ID + ": delete ${ entity.name.singular.pascal } -> '204 No Content'")
    @Test
    void deleteOne() throws Exception {

        final Long anyId = 1L;
        mockMvc
                .perform(

                        delete(
                                ${ entity.name.plural.snake.uppercase }_ID.replace("{id}", anyId.toString())
                        )

                )
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPathToId().value(anyId))
                .andDo(document("{class-name}/{method-name}"));

        verify(${ entity.name.singular }Service).deleteById(anyId);

    }

//    @DisplayName("DELETE " + ${ entity.name.plural.snake.uppercase }_ID + ": delete ${ entity.name.singular.pascal } (not found) -> '204 No Content'")
//    @Test
//    void deleteOneNotFound() throws Exception {
//
//        final Long anyId = 1L;
//        willThrow(
//
//                new EntityNotFoundException(anyId)
//
//        ).given(${ entity.name.singular }Service).deleteById(anyId);
//
//        mockMvc
//                .perform(
//
//                        delete(
//                                ${ entity.name.plural.snake.uppercase }_ID.replace("{id}", anyId.toString())
//                        )
//
//                )
//                .andDo(print())
//                .andExpect(status().isOk())
//                .andExpect(jsonPathToId().value(anyId));
//
//        verify(${ entity.name.singular }Service).deleteById(anyId);
//
//    }

//    @DisplayName("PUT " + ${ entity.name.plural.snake.uppercase }_ID + ": updates ${ entity.name.singular.pascal } -> '200 Ok'")
//    @Test
//    void updateOne() throws Exception {
//
//        final int  inputId     = 1;
//        final int  outputId    = 1000;
//        ${ entity.name.singular.pascal } ${ entity.name.singular }  = setId(inputId, new ${ entity.name.singular.pascal }());
//        ${ entity.name.singular.pascal } returnValue = setId(outputId, new ${ entity.name.singular.pascal }());
//
//        given(
//                ${ entity.name.singular }Service.create(any())
//        ).willReturn(
//                returnValue
//        );
//
//        mockMvc
//                .perform(
//
//                        put(
//                                ${ entity.name.plural.snake.uppercase }_ID.replace("{id}", String.valueOf(outputId))
//                        )
//                                .contentType(MediaType.APPLICATION_JSON)
//                                .content(asJsonString(${ entity.name.singular }))
//
//                )
//                .andDo(print())
//                .andExpect(status().isOk())
//                .andExpect(jsonPathToId().value(outputId))
//                .andDo(document("{class-name}/{method-name}"));
//
//        verify(${ entity.name.singular }Service).create(any());
//
//    }
//
//    @DisplayName("PUT " + ${ entity.name.plural.snake.uppercase }_ID + ": update ${ entity.name.singular.pascal } (not found) -> '404 Not Found'")
//    @Test
//    void updateOneNotFound() throws Exception {
//
//        ${ entity.name.singular.pascal } ${ entity.name.singular } = setId(1, new ${ entity.name.singular.pascal }());
//
//        given(
//                ${ entity.name.singular }Service.create(any())
//        ).willThrow(
//                new EntityNotFoundException(${ entity.name.singular }.getId())
//        );
//
//        mockMvc
//                .perform(
//
//                        put(
//                                ${ entity.name.plural.snake.uppercase }_ID.replace("{id}", ${ entity.name.singular }.getId().toString())
//                        )
//                                .contentType(MediaType.APPLICATION_JSON)
//                                .content(asJsonString(${ entity.name.singular }))
//
//                )
//                .andDo(print())
//                .andExpect(status().isNotFound());
//
//        verify(${ entity.name.singular }Service).create(${ entity.name.singular });
//
//    }


    @DisplayName("PATCH " + ${ entity.name.plural.snake.uppercase }_ID + ": patches ${ entity.name.singular.pascal } -> '200 Ok'")
    @Test
    void patchOne() throws Exception {

        final int  inputId     = 1;
        final int  outputId    = 1000;
        ${ entity.name.singular.pascal } ${ entity.name.singular }  = setId(inputId, new ${ entity.name.singular.pascal }());
        Optional<${ entity.name.singular.pascal }> returnValue = Optional.of(setId(outputId, new ${ entity.name.singular.pascal }()));

        given(
                ${ entity.name.singular }Service.modify(any())
        ).willReturn(
                returnValue
        );

        mockMvc
                .perform(

                        patch(
                                ${ entity.name.plural.snake.uppercase }_ID.replace("{id}", String.valueOf(outputId))
                        )
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(asJsonString(${ entity.name.singular }))

                )
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPathToId().value(outputId))
                .andDo(document("{class-name}/{method-name}"));

        verify(${ entity.name.singular }Service).modify(any());

    }

    @DisplayName("PATCH " + ${ entity.name.plural.snake.uppercase }_ID + ": patches ${ entity.name.singular.pascal } (not found) -> '404 Not Found'")
    @Test
    void patchOneNotFound() throws Exception {

        ${ entity.name.singular.pascal } ${ entity.name.singular } = setId(1, new ${ entity.name.singular.pascal }());

//        given(
//                ${ entity.name.singular }Service.save(any())
//        ).willThrow(
//                new EntityNotFoundException(${ entity.name.singular }.getId())
//        );

        mockMvc
                .perform(

                        patch(
                                ${ entity.name.plural.snake.uppercase }_ID.replace("{id}", ${ entity.name.singular }.getId().toString())
                        )
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(asJsonString(${ entity.name.singular }))

                )
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPathToId().value(1));

        verify(${ entity.name.singular }Service).modify(${ entity.name.singular });

    }

}