package ojeksoap.controller;

import javax.jws.*;
import java.util.ArrayList;
import java.util.HashMap;

@WebService
public interface Order {
    @WebMethod
    public String createOrder(String token, int id_user, int id_driver, String pickup, String destination, int rating, String comments);

    @WebMethod
    public String searchDriver(String pickup, String destination, String preferredDriver);

    @WebMethod
    public String getDriver(String username);
}
