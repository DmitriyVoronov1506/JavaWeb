package itstep.learning.servlet;

import itstep.learning.model.AboutModel;
import com.google.inject.Singleton;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@Singleton
public class AboutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        AboutModel model = new AboutModel();
        model.setMessage("Hello from servlet");
        model.setMoment(new Date());

        req.setAttribute("data", model);

        req.getRequestDispatcher("WEB-INF/about.jsp").forward(req, resp);
    }
}
