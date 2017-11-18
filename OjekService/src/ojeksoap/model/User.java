package ojeksoap.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class User {
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

    public static int createUser(String username, String name, String phone, String isDriver, String image){
        int rows = -1;
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String sql = "insert into user(username,name,phone,isDriver,image) values('"+
                    username+"','"+name+"','"+phone+"',"+isDriver+",'"+image+"')";
            rows = stmt.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rows;
    }

    public static String getUserByUsername(String username){
        String profileUser = "";
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String sql = "SELECT * FROM user WHERE username='" + username + "'";
            ResultSet res = stmt.executeQuery(sql);

            while(res.next()){
                profileUser += res.getString("username") + "%";
                profileUser += res.getString("name") + "%";
                profileUser += res.getString("phone") + "%";
                profileUser += res.getString("isDriver") + "%";
                profileUser += res.getString("image") + "%";
                profileUser += res.getString("id") + "%";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return profileUser;
    }

    public static int updateUser(String username, String name, String phone, String isDriver, String image){
        int result = -1;
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();
            String sql;

            if(name != null){
                sql = "UPDATE user SET name='" + name + "' WHERE username='" + username + "'";
                result = stmt.executeUpdate(sql);
            }
            if(phone != null){
                sql = "UPDATE user SET phone='" + phone + "' WHERE username='" + username + "'";
                result = stmt.executeUpdate(sql);
            }
            if(isDriver != null){
                sql = "UPDATE user SET isDriver=" + isDriver + " WHERE username='" + username + "'";
                result = stmt.executeUpdate(sql);
            }
            if(image != null){
                sql = "UPDATE user SET image='" + image + "' WHERE username='" + username + "'";
                result = stmt.executeUpdate(sql);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static String searchDriverByLocation(String pickup, String destination){
        StringBuilder result = new StringBuilder();
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String sql = "SELECT DISTINCT username, name, image, isDriver FROM user NATURAL JOIN location WHERE "+
                    "pref_loc LIKE '%"+pickup+"%' OR pref_loc LIKE '%"+destination+"%'";
            ResultSet res = stmt.executeQuery(sql);

            while(res.next()){
                result.append(res.getString("username"));
                result.append("%");
                result.append(res.getString("name"));
                result.append("%");
                result.append(res.getString("image"));
                result.append("%");
                result.append(res.getInt("isDriver"));
                result.append("$");
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
        return result.toString();
    }

    public static String getUserRating(String username){
        StringBuilder rating = new StringBuilder();
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            //Get Rating
            String sql = "select id_driver,avg(rating) as avg_rating, count(rating) as votes from transaction " +
                    "where id_driver=(select distinct id from user where username='"+username+"') group by id_driver";
            ResultSet res = stmt.executeQuery(sql);

            while(res.next()){
                rating.append(res.getString("id_driver"));
                rating.append("%");
                rating.append(res.getString("avg_rating"));
                rating.append("%");
                rating.append(res.getInt("votes"));
            }

            // if query returns nothing, the driver has no transaction, still have to return id and votes
            if(rating.toString().equals("")){
                sql = "select id from user where username='"+username+"'";
                res = stmt.executeQuery(sql);
                while(res.next()){
                    rating.append(res.getString("id"));
                    rating.append("%%");
                    rating.append("0");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rating.toString();
    }
}
