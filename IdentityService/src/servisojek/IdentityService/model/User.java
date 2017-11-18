package servisojek.IdentityService.model;

import jdk.nashorn.internal.runtime.ECMAException;

import javax.swing.plaf.nimbus.State;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class  User {
    /**
     * Make a Connection
     * */
    private static Connection getConnection(){
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servisojek","root","12345678");
        } catch (Exception e){
            e.printStackTrace();
        }
        return con;
    }

    public static String checkIsValidUser(String email, String password){
        String username = "null";
        try {
            Connection con = getConnection();

            Statement stmst = con.createStatement();
            String query = "SELECT * FROM user WHERE email='" + email + "' and password='" + password + "'";
            ResultSet res = stmst.executeQuery(query);

            //Get Results
            while(res.next()){
                username = res.getString("username");
            }

        } catch (Exception e) {
           e.printStackTrace();
        }

        return username;
    }

    public static int registerUser(String email, String password, String username, String name) {
        try {
            Connection con = getConnection();
            Statement stmst = con.createStatement();
            Boolean valid = true;
            //Cek username not used
            String cekValid = "SELECT * FROM user WHERE username='" + username + "'";
            ResultSet resValid = stmst.executeQuery(cekValid);
            valid = resValid.next();
            if(valid) {
                return 0;
            }
            //Cek Email not used
            cekValid = "SELECT * FROM user WHERE email='" + email + "'";
            resValid = stmst.executeQuery(cekValid);
            valid = resValid.next();
            if(valid) {
                return 0;
            }
            String query = "insert into user(username,name,email,password) values('"+
                    username+"','"+name+"','"+email+"','"+password+"');";
            stmst.executeUpdate(query);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 1;
    }

    public static HashMap<String, String> getUserByUsername(String username) {
        HashMap<String, String> userProfile = new HashMap<>();
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String query = "SELECT * FROM user WHERE username='" + username + "'";
            ResultSet res = stmt.executeQuery(query);

            //Get Results
            while(res.next()){
                userProfile.put("username", res.getString("username"));
                userProfile.put("name", res.getString("name"));
                userProfile.put("email", res.getString("email"));
                userProfile.put("phone", res.getString("phone"));
                userProfile.put("isDriver", res.getString("isDriver"));
                userProfile.put("image", res.getString("image"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userProfile;
    }

    public static int editProfile(HashMap<String, String> changes) {
        int success = 0;

        String username = changes.get("username");
        String name = changes.get("name");
        String phone = changes.get("phone");
        String image = changes.get("image");
        String isDriver = changes.get("isDriver");

        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();
            String sql;

            if(name != null){
                sql = "UPDATE user SET name='" + name + "' WHERE username='" + username + "'";
                success = stmt.executeUpdate(sql);
            }
            if(phone != null){
                sql = "UPDATE user SET phone='" + phone + "' WHERE username='" + username + "'";
                success = stmt.executeUpdate(sql);
            }
            if(image != null){
                sql = "UPDATE user SET image='" + image + "' WHERE username='" + username + "'";
                success = stmt.executeUpdate(sql);
            }
            if(isDriver != null){
                sql = "UPDATE user SET isDriver='" + isDriver + "' WHERE username='" + username + "'";
                success = stmt.executeUpdate(sql);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
}
