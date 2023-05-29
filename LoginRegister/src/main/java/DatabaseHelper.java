import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseHelper {
//    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydatabase";
//    private static final String DB_USERNAME = "username";
//    private static final String DB_PASSWORD = "password";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC driver not found here");
        }
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/passport_visa_ms", "admin", "Nyansohot@0502");
    }
}