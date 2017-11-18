package ojeksoap.controller;

import ojeksoap.model.User;
import servisojek.identityservice.controller.SessionSOAP;
import servisojek.identityservice.controller.SessionSOAPImplService;

import javax.jws.WebService;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

@WebService(endpointInterface = "ojeksoap.controller.Users")
public class UsersImpl implements Users {
    @Override
    public String createUser(String username, String name, String phone, String isDriver, String image) {
        int result = User.createUser(username, name, phone, isDriver, image);
        if(result > 0){
            return "User Created";
        } else {
            return "Creation Failed";
        }
    }

    @Override
    public String getUserByUsername(String username) {
        return User.getUserByUsername(username);
    }

    @Override
    public String updateUser(String token, String username, String name, String phone, String isDriver, String image) {
        //Check session first
        SessionSOAPImplService sessionSOAPImplService = new SessionSOAPImplService();
        SessionSOAP sessionSOAP = sessionSOAPImplService.getSessionSOAPImplPort();
        String result = sessionSOAP.checkSession(token, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

        if (result.equals("not found") || result.equals("expired")) {
            return "FORBIDDEN ACCESS";
        } else {
            int res = User.updateUser(username, name, phone, isDriver, image);
            if(res > 0){
                return "User updated";
            } else {
                return "Update failed";
            }
        }
    }

    @Override
    public String getUserRatingAndVotes(String username){
        return User.getUserRating(username);
    }
}
