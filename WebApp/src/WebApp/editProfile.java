package WebApp;

import ojeksoap.controller.Users;
import ojeksoap.controller.UsersImplService;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;

@WebServlet(name = "editProfile")
@MultipartConfig
public class editProfile extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String isDriver = request.getParameter("is-driver");
            if(isDriver != null){
                if(isDriver.equals("on")){
                    isDriver = "1";
                } else {
                    isDriver = "0";
                }
            } else {
                isDriver = "0";
            }
            String oldFileName = request.getParameter("old-image-name");
            String path = request.getParameter("path-name");
            Part image = request.getPart("image");

            String fileName = Paths.get(image.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
            if(fileName.equals("")){
                fileName = oldFileName;
            }
            InputStream fileContent = image.getInputStream();

            PrintWriter printWriter = response.getWriter();
            printWriter.println(name);
            printWriter.println(phone);
            printWriter.println(isDriver); // on or null
            printWriter.println(fileName);

            Cookie[] cookies = request.getCookies();
            String token = "";
            String username = "";
            for(Cookie c : cookies){
                if(c.getName().equals("access_token")){
                    token = c.getValue();
                }
                if(c.getName().equals("username")){
                    username = c.getValue();
                }
            }

            if(!token.equals("")){
                UsersImplService usersImplService = new UsersImplService();
                Users users = usersImplService.getUsersImplPort();
                String result = users.updateUser(token, username, name, phone, isDriver , fileName);
                printWriter.println(fileName);
                if(!Paths.get(image.getSubmittedFileName()).getFileName().toString().equals("")){
                    byte[] buffer = new byte[fileContent.available()];
                    fileContent.read(buffer);
                    File outfile = new File(path + "\\img\\" + fileName);
                    if(!outfile.exists()){
                        outfile.createNewFile();
                    }
                    OutputStream outStream = new FileOutputStream(outfile);
                    outStream.write(buffer);
                }
                printWriter.println(result);
                if(result.equals("FORBIDDEN ACCESS")) {
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("profile.jsp");
                }
            } else {
                response.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
