package ojeksoap.controller;

import javax.jws.*;

import com.sun.deploy.net.HttpRequest;
import ojeksoap.model.Transaction;
import ojeksoap.model.User;
import servisojek.identityservice.controller.SessionSOAP;
import servisojek.identityservice.controller.SessionSOAPImplService;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

@WebService(endpointInterface = "ojeksoap.controller.Order")
public class OrderImpl implements Order {

    @Override
    public String createOrder(String token, int id_user, int id_driver, String pickup, String destination, int rating, String comments) {
        //Check session first
        SessionSOAPImplService sessionSOAPImplService = new SessionSOAPImplService();
        SessionSOAP sessionSOAP = sessionSOAPImplService.getSessionSOAPImplPort();
        String result = sessionSOAP.checkSession(token, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

        if(result.equals("not found") || result.equals("expired")){
            return result;
        } else {
            //Execute the query
            int rows = -1;
            try {
                rows = Transaction.addTransaction(id_user, id_driver, pickup, destination, rating, comments);
            } catch (Exception e) {
                e.printStackTrace();
            }

            if(rows > 0){
                return "Transaction Created";
            } else {
                return "Transaction Failed";
            }
        }
    }

    @Override
    public String searchDriver(String pickup, String destination, String preferredDriver){
        return User.searchDriverByLocation(pickup, destination);
    }
}
