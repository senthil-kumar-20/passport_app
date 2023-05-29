import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve the username and password from the request parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check if the username and password are valid
        if (isValidCredentials(username, password)) {
            out.println("<h1>Login Successful</h1>");
        } else {
            out.println("<h1>Username or Password Incorrect</h1>");
            out.println("<a href=\"login.html\">Go back to Login Page</a");
        }
        out.close();
    }

    private boolean isValidCredentials(String username, String password) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish a connection to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/passport_visa_ms", "root", "Nyansohot@0502");

            // Prepare the SQL statement to check the credentials
            String sql = "SELECT * FROM user_info WHERE User_id = ? AND pass_word = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            

            // Execute the query
            rs = stmt.executeQuery();

            // Check if the query returned any results
            if (rs.next()) {
                // Credentials are valid
                return true;
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the database resources
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Credentials are invalid
        return false;
    }
}