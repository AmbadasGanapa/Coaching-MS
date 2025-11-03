import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;

@WebServlet(urlPatterns = {"/MarkAttendanceServlet"})
public class MarkAttendanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        int subjectId = Integer.parseInt(request.getParameter("subject_id"));
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/attendance_db", "root", "Amul@2004");

            // Loop through all students and insert attendance
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Students");

            while (rs.next()) {
                int studentId = rs.getInt("student_id");
                String status = request.getParameter("status_" + studentId);

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Attendance (student_id, subject_id, date, status) VALUES (?, ?, CURDATE(), ?)"
                );
                ps.setInt(1, studentId);
                ps.setInt(2, subjectId);
                ps.setString(3, status);
                ps.executeUpdate();
            }

            out.println("<h3>Attendance marked successfully for Subject ID: " + subjectId + "</h3>");
        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
