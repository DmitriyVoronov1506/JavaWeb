package itstep.learning.servlet;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import itstep.learning.data.DataContext;
import itstep.learning.data.entity.User;
import org.json.JSONException;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

@Singleton
public class TeamServlet extends HttpServlet {
    private final DataContext dataContext;

    @Inject
    public TeamServlet(DataContext dataContext) {
        this.dataContext = dataContext;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String body;

        try(InputStream bodyStream = req.getInputStream()) {

            byte[] buf = new byte[1024];
            ByteArrayOutputStream arr = new ByteArrayOutputStream();

            int len;

            while( (len = bodyStream.read(buf)) != -1) {
                arr.write(buf, 0, len);
            }

            body = arr.toString("UTF-8");

            arr.close();
        }
        catch (Exception ex) {
            resp.getWriter().print(ex.getMessage());
            return;
        }

        try {

            JSONObject obj = new JSONObject(body);

            if(obj.has("teamName")) {

                String teamName = obj.optString("teamName");

                if (teamName == null || teamName.equals("")) {
                    resp.getWriter().print("Missing required parameter: teamName");
                    return;
                }

                if (dataContext.getTeamDao().isTeamExist(teamName)) {
                    resp.getWriter().print("teamName " + teamName + " already exist!");
                    return;
                }

                if(dataContext.getTeamDao().addTeam(teamName)) body = "OK";
                else body = "500";
            }
        }
        catch (JSONException ex) {
            body = "Error";
        }

        resp.getWriter().print(body);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String body;

        try(InputStream bodyStream = req.getInputStream()) {

            byte[] buf = new byte[1024];
            ByteArrayOutputStream arr = new ByteArrayOutputStream();

            int len;

            while( (len = bodyStream.read(buf)) != -1) {
                arr.write(buf, 0, len);
            }

            body = arr.toString("UTF-8");

            arr.close();
        }
        catch (Exception ex) {
            resp.getWriter().print(ex.getMessage());
            return;
        }

        try {

            JSONObject obj = new JSONObject(body);

            if(obj.has("id_team") || obj.has("id_user")) {

                String id_team = obj.optString("id_team");
                String id_user = obj.optString("id_user");

                System.out.println("id_team: " + id_team);
                System.out.println("id_user: " + id_user);

                if (id_team == null || id_team.equals("")) {
                    resp.getWriter().print("Missing required parameter: id_team");
                    return;
                }

                if (id_user == null || id_user.equals("")) {
                    resp.getWriter().print("Missing required parameter: id_user");
                    return;
                }

                if (dataContext.getTeamDao().isUserExist(id_team, id_user)) {
                    resp.getWriter().print("User already in team!");
                    return;
                }

                if (dataContext.getTeamDao().addUserToTeam(id_team, id_user)) body = "OK";
                else body = "500";
            }
        }
        catch (JSONException ex) {
            body = "Error";
        }

        resp.getWriter().print(body);
    }
}