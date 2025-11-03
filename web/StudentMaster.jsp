<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@include file="Header.jsp"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Form</title>
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
 
     String ids= "SELECT MAX(StudentID) AS MaxId FROM TblStudentMaster;";
        state = conn.createStatement();
        resultset = state.executeQuery(ids);
        while(resultset.next())
        {
           myid=resultset.getInt("MaxId")+1;
        }
     Date currentDate = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String formattedDate = formatter.format(currentDate);


//
//// Retrieving Course Names here
// List<String> items = new ArrayList<>();
//String Query="select CourseName from TblCourses";
//state=conn.createStatement();
//
//resultset=state.executeQuery(Query);
//while(resultset.next())
//{
//  items.add(resultset.getString("CourseName"));
//}
//     
%>
    <br>
    <h1>Student Details Form</h1>
    <div class="container">
        <!-- Form Section -->
        <div class="form-container">
            <form  method="post" action="StudentMasterProcessor.jsp" id="MyForm">
                <label for="studentIdsd">Student ID:</label>
                <input type="text" id="txtID" name="StudentIDs"value="<%=myid%>"  readonly="true" required > 

                <label for="saveDated">Save Date:</label>
                <input type="date" id="saveDate" name="saveDate" value="<%=formattedDate%>" required>

                <label for="name">Full Name:</label>
                <input type="text" id="name" name="fullname" tabindex="0" required>

                <label for="dobds">Date of Birth:</label>
                <input type="date" id="dob" name="DOB" required>

                <label for="opt">Gender:</label>
                <select name="genderoptions" class="combo" >
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
                <!--<input type="text" name="genderoptions">-->
                

                <label for="nationalitysd">Nationality:</label>
                <input type="text" id="nationality" name="nationality" required>

                <label for="contactNosd">Contact Number:</label>
                <input type="text" id="contactNo" name="contactNo" maxlength="12" required>

                <label for="emailds">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="parentNames">Parent's Name:</label>
                <input type="text" id="parentName" name="parentName" required>

                <label for="parentContactNosd">Parent's Contact Number:</label>
                <input type="text" id="parentContactNo" name="parentContactNo" maxlength="12" required>

                <label for="parentEmail">Parent's Email:</label>
                <input type="email" id="parentEmail" name="parentEmail" required>

                <label for="address">Address:</label>
                <textarea id="address" name="address" rows="3" ></textarea>

                <label for="qualification">Qualification:</label>
                <input type="text" id="qualification" name="qualification" required>

                
                <label for="photo">ID Size Photo:</label>
                <input type="file" id="photo" name="photo" accept="image/*" >

                <input type="submit" value="Submit Admission">
            </form>
        </div>

        <!-- Data Display Table Section -->
        <div class="table-container">
            <h2>Student Admissions Data</h2>
            
            <table>
                <thead>
                    <tr>
                        <th>Student_ID</th>
                        <th>Name</th>
                        <th>Contact</th>
                        <th>Qualification</th>
                       
                    </tr>
                </thead>
                <tbody>
                    <%-- Sample Data. Replace this with dynamic content --%>
   <%
       

    try {
    
       
        String sql = "select StudentID,FullName,ContactNo,Qualification from TblStudentMaster";
        state = conn.createStatement();

       

        // Execute the query
         resultset = state.executeQuery(sql);

     while(resultset.next())
     {
            int id=resultset.getInt("StudentID");
            String name=resultset.getString("FullName");
            String mob=resultset.getString("ContactNo");
            String Cname=resultset.getString("Qualification");
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
