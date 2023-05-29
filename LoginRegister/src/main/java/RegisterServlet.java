import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/registerServlet")
public class RegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter pw = resp.getWriter();
		resp.setContentType("text/html");
		String firstName = req.getParameter("firstName");
	    String lastName = req.getParameter("lastName");
	    String dob = req.getParameter("dob");
	    String address = req.getParameter("address");
	    String contactNo = req.getParameter("contactNo");
	    String email = req.getParameter("email");
	    String qualification = req.getParameter("qualification");
	    String gender = req.getParameter("gender");
	    String applyType = req.getParameter("applyType");
	    String password = req.getParameter("password");
//	    String citizenType = req.getParameter("citizenType");
	    String hintQuestion = req.getParameter("hintQuestion");
	    String hintAnswer = req.getParameter("hintAnswer");
//	    RequestDispatcher dispatcher = null;
	    try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (Exception e) {
        	pw.println("<h2>" + e.getMessage() +"</h2>");
        }
	    // Insert user details into the database
	    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/passport_visa_ms", "root", "Nyansohot@0502")){
	    	String userId = "";
	    	if(applyType.equalsIgnoreCase("Passport")) {
	    		userId = PassportId.generateUserID();
	    	}if(applyType.equalsIgnoreCase("Visa")) {
	    		userId = VisaId.generateUserID();
	    	}
	        String sql = "INSERT INTO User_Info (User_id, first_name, last_name, dob, address, contact_no, email_address, qualification, gender, apply_type, pass_word, Hint_Question, Hint_Answer, citizen_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, userId);
	        stmt.setString(2, firstName);
	        stmt.setString(3, lastName);
	        stmt.setString(4, dob);
	        stmt.setString(5, address);
	        stmt.setString(6, contactNo);
	        stmt.setString(7, email);
	        stmt.setString(8, qualification);
	        stmt.setString(9, gender);
	        stmt.setString(10, applyType);
	        stmt.setString(11, password);
	        stmt.setString(12, hintQuestion);
	        stmt.setString(13, hintAnswer);
	        stmt.setString(14, "Infant");
	        int rowCount = stmt.executeUpdate();
//	        dispatcher = req.getRequestDispatcher("registration.html");
	        if(rowCount == 1) {
	        	pw.println("<h2>Registration done successfully</h2>");
	        }
	        else {
	        	pw.println("<h2>Registration not done</h2>");
	        }
//	        dispatcher.forward(req, resp);
	        try {
	    		conn.close();
	    		} catch(SQLException e) {
	    			pw.println("<h2>" + e.getMessage() +"</h2>");
	    		}
	    } catch (SQLException e) {
	    	pw.println("<h2>" + e.getMessage() +"</h2>");
	    } 
	    	
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}

}
