package servisojek.IdentityService.controller;

import servisojek.IdentityService.model.Session;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

@WebServlet(name = "Logout", value = "logout")
public class Logout extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            PrintWriter printWriter = response.getWriter();
            String token = request.getParameterValues("token")[0];
//            String token = request.getPathInfo().substring(1);
            System.out.println(token+"halo");
            int res = Session.destroySession(token);
            if(res > 0){
                response.setStatus(200);
                printWriter.println("{\"Status\":\"Okay\"}");
            } else {
                response.setStatus(500);
                printWriter.println("{\"Status\":\"Error\"}");
            }

            //Give access to sender
            String senderURL = request.getHeader("referer");
            senderURL = senderURL.substring(0, senderURL.indexOf("8")+4);
            response.setHeader("Access-Control-Allow-Origin", senderURL);
            response.setHeader("Access-Control-Allow-Methods", "POST, GET");
            response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
