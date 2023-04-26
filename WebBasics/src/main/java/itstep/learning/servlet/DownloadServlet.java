package itstep.learning.servlet;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import com.google.inject.name.Named;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.file.Files;

@Singleton
public class DownloadServlet extends HttpServlet {
    @Inject @Named("AvatarFolder") private String avatarFolder;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletContext().getRealPath("/") + avatarFolder; // из Upload (RegUser)
        String requestedFile = req.getPathInfo();

        File file = new File(path, requestedFile);

        if (file.isFile() && file.canRead()) {

            String mimeType = Files.probeContentType(file.toPath());

            if(!mimeType.startsWith("image") || (mimeType.endsWith("gif") || mimeType.endsWith("avif"))) {

                resp.setStatus(415);
                resp.getWriter().print("Unsupported Media Type: " + mimeType);
                return;
            }

            if(mimeType.endsWith("class") || mimeType.endsWith("php") || mimeType.endsWith("exe")) {
                System.err.println("DownloadServlet:: forbidden type: " + mimeType);
                return;
            }

            resp.setContentType(mimeType);

            byte[] buf = new byte[1024];

            try (InputStream reader = Files.newInputStream(file.toPath());
                  OutputStream writer = resp.getOutputStream()) {
                int len;

                while ( (len = reader.read(buf) ) != -1) {
                    writer.write(buf, 0, len);
                }
            }
            catch (IOException ex) {
                resp.setStatus(500);
                System.err.println("DownloadServlet: " + ex.getMessage());
            }
        }
    }
}