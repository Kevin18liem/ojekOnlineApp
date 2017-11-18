package ojeksoap.controller;

import javax.jws.*;

/**
 * Created by USER on 11/4/2017.
 */

@WebService
public interface History {
  @WebMethod
  public String getPreviousOrderByUsername(String accessToken, String username);
  public String getDriverHistoryByUsername(String accessToken, String username);
  public String hideHistoryByUsername(String accessToken,String idTransaction );
  public String hideHistoryDriverById(String accessToken, String idTransaction);
}
