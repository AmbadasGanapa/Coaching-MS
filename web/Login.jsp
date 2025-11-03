<%-- 
    Document   : Login
    Created on : Oct 28, 2024, 10:28:24 AM
    Author     : Admin
--%>

<%--<%@page import="com.sun.jdi.connect.spi.Connection"%>--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Jsp</title>
    </head>
    <body>
  <% 
    String dbURL = "jdbc:mysql://localhost:3307/mydb";
    String dbUser = "root";
    String dbPass = "Amul@2004";

    Connection conn = null;
    PreparedStatement ps = null;
    boolean success = false;
    ResultSet resultset=null;

    try {
    
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        String uname=request.getParameter("txtuname");
        String pass=request.getParameter("txtPassword");
   

//     if(pass.length()>0  || uname.length()>0)
//     { 
         
        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

   // SQL INSERT query
        String sql = "select username,password from tblregister where username=? AND password=?";
        ps = conn.prepareStatement(sql);

        // Set parameters
            ps.setString(1, request.getParameter("txtuname"));
            ps.setString(2, request.getParameter("txtpassword"));

        // Execute the query
         resultset = ps.executeQuery();
//        out.println(resultset.toString());
      //  response.sendRedirect("Web-INF//index.html");
       // out.println(rowsInserted);
   if (!resultset.isBeforeFirst()) { // Returns false if there are no rows
                out.println("<center><h4>If you are new then <a href='RegistrationForm.html'>Click here</a></h4></center>");
               out.println( "<script type='text/javascript'> showAlert()</script>");
                out.println("<center>Otherwise Enter correct login credentials <a href='index.html'>Click here</a></center>");


            }
            else{
     while(resultset.next())
     {
          HttpSession se=request.getSession();
          se.setAttribute("user", request.getParameter("txtuname"));
          se.setAttribute("pass", request.getParameter("txtpassword"));
          // session.setAttribute(("user"), request.getParameter("txtuname"));
         //  session.setAttribute("pass", request.getParameter("txtpassword"));
      //     application.setAttribute(("user"), request.getParameter("txtuname"));
       //    application.setAttribute("pass", request.getParameter("txtpassword"));
           
           response.sendRedirect("DashBoard.jsp");

     }}
//}
//else{
//      out.println("Please Enter correct Login Credentials");
//    }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
            
//            
//            String uname=(String)request.getParameter("txtuname").trim();
//            String pass=(String)request.getParameter("txtpassword").trim();
//              
//            if(uname.equals("admin") && pass.equals("12345"))
//            {
//                response.sendRedirect("DashBoard.jsp");
//
//            }
//            else{
//            out.println("<script type='text/javascript' > alert('Please Enter Correct Login Credentials');<script>");
//           
//        }
        %>
           <script type="text/javascript">
        function showAlert() {
            alert("This is an alert box!");
        }
    </script>
    </body>
    
</html>
