
<%@page import="java.io.InputStream"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page errorPage="ErrorPage.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adding Batches</title>
    </head>
    <body>
        <%

            String message="";
 
    String dbURL = "jdbc:mysql://localhost:3307/mydb";
    String dbUser = "root";
    String dbPass = "Amul@2004";
    Connection conn = null;
    PreparedStatement ps = null;
    boolean success = false;

    try {
    

        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

     
        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

   // SQL INSERT query
        String sql = "INSERT INTO TblBatches VALUES(?,?,?,?,?,?,?,?)";
        ps = conn.prepareStatement(sql);
  // Set parameters
        

            ps.setString(1,request.getParameter("BatchId"));      
            ps.setString(2,request.getParameter("BatchName"));  
            ps.setString(3, request.getParameter("courseId"));
            ps.setString(4,request.getParameter("courseName")); 
            ps.setString(5,request.getParameter("FacultyId"));            
            ps.setString(6, request.getParameter("FacultyName"));      
            ps.setString(7, request.getParameter("BatchFrom"));     
            ps.setString(8, request.getParameter("BatchTo"));

            int rowsInserted =ps.executeUpdate();
           if (rowsInserted > 0) {
                 success = true;
                  message="Saved Sucessfully";
               }
        else{
                   message="Something problem is found";
            }

    } catch (Exception e) {
e.printStackTrace();
            } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
 
        %>
        
<% if (!message.isEmpty()) { %>
    <script type="text/javascript">
        alert("<%= message %>");
        
        window.location.href = "Batches.jsp";
    </script>
<% } %>
    </body>
</html>
