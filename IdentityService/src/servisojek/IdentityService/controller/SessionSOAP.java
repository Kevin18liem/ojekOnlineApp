package servisojek.IdentityService.controller;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService
public interface SessionSOAP {
    @WebMethod
    public String checkSession(String token, String time);
}
