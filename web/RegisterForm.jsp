<%-- 
    Document   : RegisterForm
    Created on : Oct 27, 2024, 4:44:24 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
    </head>
    <body>
        <%@ page import="java.sql.*" %>
<%  // Database connection details
    String dbURL = "jdbc:mysql://localhost:3307/mydb";
    String dbUser = "root";
    String dbPass = "Amul@2004";
    String message="";
    Connection conn = null;
    PreparedStatement ps = null;
    boolean success = false;

    try {
    

        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        String pass=request.getParameter("txtPassword");
        String CPass=request.getParameter("txtConfirmPass");
     if(pass.equals(CPass))
     { 
     
        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

   // SQL INSERT query
        String sql = "INSERT INTO tblregister VALUES(?,?,?,?,?,?,?)";
        ps = conn.prepareStatement(sql);

        // Set parameters
        
            ps.setString(1,request.getParameter("txtFullName"));
            ps.setString(2, request.getParameter("txtEmail"));
            ps.setLong(3,Long.parseLong(request.getParameter("txtPhoneNum")));
            ps.setString(4, request.getParameter("gender"));
            ps.setString(5, request.getParameter("txtUsername"));
            ps.setString(6, request.getParameter("txtPassword"));
            ps.setString(7, request.getParameter("usertype"));


        // Execute the query
        int rowsInserted = ps.executeUpdate();
        
        if (rowsInserted > 0) {
            success = true;
            message="Registered Successfully";
//            response.sendRedirect("index.html");
        }
        else{
        message="Something went wrong";
    }
}
else{
//      out.println("Please Enter correct passwords");
      %>
      <script type=""> 
      alert("Please Enter Correct Password");
      </script>
      
      <%
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
        
        window.location.href = "index.html";
    </script>
<% } %>

    </body>
</html>
