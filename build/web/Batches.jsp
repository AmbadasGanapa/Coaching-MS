<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@include file="Header.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Adding Batch</title>
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
        input[type="text"], input[type="email"], input[type="number"], input[type="date"],input[type="time"], .combo, textarea {
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
    <%
     String uname=request.getParameter("txtuname");
     String pass=request.getParameter("txtPassword");

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
 
     String ids= "SELECT MAX(BatchID) AS MaxId FROM TblBatches;";
        state = conn.createStatement();
        resultset = state.executeQuery(ids);
        while(resultset.next())
        {
           myid=resultset.getInt("MaxId")+1;
        }
     Date currentDate = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String formattedDate = formatter.format(currentDate);


//Retrieving course id here
     List<String> courseId = new ArrayList<>();
String Query="select CourseId from TblCourses";
state=conn.createStatement();

resultset=state.executeQuery(Query);
while(resultset.next())
{
  courseId.add(resultset.getString("CourseId"));
}
    
// Retrieving Course Names here
 List<String> courses = new ArrayList<>();
 Query="select CourseName from TblCourses";
state=conn.createStatement();

resultset=state.executeQuery(Query);
while(resultset.next())
{
  courses.add(resultset.getString("CourseName"));
}

List<String> faculties= new ArrayList<>();
List<String> facultyid= new ArrayList<>();
Query="select FacultyId,FacultyName from TblFacultyMaster";
state=conn.createStatement();

resultset=state.executeQuery(Query);
while(resultset.next())
{
  faculties.add(resultset.getString("FacultyName"));
  facultyid.add(resultset.getString("FacultyId"));
}


        %>    
  
    <br>
    <h1>Add Batches</h1>
    <div class="container">
        <!-- Form Section -->
        <div class="form-container">
            <form  method="post" action="BatchesProcessor.jsp" id="MyForm">
                <label for="courseid">Batch ID:</label>
                <input type="text" id="txtID" name="BatchId"value="<%=myid%>"  readonly="true" required > 

                <label for="name">Batch Name:</label>
                <input type="text" id="coursenamw" name="BatchName"placeholder="Enter Batch Name here ..."  required>

               
                  <label for="course">Course ID</label>
                <select id="course" name="courseId" class="combo"  required>
                    <option value="None">Select Course Id</option> 
                    <%
            for (String item : courseId) {
                     %>
            <option value="<%= item %>"><%= item %></option>
                     <%
                                        }
                     %>
                </select>
                  <label for="course">Course Name:</label>
                  <select id="course" name="courseName" class="combo" onchange="" required>
                    <option value="None">Select Course</option> 
                    <%
            for (String item : courses) {
                     %>
            <option value="<%= item %>"><%= item %></option>
                     <%
                                        }
                     %>
                </select>
                
                 <label for="course">Faculty Id</label>
                <select id="faculty" name="FacultyId" class="combo" required>
                    <option value="None">Select Faculty Id</option>                   
                    <%
            for (String item : facultyid) {
                     %>
            <option value="<%= item %>"><%= item %></option>
                     <%
                                        }
                     %>
                </select>
                  <label for="course">Faculty Name:</label>
                <select id="faculty" name="FacultyName" class="combo" required>
                    <option value="None">Select Faculty</option>                   
                    <%
            for (String item : faculties) {
                     %>
            <option value="<%= item %>"><%= item %></option>
                     <%
                                        }
                     %>
                </select>
                
                <label for="nationalitysd">Batch From</label>
                <input type="time" id="batchfrom" name="BatchFrom"  required>
 
                <label for="nationalitysd">Batch To</label>
                <input type="time" id="batchto" name="BatchTo" required>



                <input type="submit" value="Save Course" name="Submit">
            </form>
        </div>

        <!-- Data Display Table Section -->
        <div class="table-container">
            <h2>Batches Data</h2>
            
            <table>
                <thead>
                    <tr>
                        <th>Batch_ID</th>
                        <th>Batch_Name</th>
                        <th>Course_Name</th>
                        <th>Faculty_Name</th>
                       
                    </tr>
                </thead>
                <tbody>
                    <%-- Sample Data. Replace this with dynamic content --%>
   <%
       

    try {
    
       
        String sql = "select BatchID, BatchName, CourseName, FacultyName from TblBatches";
        state = conn.createStatement();

       

        // Execute the query
         resultset = state.executeQuery(sql);

     while(resultset.next())
     {
            int id=resultset.getInt("BatchID");
            String name=resultset.getString("BatchName");
            String mob=resultset.getString("CourseName");
            String Cname=resultset.getString("FacultyName");
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
                <input type="submit" class="btncrud" id="btnUpdate" value="Update">   <input type="submit"id="btnDelete" class="btncrud" value="Delete"> <input type="submit"id="btnClear" class="btncrud" value="Clear" onclick="clearFields()" >
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
