
package appointmentDAO;

import java.util.*;
import java.sql.*;

/**
 *
 
 */
public class AppointmentBookingDAO {
    static Connection con;
    public static Connection getConnection() throws SQLException{
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hackathon", "root", "DBpassword");
            
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return con;
    }   
}
