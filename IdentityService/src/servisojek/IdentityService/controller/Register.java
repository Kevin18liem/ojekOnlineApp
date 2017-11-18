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

/**
 * Created by USER on 11/2/2017.
 */
@WebServlet(value="register", name = "Register")
public class Register extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      response.setContentType("application/json");
      PrintWriter printWriter = response.getWriter();

      String Email = request.getParameterValues("email")[0];
      String password = request.getParameterValues("password")[0];
      String username = request.getParameterValues("username")[0];
      String name = request.getParameterValues("name")[0];

      int kodeSukses = User.registerUser(Email,password,username,name);
      if(kodeSukses==1) {
        //Generate Access Token
        StringBuilder builder = new StringBuilder();
        for(int i = 0; i < 10; i++) {
          String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
          int character = (int)(Math.random()* ALPHA_NUMERIC_STRING.length());
          builder.append(ALPHA_NUMERIC_STRING.charAt(character));
        }

        //Generate Expiry Time
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar date = Calendar.getInstance();
        date.add(Calendar.MINUTE, 60);
        String expiryDate = dateFormat.format(date.getTime());

        response.setStatus(200);
        printWriter.println("{\"username\":\"" + username + "\",");
        printWriter.println("\"access_token\":\"" + builder.toString() + "\",");
        printWriter.println("\"expiry_date\":\"" + expiryDate + "\"}");

        //Write to DB
        Session.createSession(builder.toString(),expiryDate);
      } else {
        response.setStatus(401);
        printWriter.println("{\"status_error\":\"Authentication error. Username or email not valid.\"}");
      }

    } catch (Exception e) {
      e.printStackTrace();
    }
  }

}
