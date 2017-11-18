package ojeksoap.model;

import javax.swing.plaf.nimbus.State;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class Transaction {
    /**
     * Make a Connection
     * */
    private static Connection getConnection(){
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servisojekTransaction","root","12345678");
        } catch (Exception e){
            e.printStackTrace();
        }
        return con;
    }

    public static int addTransaction(int idUser, int idDriver, String pickup, String destination, int rating, String comments){
        int success = -1;
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String sql = "INSERT INTO transaction(id_user, id_driver, pickup, destination, rating, comments, order_date,is_hidden,is_hidden_driver) values ("+
                    idUser+","+idDriver+",'"+pickup+"','"+destination+"',"+rating+",'"+comments+"',now(),0,0)";
            success = stmt.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public static ArrayList<HashMap<String, String>> searchDriverByLocation(String pickup, String destination, String preferredDriver){
        ArrayList<HashMap<String, String>> result = new ArrayList<>();
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String sql = "";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static StringBuilder getPreviousDriverDb(String username) {
        StringBuilder solution = new StringBuilder("");
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String sql = "SELECT id FROM user WHERE username='" + username + "'";
            ResultSet res = stmt.executeQuery(sql);
            int id_user=0;
            if(res.next()) {
                id_user = res.getInt("id");
            }
            sql = "SELECT * FROM user JOIN (SELECT * FROM transaction where id_user =" + id_user +") as X ON(X.id_driver = user.id);";
            ResultSet temp = stmt.executeQuery(sql);
            //TODO : append image kedalam solution
            while(temp.next()) {
                solution.append(temp.getInt("id_Transaction")+"%");
                solution.append(temp.getString("name") + "%");
                solution.append(temp.getString("pickup") + "%");
                solution.append(temp.getString("destination") +"%");
                solution.append(temp.getInt("rating") +"%");
                solution.append(temp.getString("comments") +"%");
                solution.append(temp.getString("order_date") +"%");
                solution.append(temp.getString("image") + "%");
                solution.append(temp.getString("is_hidden")+"%");
                solution.append(temp.getString("is_hidden_driver"));
                solution.append("$");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return solution;
    }

    public static StringBuilder getDriverHistoryDb(String username) {
        StringBuilder solution = new StringBuilder("");
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();
            String sql = "SELECT id FROM user WHERE username='" + username + "'";
            ResultSet res = stmt.   executeQuery(sql);
            int id_driver=0;
            if(res.next()) {
                id_driver = res.getInt("id");
            }
            sql = "SELECT * FROM user JOIN (SELECT * FROM transaction where id_driver =" + id_driver+") as X ON(X.id_user = user.id);";
            ResultSet temp = stmt.executeQuery(sql);
            while(temp.next()) {
                solution.append(temp.getInt("id_Transaction")+"%");
                solution.append(temp.getString("name") + "%");
                solution.append(temp.getString("pickup") + "%");
                solution.append(temp.getString("destination") +"%");
                solution.append(temp.getInt("rating") +"%");
                solution.append(temp.getString("comments") +"%");
                solution.append(temp.getString("order_date") +"%");
                solution.append(temp.getString("image")+"%");
                solution.append(temp.getString("is_hidden")+"%");
                solution.append(temp.getString("is_hidden_driver"));
                solution.append("$");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return solution;
    }
    public static String hideHistoryDb(String idTransaction) {
        String solution = "";
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();
            String sql = "UPDATE transaction SET is_hidden=1 where id_Transaction =" + idTransaction;
            int res = stmt.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return idTransaction;
    }

    public static String hideHistoryDriverDb(String idTransaction) {
        String solution = "";
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();
            String sql = "UPDATE transaction SET is_hidden_driver=1 where id_Transaction =" + idTransaction;
            int res = stmt.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return idTransaction;
    }
}