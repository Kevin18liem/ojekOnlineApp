package servisojek.IdentityService.controller;

import servisojek.IdentityService.model.Session;

import javax.jws.WebService;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebService(endpointInterface = "servisojek.IdentityService.controller.SessionSOAP")
public class SessionSOAPImpl implements SessionSOAP {
    @Override
    public String checkSession(String token, String time) {
        String result = "not found";
        try {
            DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date expTime = sdf.parse(time);

            //Get the session from database
            result = Session.validateSession(token, expTime);
            System.out.println("Result:" + result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
