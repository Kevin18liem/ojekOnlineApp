package WebApp;

import ojeksoap.controller.History;
import ojeksoap.controller.HistoryImplService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by USER on 11/8/2017.
 */

@WebServlet(name = "hideDriverHistory")
@MultipartConfig
public class hideDriverHistory extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String idTransaction = request.getParameter("idPreviousOrderTransaction");
      Cookie[] cookies = request.getCookies();
      String access_token = "";
      for(Cookie c : cookies){
        if(c.getName().equals("access_token")){
          access_token = c.getValue();
        }
      }
      if(!access_token.equals("")) {
        HistoryImplService historyImplService = new HistoryImplService();
        History history = historyImplService.getHistoryImplPort();
        String validCode = "";
        validCode = history.hideHistoryDriverById(access_token, idTransaction);
        if (validCode.equals("not found") || validCode.equals("expired")) {
          response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("history_driver.jsp") ;
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
