package ojeksoap.controller;

import javax.jws.WebMethod;
import javax.jws.WebService;
import java.util.ArrayList;
import java.util.HashMap;

@WebService
public interface Users {
    @WebMethod
    public String createUser(String username, String name, String phone, String isDriver, String image);

    @WebMethod
    public String getUserByUsername(String username);

    @WebMethod
    public String updateUser(String token, String username, String name, String phone, String isDriver, String image);

    @WebMethod
    public String getUserRatingAndVotes(String username);
}
