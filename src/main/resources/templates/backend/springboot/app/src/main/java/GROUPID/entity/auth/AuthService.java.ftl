package ${ info.groupId }.entity.auth;

public interface AuthService {

    void remindPassword(String username);

    void changePassword(String username, String password);

    void enableAccount(Long userId);

    void disableAccount(Long userId);

    void toggleRole(Long userId, String role);

    void grantRole(Long userId, String role);

    void revokeRole(Long userId, String role);

}
