package ${ info.groupId }.messaging;

import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.stereotype.Controller;

import static ${ info.groupId }.constant.RestMapping.QUEUE_PING_ID;

@Slf4j
@RequiredArgsConstructor
@Controller
public class OnlineController {

    private final OnlineService onlineService;

    @MessageMapping(QUEUE_PING_ID)
    @Operation(summary = "Client sends ping")
    public void ping(@DestinationVariable Long id) {

        // log.debug("ping received: " + id);
        onlineService.ping(id);

    }

}
