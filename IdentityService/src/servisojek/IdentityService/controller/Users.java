package servisojek.IdentityService.controller;

import servisojek.IdentityService.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URI;
import java.net.URL;
import java.nio.Buffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "Users", value = "users")
public class Users extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //TODO: get the access token and check, if invalid give 403 response forbidden
        try {
            String username = request.getPathInfo().substring(1);
            HashMap<String, String> userProfile = User.getUserByUsername(username);
            response.setContentType("application/json");
            PrintWriter printWriter = response.getWriter();

            if (userProfile != null) {
                response.setStatus(200);
                printWriter.println("{");

                if (userProfile.isEmpty()) {
                    response.setStatus(404);
                    printWriter.println("\"status\":\"User Not Found\"");
                } else {
                    printWriter.println("\"username\":\"" + userProfile.get("username") + "\",");
                    printWriter.println("\"name\":\"" + userProfile.get("name") + "\",");
                    printWriter.println("\"email\":\"" + userProfile.get("email") + "\",");
                    printWriter.println("\"phone\":\"" + userProfile.get("phone") + "\",");
                    printWriter.println("\"isDriver\":\"" + userProfile.get("isDriver") + "\",");
                    printWriter.println("\"image\":\"" + userProfile.get("image") + "\"");
                }

                printWriter.println("}");
            } else {
                response.setStatus(500);
                printWriter.println("{");

                printWriter.println("\"status\":\"Server Error\"");

                printWriter.println("}");
            }

            //Give access to sender
            String senderURL = request.getHeader("referer");
            senderURL = senderURL.substring(0, senderURL.indexOf("8")+4);
            response.setHeader("Access-Control-Allow-Origin", senderURL);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //TODO: get the access token and check, if invalid give 403 response forbidden

        try {
            response.setContentType("application/json");
            PrintWriter printWriter = response.getWriter();

            HashMap<String, String> profileMap = new HashMap<>();
            profileMap.put("username", request.getPathInfo().substring(1));

            BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
            String data = br.readLine();
            data = data.replace("%20", " ");
            String[] parameters = data.split("&");
            String[] name = parameters[0].split("=");
            String[] phone = parameters[1].split("=");
            String[] image = parameters[2].split("=");
            String[] isDriver = parameters[3].split("=");

            profileMap.put(name[0], name[1]);
            profileMap.put(phone[0], phone[1]);
            profileMap.put(image[0], image[1]);
            profileMap.put(isDriver[0], isDriver[1]);

            //Send the profile changes to server
            int res = User.editProfile(profileMap);
            if(res > 0){
                response.setStatus(201);
                printWriter.println("{");
                printWriter.println("\"status\":\"User Updated\"");
                printWriter.println("}");
            } else {
                response.setStatus(500);
                printWriter.println("{");
                printWriter.println("\"status\":\"Update Error\"");
                printWriter.println("}");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        //Give access to sender
        String senderURL = request.getHeader("referer");
        senderURL = senderURL.substring(0, senderURL.indexOf("8")+4);
        response.setHeader("Access-Control-Allow-Origin", senderURL);
    }
}
