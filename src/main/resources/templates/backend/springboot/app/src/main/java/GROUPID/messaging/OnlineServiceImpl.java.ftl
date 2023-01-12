package ${ info.groupId }.messaging;

import ${ info.groupId }.entity.user.User;
import ${ info.groupId }.entity.user.UserDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import static ${ info.groupId }.constant.RestMapping.TOPIC_WHO_IS_ONLINE;

@Slf4j
@RequiredArgsConstructor
@Service
public class OnlineServiceImpl implements OnlineService {

    private final OnlineMapper          onlineMapper;
    private final SimpMessagingTemplate simpMessagingTemplate;

    private final Map<Long, Instant> onlineUsers = new HashMap<>();

    @Override
    public void ping(Long id) {

        synchronized (onlineUsers) {
            onlineUsers.put(id, Instant.now());
        }

    }

    // @Scheduled(fixedRate = 3000)
    void pushWhoIsOnlineList_TestData() {

        int        random = (int) (Math.random() * 10);
        List<User> list   = new ArrayList<>();
        for (int i = 0; i < random; ++i) {

            User user = new User();
            user.setId((long) i);
            user.setName("User_" + i);
            user.setUsername("username_" + i);
            list.add(user);

        }
        simpMessagingTemplate.convertAndSend(

                TOPIC_WHO_IS_ONLINE,
                new UserDTO(
                        list
                )

        );

    }

    @Scheduled(fixedRate = 3000)
    void pushWhoIsOnlineList() {

        synchronized (onlineUsers) {

            Set<Long> keys = onlineUsers.keySet();
            if (keys.size() > 0)
                simpMessagingTemplate.convertAndSend(

                        TOPIC_WHO_IS_ONLINE,
                        new UserDTO(
                                onlineMapper.findAll(keys)
                        )

                );

        }

    }

    @Scheduled(fixedRate = 15000)
    void removeOfflineUsers() {

        synchronized (onlineUsers) {
            onlineUsers
                    .entrySet()
                    .removeIf(duo -> Instant.now().minusSeconds(10).isAfter(duo.getValue()));
        }

    }

}