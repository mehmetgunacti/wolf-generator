package ${ info.groupId }.configuration;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import org.springframework.web.socket.messaging.SessionSubscribeEvent;
import org.springframework.web.socket.messaging.SessionUnsubscribeEvent;
//
//@Slf4j
//@Component
public class ContextEventListener {

//    @EventListener
//    public void handleSessionConnectedEvent(SessionConnectedEvent event) {
//
//        log.info("*****************SessionConnectedEvent**********************.");
//        if (event.getUser() != null)
//            log.info("USER: " + event.getUser().getName());
//        else
//            log.info("event.getUser() is null");
//
//    }
//
//    @EventListener
//    public void handleSessionDisconnectEvent(SessionDisconnectEvent event) {
//
//        log.info("******************SessionDisconnectEvent*********************.");
//        if (event.getUser() != null)
//            log.info("USER: " + event.getUser().getName());
//        else
//            log.info("event.getUser() is null");
//        log.info("session disconnected.");
//        log.info(event.getSessionId());
//        log.info(event.getCloseStatus().toString());
//
//    }
//
//    @EventListener
//    public void handleSubscribe(SessionSubscribeEvent event) {
//
//        log.info("subscribed");
//
//    }
//
//    @EventListener
//    public void handleUnsubscribe(SessionUnsubscribeEvent event) {
//
//        log.info("unsubscribed");
//
//    }

}