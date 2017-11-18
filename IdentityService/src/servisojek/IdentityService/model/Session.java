package servisojek.IdentityService.model;


import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Session {
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

    public static String validateSession(String token, Date time){
        String result = "not found";
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String sql = "SELECT * FROM session WHERE token='" + token + "'";
            ResultSet res = stmt.executeQuery(sql);

            while(res.next()){
                Timestamp expiry = res.getTimestamp("expiry");
                Date date = new Date(expiry.getTime());

                if(time.after(date)){
                    if(time.getTime()-date.getTime()>600000)
                        result = "expired";
                    else {
                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Calendar dateNow = Calendar.getInstance();
                        dateNow.add(Calendar.MINUTE,60);
                        String expiryDate = dateFormat.format(dateNow.getTime());
                        sql = "UPDATE session SET expiry='"+ expiryDate +"' WHERE token='"+token+"'";
                        int row = stmt.executeUpdate(sql);
                        if(row>0)
                            result="valid";
                        else
                            result = "expired";
                    }
                } else {
                    result = "valid";
                }
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    public static int createSession(String token, String time){
        int row = -1;
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String sql = "INSERT INTO session VALUES('"+token+"','"+ time +"')";
            row = stmt.executeUpdate(sql);
        } catch (Exception e){
            e.printStackTrace();
        }
        return row;
    }

    public static int destroySession(String token){
        int row = -1;
        try {
            Connection con = getConnection();
            Statement stmt = con.createStatement();

            String sql = "DELETE FROM session WHERE token='"+token+"'";
            row = stmt.executeUpdate(sql);
        } catch (Exception e){
            e.printStackTrace();
        }
        return row;
    }
}
