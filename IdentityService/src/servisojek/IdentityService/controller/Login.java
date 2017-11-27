package servisojek.IdentityService.controller;

import servisojek.IdentityService.model.Session;
import servisojek.IdentityService.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

@WebServlet(value = "login", name = "Login")
public class Login extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            PrintWriter printWriter = response.getWriter();

            String usernameQuery = request.getParameterValues("username")[0];
            String password = request.getParameterValues("password")[0];

            String username = User.checkIsValidUser(usernameQuery, password);
            if(!username.equals("null")){
                printWriter.println("{\"username\":\"" + username + "\"?");

                //Generate Access Token
                StringBuilder builder = new StringBuilder();
                for(int i = 0; i < 10; i++) {
                    String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
                    int character = (int)(Math.random()* ALPHA_NUMERIC_STRING.length());
                    builder.append(ALPHA_NUMERIC_STRING.charAt(character));
                }

                String userAgent = request.getParameterValues("useragent")[0];;
                String ip = request.getRemoteAddr();

                builder.append('#' + userAgent + '#' + ip);
                System.out.println(builder.toString());
                printWriter.println("\"access_token\":\"" + builder.toString() + "\"?");

                printWriter.println("\"access_token\":\"" + builder.toString() + "\"?");

                //Generate Expiry Time
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Calendar date = Calendar.getInstance();
                date.add(Calendar.MINUTE, 60);
                String expiryDate = dateFormat.format(date.getTime());

                printWriter.println("\"expiry_date\":\"" + expiryDate + "\"}");

                response.addHeader("Sessions", builder.toString());
                response.addHeader("Exp_date", expiryDate);

                //Write in DB
                Session.createSession(builder.toString(),expiryDate);

            } else {
                //Send Error Message
                response.setStatus(401);
                printWriter.println("{\"status_error\":\"Authentication error. Username and password not found.\"}");
            }

            //Give access to sender
//            String senderURL = request.getHeader("referer");
//            senderURL = senderURL.substring(0, senderURL.indexOf("8")+4);
//            response.setHeader("Access-Control-Allow-Origin", senderURL);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
