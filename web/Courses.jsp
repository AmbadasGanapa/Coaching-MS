<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@include file="Header.jsp"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Adding Course</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
           
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .container {
            display: flex;
            justify-content: space-between;
        }
        .form-container, .table-container {
            width: 48%;
            margin:10px;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-top: 10px;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="number"], input[type="date"], .combo, textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
           
        }
        th, td {
            text-align: left;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #9b59b6;
            color: white;
        }
        
        .btncrud{
            width:100px;
            cursor: pointer;
        }
        #btnUpdate{
            background-color: green;
        }
        #btnDelete{
            background-color: rgb(255,0,0,0.8);
        }
        #btnClear{
            background-color:gray;
        }
    </style>
</head>
<body>
    <script type="text/javascript">
        //document.getElementById("txtID").innerHTML="3";
       // alert('Welcome');
        
    </script>
    <%
//     String uname=request.getParameter("txtuname");
//     String pass=request.getParameter("txtPassword");

    Class.forName("com.mysql.cj.jdbc.Driver");
    String dbURL = "jdbc:mysql://localhost:3307/mydb";
    String dbUser = "root";
    String dbPass = "Amul@2004";
    int myid=1;
    Connection conn = null;
    Statement state = null;
    boolean success = false;
    ResultSet resultset=null;
    
   
 conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
 
     String ids= "SELECT MAX(CourseID) AS MaxId FROM TblCourses;";
        state = conn.createStatement();
        resultset = state.executeQuery(ids);
        while(resultset.next())
        {
           myid=resultset.getInt("MaxId")+1;
        }
     Date currentDate = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String formattedDate = formatter.format(currentDate);

        %>
    <br>
    <h1>Add Courses</h1>
    <div class="container">
        <!-- Form Section -->
        <div class="form-container">
            <form  method="post" action="CoursesProcessor.jsp"id="MyForm">
                <label for="courseid">Course ID:</label>
                <input type="text" id="txtID" name="CourseID"value="<%=myid%>"  readonly="true" required > 

                <label for="name">Course Name:</label>
                <input type="text" id="coursenamw" name="CourseNames"  required>


                <label for="nationalitysd">Course Duration:</label>
                <input type="text" id="courseduration" name="Duration" required>

                <label for="address">Course Description: </label>
                <textarea id="address" name="CourseDescription" rows="3" ></textarea>
                
                <label for="contactNosd">Course Fees:</label>
                <input type="text" id="CourseFee" name="CourseFees"  required>

              

                <label for="startdate">Start Date:</label>
                <input type="date" id="startdate" name="StartDate" required>
                
                <label for="cert">Certificate:</label>
                <select id="cert" name="Certificate" class="combo" required>
                    <option value="Yes">Yes</option>
                    <option value="No">No</option>
                    
                </select>
                <!--<input type="text" name="course">-->
                
                <input type="submit" value="Save Course">
            </form>
        </div>

        <!-- Data Display Table Section -->
        <div class="table-container">
            <h2>Available Courses Data</h2>
            
            <table>
                <thead>
                    <tr>
                        <th>Course_ID</th>
                        <th>Course_Name</th>
                        <th>Course_Duration</th>
                        <th>Course_Fees</th>
                       
                    </tr>
                </thead>
                <tbody>
                    <%-- Sample Data. Replace this with dynamic content --%>
   <%
       

    try {
    
       
        String sql = "select CourseID,CourseName,CourseDuration,CourseFees from tblcourses";
        state = conn.createStatement();

       

        // Execute the query
         resultset = state.executeQuery(sql);

     while(resultset.next())
     {
            int id=resultset.getInt("CourseID");
            String name=resultset.getString("CourseName");
            String mob=resultset.getString("CourseDuration");
            String Cname=resultset.getString("CourseFees");
//                    response.sendRedirect("DashBoard.jsp");
%>
<tr>
    <td><%=id%></td>
    <td><%=name%></td>
    <td><%=mob%></td>
    <td><%=Cname%></td>
</tr>
<%
     
}

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (state != null) state.close();
        if (conn != null) conn.close();
    }
        %>
                    <%-- Add your dynamic rows here --%>
                </tbody>
            </table>
                <input type="submit" class="btncrud" id="btnUpdate" value="Update">   <input type="submit"id="btnDelete" class="btncrud" value="Delete"> <input type="submit"id="btnClear" class="btncrud" value="Clear" onclick="clearFields()">
        </div>
    </div>
                <script>
        function clearFields() {
            let form = document.getElementById("MyForm");
            form.reset();
        }
    </script>
</body>
</html>
