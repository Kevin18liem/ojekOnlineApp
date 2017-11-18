package ojeksoap.controller;

import javax.jws.WebService;
import ojeksoap.model.Locations;
import servisojek.identityservice.controller.SessionSOAP;
import servisojek.identityservice.controller.SessionSOAPImplService;

import java.text.SimpleDateFormat;
import java.util.Date;

@WebService(endpointInterface = "ojeksoap.controller.Location")
public class LocationImpl implements Location {

    @Override
    public String getPreferredLocation(String token, String username) {
        //Check session first
        SessionSOAPImplService sessionSOAPImplService = new SessionSOAPImplService();
        SessionSOAP sessionSOAP = sessionSOAPImplService.getSessionSOAPImplPort();
        String result = sessionSOAP.checkSession(token, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

        if (result.equals("not found") || result.equals("expired")) {
            return "FORBIDDEN ACCESS";
        } else {
            return Locations.getPreferredLocation(username);
        }
    }

    public String addPreferredLocation(String token, String username, String location) {
        //Check session first
        SessionSOAPImplService sessionSOAPImplService = new SessionSOAPImplService();
        SessionSOAP sessionSOAP = sessionSOAPImplService.getSessionSOAPImplPort();
        String result = sessionSOAP.checkSession(token, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

        if (result.equals("not found") || result.equals("expired")) {
            return "FORBIDDEN ACCESS";
        } else {
            boolean status = Locations.addPreferredLocation(username, location);
            if (status) {
                return "LOCATION ADDED";
            } else {
                return "FAILED TO ADD LOCATION";
            }
        }
    }

    public String editPreferredLocation(String token, String username, String oldLocation, String newLocation) {
        //Check session first
        SessionSOAPImplService sessionSOAPImplService = new SessionSOAPImplService();
        SessionSOAP sessionSOAP = sessionSOAPImplService.getSessionSOAPImplPort();
        String result = sessionSOAP.checkSession(token, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

        if (result.equals("not found") || result.equals("expired")) {
            return "FORBIDDEN ACCESS";
        } else {
            boolean status = Locations.editPreferredLocation(username, oldLocation, newLocation);
            if (status) {
                return "LOCATION EDITED";
            } else {
                return "FAILED TO EDIT LOCATION";
            }
        }
    }

    public String deletePreferredLocation(String token, String username, String location) {
        //Check session first
        SessionSOAPImplService sessionSOAPImplService = new SessionSOAPImplService();
        SessionSOAP sessionSOAP = sessionSOAPImplService.getSessionSOAPImplPort();
        String result = sessionSOAP.checkSession(token, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));


        if (result.equals("not found") || result.equals("expired")) {
            return "FORBIDDEN ACCESS";
        } else {
            boolean status = Locations.deletePreferredLocation(username, location);
            if (status) {
                return "LOCATION DELETED";
            } else {
                return "FAILED TO DELETE LOCATION";
            }
        }
    }
}
