package servisojek.IdentityService.controller;

import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import servisojek.IdentityService.model.Session;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "Sessions", value = "Sessions")
public class Sessions extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //Get the request body
            BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
            String data = br.readLine();

            //Parse the xml
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dbBuilder = dbFactory.newDocumentBuilder();
            Document doc = dbBuilder.parse(new InputSource(new StringReader(data)));

            String userToken = doc.getElementsByTagName("token").item(0).getTextContent();
            String expiry_time = doc.getElementsByTagName("time").item(0).getTextContent();
            DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date time = sdf.parse(expiry_time);

            //Get the session from database
            String result = Session.validateSession(userToken, time);

            //Print the result
            response.setContentType("application/xml");
            PrintWriter printWriter = response.getWriter();

            printWriter.println("<?xml version=\"1.0\" ?>");
            printWriter.println("<m:Envelope xmlns:m=\"http://schemas.xmlsoap.org/soap/envelope/\">");
            printWriter.println("<m:Body>");
            printWriter.println("<result>");
            printWriter.println(result);
            printWriter.println("</result>");
            printWriter.println("</m:Body>");
            printWriter.println("</m:Envelope>");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
