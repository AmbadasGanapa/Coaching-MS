

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;


@WebServlet(urlPatterns = {"/getDetails"})
public class getDetails extends HttpServlet {


   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     
        String courseId = request.getParameter("courseId");
//        String temp=request.getParameter("CourseId1");
//        courseId=temp;

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/mydb", "root", "Amul@2004");
             PreparedStatement ps = conn.prepareStatement("select CourseName from TblBatches WHERE CourseId = ?")) {
        

            ps.setString(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                PrintWriter out = response.getWriter();
          //      System.out.println("Received CourseId: " + courseId + rs.());
                if (rs.next()) {
                    String courseName = rs.getString("CourseName");
                    out.write("{\"CourseName\":\"" + courseName + "\"}");
                } else {
                    out.write("{\"CourseName\":\"Not Found\"}");
                }
                out.flush();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"CourseName\":\"Error\"}");
        }
    }
}

