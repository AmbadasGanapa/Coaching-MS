
<%@page import="java.io.InputStream"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page errorPage="ErrorPage.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adding Course</title>
    </head>
    <body>
        <%

            String message="";
            String StartDate=request.getParameter("StartDate");
         //  Double fees=Double.parseDouble(request.getParameter("CourseFees"));
            java.sql.Date startdate=null;
            

          //  java.sql.Date dob=null;
            try{
//            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
           startdate=java.sql.Date.valueOf(StartDate);


            }
            catch(Exception e)
            {
            e.printStackTrace();
            }
           
 
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
        String sql = "INSERT INTO tblcourses VALUES(?,?,?,?,?,?,?)";
        ps = conn.prepareStatement(sql);
  // Set parameters
        
            ps.setString(1,request.getParameter("CourseID"));      
            ps.setString(2,request.getParameter("CourseNames"));               
            ps.setString(3,request.getParameter("Duration"));           
            ps.setString(4, request.getParameter("CourseDescription"));      
            ps.setString(5, request.getParameter("CourseFees"));           
            ps.setDate(6, startdate );
            ps.setString(7,  request.getParameter("Certificate"));


        //out.println("Hello World  "+request.getParameter("CourseID")+request.getParameter("CourseName")+request.getParameter("Duration")+request.getParameter("CourseDescription")+request.getParameter("CourseFees")+" "+fees+" "+startdate+" "+ request.getParameter("Certificate"));
        int rowsInserted =ps.executeUpdate();
 // out.println("Hello World"+request.getParameter("CourseID")+" "+fees);
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
        
        window.location.href = "Courses.jsp";
    </script>
<% } %>
    </body>
</html>
