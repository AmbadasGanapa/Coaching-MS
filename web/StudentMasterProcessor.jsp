<%-- 
    Document   : StudentMasterProcessor
    Created on : Nov 1, 2024, 8:28:06 PM
    Author     : Admin
--%>

<%@page import="java.io.InputStream"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page errorPage="ErrorPage.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Admission Form</title>
    </head>
    <body>
        <%

            String message="";
            String SaveDate=request.getParameter("saveDate");
            String DOB=request.getParameter("DOB");
            java.sql.Date savedate=null;
            java.sql.Date dob=null;
            try{
//            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
           savedate=java.sql.Date.valueOf(SaveDate);
           dob=java.sql.Date.valueOf(DOB);

            }
            catch(Exception e)
            {
            e.printStackTrace();
            }
            //out.println(savedate);
 
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
        String sql = "INSERT INTO TblStudentMaster VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        ps = conn.prepareStatement(sql);
  // Set parameters
        
            ps.setString(1,request.getParameter("StudentIDs"));      
            ps.setDate(2,savedate);               
            ps.setString(3,request.getParameter("fullname"));           
            ps.setDate(4, dob);      
            ps.setString(5, request.getParameter("genderoptions"));           
            ps.setString(6, request.getParameter("nationality"));
            ps.setString(7,request.getParameter("contactNo"));            
            ps.setString(8,  request.getParameter("email"));
            ps.setString(9,  request.getParameter("parentName"));
            ps.setString(10, request.getParameter("parentContactNo"));
            ps.setString(11, request.getParameter("parentEmail"));
            ps.setString(12, request.getParameter("address"));
            ps.setString(13, request.getParameter("qualification"));
            


        int rowsInserted = ps.executeUpdate();
        if (rowsInserted > 0) {
            success = true;
            message="Saved Sucessfully";
 
        }
else{
    message="Somthing problem is found";
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
        
        window.location.href = "StudentMaster.jsp";
    </script>
<% } %>
    </body>
</html>
