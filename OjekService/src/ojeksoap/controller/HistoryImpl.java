package ojeksoap.controller;

import ojeksoap.model.Transaction;
import servisojek.identityservice.controller.SessionSOAP;
import servisojek.identityservice.controller.SessionSOAPImplService;

import javax.jws.WebService;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by USER on 11/4/2017.
 */

@WebService(endpointInterface = "ojeksoap.controller.History")
public class HistoryImpl implements History {
  @Override
    public String getPreviousOrderByUsername(String accessToken, String username) {
      SessionSOAPImplService sessionSOAPImplService = new SessionSOAPImplService();
      SessionSOAP sessionSOAP = sessionSOAPImplService.getSessionSOAPImplPort();
      String resultValidation = sessionSOAP.checkSession(accessToken, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

      if(resultValidation.equals("not found") || resultValidation.equals("expired")) {
        return resultValidation;
      } else {
        StringBuilder result = Transaction.getPreviousDriverDb(username);
        return result.toString();
      }
  }
  @Override
  public String getDriverHistoryByUsername(String accessToken, String username) {
    SessionSOAPImplService sessionSOAPImplService = new SessionSOAPImplService();
    SessionSOAP sessionSOAP = sessionSOAPImplService.getSessionSOAPImplPort();
    String resultValidation = sessionSOAP.checkSession(accessToken, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

    if(resultValidation.equals("not found") || resultValidation.equals("expired")) {
      return resultValidation;
    } else {
      StringBuilder result = Transaction.getDriverHistoryDb(username);
      return result.toString();
    }

  }
  @Override
  public String hideHistoryByUsername(String accessToken, String idTransaction ) {
    SessionSOAPImplService sessionSOAPImplService = new SessionSOAPImplService();
    SessionSOAP sessionSOAP = sessionSOAPImplService.getSessionSOAPImplPort();
    String resultValidation = sessionSOAP.checkSession(accessToken, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

    if(resultValidation.equals("not found") || resultValidation.equals("expired")) {
      return resultValidation;
    } else {
      String result = Transaction.hideHistoryDb(idTransaction);
      return "Success";
    }
  }

  public String hideHistoryDriverById(String accessToken, String idTransaction) {
    SessionSOAPImplService sessionSOAPImplService = new SessionSOAPImplService();
    SessionSOAP sessionSOAP = sessionSOAPImplService.getSessionSOAPImplPort();
    String resultValidation = sessionSOAP.checkSession(accessToken, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
    if(resultValidation.equals("not found") || resultValidation.equals("expired")) {
      return resultValidation;
    } else {
      String result = Transaction.hideHistoryDriverDb(idTransaction);
      return "Success";
    }
  }
}
