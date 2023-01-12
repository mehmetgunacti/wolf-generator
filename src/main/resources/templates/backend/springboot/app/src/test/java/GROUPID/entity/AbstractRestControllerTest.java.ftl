package ${ info.groupId }.entity;

import com.fasterxml.jackson.databind.ObjectMapper;
import ${ info.groupId }.exception.handler.RESTExceptionHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.restdocs.RestDocumentationContextProvider;
import org.springframework.restdocs.mockmvc.MockMvcRestDocumentation;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.result.JsonPathResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.springframework.restdocs.operation.preprocess.Preprocessors.prettyPrint;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

@RequiredArgsConstructor
public abstract class AbstractRestControllerTest {

    protected final String ENTITY_NAME;
    protected final String ENTITY_NAME_PLURAL;

    protected MockMvc buildMockMvc(RestDocumentationContextProvider restDocumentation, Object controller) {

        return MockMvcBuilders
                .standaloneSetup(controller)
                .setControllerAdvice(new RESTExceptionHandler())

                // The configurer applies sensible defaults and also provides an API for customizing the configuration.
                .apply(
                        MockMvcRestDocumentation
                                .documentationConfiguration(restDocumentation)
                                .operationPreprocessors()
                                .withResponseDefaults(prettyPrint())
                )
                .build();

    }

    protected static String asJsonString(final Object obj) {

        try {

            return new ObjectMapper().writeValueAsString(obj);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    protected static String randomString() {

        return "" + Math.random();

    }

    protected static <T extends BaseEntity> T setId(int id, T entity) {

        entity.setId((long) id);
        return entity;

    }

    protected static <T extends BaseEntity> T setId(String id, T entity) {

        return setId(Integer.parseInt(id), entity);

    }

    protected JsonPathResultMatchers jsonPathToId() {

        return jsonPath("$.data.{NAME}.ids[0]".replace("{NAME}", ENTITY_NAME_PLURAL));

    }

    protected JsonPathResultMatchers jsonPathToEntity(String id) {

        return jsonPath(
                "$.data.{NAME}.entities['{id}']"
                        .replace("{NAME}", ENTITY_NAME_PLURAL)
                        .replace("{id}", id)
        );

    }

}