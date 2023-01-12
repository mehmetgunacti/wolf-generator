package ${ info.groupId }.configuration;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Slf4j
@RequiredArgsConstructor
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    private final AppConfiguration appConfiguration;

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {

        config.enableSimpleBroker("/topic", "/queue");

        // @MessageMapping("/queue/ping/{id}"), but clients have to send to /app/queue/ping/{id}
        config.setApplicationDestinationPrefixes("/app");

    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {

        registry
                .addEndpoint("/online")
                .setAllowedOrigins(appConfiguration.getCorsAllowedOrigins());
        // .withSockJS(); // We use Stomp

    }

//    // Uncommenting this provides event.getUser() not to be null in ContextEventListener class
//    @Override
//    public void configureClientInboundChannel(ChannelRegistration registration) {
//
//        registration.interceptors(new ChannelInterceptor() {
//
//            @Override
//            public Message<?> preSend(Message<?> message, MessageChannel channel) {
//
//                Optional
//                        .ofNullable(
//                                MessageHeaderAccessor.getAccessor(
//                                        message,
//                                        StompHeaderAccessor.class
//                                )
//                        )
//                        .filter(
//                                accessor -> StompCommand.CONNECT.equals(accessor.getCommand())
//                        )
//                        .ifPresent(
//                                accessor -> accessor.setUser(
//                                        authUserService
//                                                .findByUsername(accessor.getLogin())
//                                                .orElseThrow()
//                                                .getPrincipal()
//                                )
//                        );
//                return message;
//
//            }
//
//        });
//
//    }

}