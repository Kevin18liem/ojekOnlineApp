package ojeksoap.controller;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService
public interface Location {

    @WebMethod
    public String getPreferredLocation(String token, String username);

    @WebMethod
    public String addPreferredLocation(String token, String username, String Location);

    @WebMethod
    public String editPreferredLocation(String token, String username, String oldLocation, String newLocation);

    @WebMethod
    public String deletePreferredLocation(String token, String username, String location);

}
