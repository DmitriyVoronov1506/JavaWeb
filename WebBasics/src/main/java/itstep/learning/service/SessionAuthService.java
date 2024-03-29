package itstep.learning.service;
import com.google.inject.Singleton;
import itstep.learning.data.entity.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Singleton
public class SessionAuthService implements itstep.learning.service.AuthService {
    private User authUser;

    @Override
    public void authorize(HttpServletRequest request) {
        HttpSession session = request.getSession();
        authUser = (User) session.getAttribute("authUser");
    }

    @Override
    public User getAuthUser() {
        return authUser;
    }

    @Override
    public void logout(HttpServletRequest request) {
        request.getSession().removeAttribute("authUser");
    }
}