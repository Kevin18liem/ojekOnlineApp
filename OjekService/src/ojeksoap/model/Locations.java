package ojeksoap.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Locations {
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

    public static String getPreferredLocation (String username) {
        String prefLocation = "";
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String query = "SELECT pref_loc FROM location WHERE username ='" + username + "'";
            ResultSet res = stmt.executeQuery(query);

            while (res.next()) {
                prefLocation += res.getString("pref_loc") + "%";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return prefLocation;
    }

    public static boolean addPreferredLocation (String username, String location)  {
        boolean status = false;
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String query = "SELECT pref_loc FROM location WHERE pref_loc='" + location + "' AND username='" + username + "'";
            ResultSet set =  stmt.executeQuery(query);

            if (!set.next()) {
                query = "INSERT INTO location (username, pref_loc) VALUES ('" + username + "' , '" + location + "')";
                int res = stmt.executeUpdate(query);
                if (res == 0) {
                    status = false;
                } else {
                    status = true;
                }
            } else {
                status = false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static boolean editPreferredLocation (String username, String oldLocations, String newLocations) {
        boolean status = false;
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            if (newLocations.isEmpty()) {
                status = false;
            } else {
                String query = "SELECT pref_loc FROM location WHERE pref_loc='" + newLocations + "' AND username='" + username + "'";
                ResultSet set =  stmt.executeQuery(query);

                if (!set.next()) {
                    query = "UPDATE location SET pref_loc='" + newLocations + "' WHERE username='" + username + "' AND pref_loc='" + oldLocations + "'";
                    int res = stmt.executeUpdate(query);
                    if (res == 0) {
                        status = false;
                    } else {
                        status = true;
                    }
                } else {
                    status = false;
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static boolean deletePreferredLocation (String username, String location) {
        boolean status = false;
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String query = "DELETE FROM location WHERE username='" + username + "' AND pref_loc='" + location + "' ";
            int res = stmt.executeUpdate(query);
            if (res == 0) {
                status = false;
            } else {
                status = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}
