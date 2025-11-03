import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;

@WebServlet(urlPatterns = {"/ViewAttendanceServlet"})
public class ViewAttendanceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        int subjectId = Integer.parseInt(request.getParameter("subject_id"));
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/attendance_db", "root", "Amul@2004");
  
            PreparedStatement ps = con.prepareStatement(
                "SELECT s.student_name, a.date, a.status FROM Attendance a " +
                "JOIN Students s ON a.student_id = s.student_id WHERE a.subject_id = ?"
            );
            ps.setInt(1, subjectId);
            ResultSet rs = ps.executeQuery();

            // Start HTML structure with Bootstrap for styling
            out.println("<!DOCTYPE html>");
            out.println("<html lang='en'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Attendance Report</title>");
            out.println("<link href='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css' rel='stylesheet'>");
            out.println("<style> .table { margin-top: 20px; } </style>");
            out.println("</head>");
            out.println("<body class='bg-light'>");

            out.println("<div class='container'>");
            out.println("<h3 class='text-center mt-5 mb-4'>Attendance Report</h3>");

            if (rs.next()) {
                // Table displaying the attendance
                out.println("<table class='table table-bordered table-striped'>");
                out.println("<thead class='thead-dark'><tr><th>Student Name</th><th>Date</th><th>Status</th></tr></thead>");
                out.println("<tbody>");

                do {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("student_name") + "</td>");
                    out.println("<td>" + rs.getDate("date") + "</td>");
                    out.println("<td>" + rs.getString("status") + "</td>");
                    out.println("</tr>");
                } while (rs.next());

                out.println("</tbody>");
                out.println("</table>");
            } else {
                // If no attendance data found
                out.println("<div class='alert alert-warning text-center'>No attendance records found for the selected subject.</div>");
            }
            
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");

        } catch (Exception e) {
            out.println("<div class='alert alert-danger text-center mt-3'>" +
                        "An error occurred: " + e.getMessage() + "</div>");
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
