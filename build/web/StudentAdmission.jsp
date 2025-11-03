<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@include file="Header.jsp"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Admission Form</title>
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
    function fetchCourseDetails() {
 const courseId = document.getElementById("CourseId").value;
    if (courseId) {
        
        const xhr = new XMLHttpRequest(); // Corrected variable name
        xhr.open("GET", `getDetails?CourseId=${courseId}`, true); // Make sure the URL matches your servlet mapping
        xhr.onload = function () {
           
            if (xhr.status === 200) {
                console.log("Response received:", xhr.responseText); // Log the response
                try {
                    const response = JSON.parse(xhr.responseText);
                     alert(response.CourseName);
                    document.getElementById("CourseName").value = response.CourseName || "Not Found";
                } catch (e) {
                    console.error("Error parsing JSON:", e.message);
                    document.getElementById("CourseName").value = "Error parsing response";
                }
            } else {
                console.error("Failed to fetch details. HTTP Status:", xhr.status);
                document.getElementById("CourseName").value = xhr.status+"Error fetching details";
            }
        };
        xhr.onerror = function () {
            console.error("AJAX request failed.");
            document.getElementById("CourseName").value = "Error fetching details";
        };
        xhr.send();
    }
    }
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
    PreparedStatement prstate=null;
   
 conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
 state=conn.createStatement();
     String ids= "SELECT MAX(id) AS MaxId FROM TblAdmission;";
      resultset = state.executeQuery(ids);
        while(resultset.next())
        {
           myid=resultset.getInt("MaxId")+1;
        }
     Date currentDate = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String formattedDate = formatter.format(currentDate);


    List<String>StudentIDs=new ArrayList<>();
    List<String>StudentName=new ArrayList<>();

    String query1="select StudentID,FullName from TblStudentMaster";
    resultset=state.executeQuery(query1);
    while(resultset.next())
    {
      StudentIDs.add(resultset.getString("StudentID"));
      StudentName.add(resultset.getString("FullName"));
    }
//


// Retrieving Course Names,Id here
 List<String> CourseName = new ArrayList<>();
 List<String> CourseId = new ArrayList<>();
String Query2="select CourseId,CourseName from TblBatches";

resultset=state.executeQuery(Query2);
while(resultset.next())
{
  CourseName.add(resultset.getString("CourseName"));
  CourseId.add(resultset.getString("CourseId"));
}


// Retrieving Faculty Names,Id here
 List<String> FacultyId = new ArrayList<>();
 List<String> FacultyName = new ArrayList<>();
String Query3="select FacultyId,FacultyName from TblBatches";
resultset=state.executeQuery(Query3);
while(resultset.next())
{
  FacultyId.add(resultset.getString("FacultyId"));
  FacultyName.add(resultset.getString("FacultyName"));
}


// Retrieving Batch Names,Id here
 List<String> BatchId = new ArrayList<>();
 List<String> BatchName = new ArrayList<>();
String Query4="select BatchId,BatchName from TblBatches";
resultset=state.executeQuery(Query4);
while(resultset.next())
{
  BatchId.add(resultset.getString("BatchId"));
  BatchName.add(resultset.getString("BatchName"));
}
%>




    <br>
    <h1>Student Admission Form</h1>
    <div class="container">
        <!-- Form Section -->
        <div class="form-container">
            <form  method="post" action="StudentAdmissionProcessor.jsp" id="MyForm">
                <label for="studentIdsd">Admission No.:</label>
                <input type="text" id="admissionId" name="admissionId" value="<%=myid%>"  readonly="true" required > 

                <label for="saveDated">Save Date:</label>
                <input type="date" id="saveDate" name="saveDate" value="<%=formattedDate%>" required>

                <label for="course">Student ID:</label>
                <select id="studentid" name="StudentID" class="combo" required>
                <option value="None">Select Student ID</option>                   
                    <%
           
            for (String item : StudentIDs) {
                     %>
            <option value="<%= item %>"><%= item %></option>
                     <%
                                        }
                     %>
                </select>
                
                <label for="name">Student Name:</label>
                <select id="studentName" name="studentName" class="combo" required>
                <option value="None">Select Student Name</option>                   
                    <%
           
            for (String item : StudentName) {
                     %>
            <option value="<%= item %>"><%= item %></option>
                     <%
                                        }
                     %>
                </select>

                
                <label for="course">Course ID:</label>
                
<select id="CourseId" name="CourseId" class="combo" onchange="fetchCourseDetails()"  required>
    <option value="None">Select Course ID</option>
    <% for (String item : CourseId) { %>
        <option value="<%= item %>" ><%= item %></option>
    <% } %>
</select>
                 
                
                     <label for="course">Course Name</label>
                     <input type="text" id="CourseName" name="CourseName">

              
                <!--<input type="text" name="genderoptions">-->
                
                <label for="nationalitysd">Faculty Id </label>
                      <select id="facultyId" name="FacultyId" class="combo" required>
                <option value="None">Select Faculty Id</option>                   
                    <%
            for (String item : FacultyId) {
                     %>
            <option value="<%= item %>"><%= item %></option>
                     <%
                                        }
                     %>
                </select>
                <label for="nationalitysd">Faculty Name: </label>
                      <select id="facultyName" name="FacultyName" class="combo" required>
                <option value="None">Select Faculty Name</option>                   
                    <%
            for (String item : FacultyName) {
                     %>
            <option value="<%= item %>"><%= item %></option>
                     <%
                                        }
                     %>
                </select>
                
                <label for="parentNames">Batch ID:</label>
                          <select id="facultyName" name="BatchId" class="combo" required>
                <option value="None">Select Batch Id</option>                   
                    <%
            for (String item : BatchId) {
                     %>
            <option value="<%= item %>"><%= item %></option>
                     <%
                                        }
                     %>
                </select>
                
                <label for="parentContactNosd">Batch Name:</label>
                           <select id="facultyName" name="BatchName" class="combo" required>
                <option value="None">Select Batch Name</option>                   
                    <%
            for (String item : BatchName) {
                     %>
            <option value="<%= item %>"><%= item %></option>
                     <%
                                        }
                     %>
                </select>
                <input type="submit" value="Submit Admission">
            </form>
        </div>

        <!-- Data Display Table Section -->
        <div class="table-container">
            <h2>Student Admissions Data</h2>
            
            <table>
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>StudentID</th>
                        <th>CourseID</th>
                        <th>FacultyId</th>
                       <th>BatchId</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Sample Data. Replace this with dynamic content --%>
   <%
          
 String AllQuery="select id, StudentId, CourseId, FacultyId, BatchId from TblAdmission where id=?";
prstate=conn.prepareStatement(AllQuery);
prstate.setString(1, request.getParameter("admissionId"));

resultset=prstate.executeQuery();
out.println(resultset.getRow());
while(resultset.next())
{
//response.sendRedirect("google.com");
}


    try {
    
       
        String sql = "select id, StudentId, CourseId, FacultyId, BatchId from TblAdmission";
        state = conn.createStatement();

       

        // Execute the query
         resultset = state.executeQuery(sql);

     while(resultset.next())
     {
            int id=resultset.getInt("id");
            String studentid=resultset.getString("StudentId");
            String courseid=resultset.getString("CourseId");
            String facultyid=resultset.getString("FacultyId");
            String batchid=resultset.getString("BatchId");
//                    
%>
<tr>
    <td><%=id%></td>
    <td><%=studentid%></td>
    <td><%=courseid%></td>
    <td><%=facultyid%></td>
    <td><%=batchid%></td>
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
                <input type="submit" class="btncrud" id="btnUpdate" value="Update" onclick="updateRecord()" >   <input type="submit"id="btnDelete" class="btncrud" value="Delete" onclick="deleteRecord()"> <input type="submit"id="btnClear" class="btncrud" value="Clear"onclick="clearFields()">
        </div>
    </div>
                
      <script>
        function clearFields() {
            let form = document.getElementById("MyForm");
            form.reset();
        }
    </script>
     <script>
        // Function to handle Update operation
        function updateRecord() {
            // Get the form element
            let form = document.getElementById("operationForm");

            // Perform validation (optional)
            if (confirm("Are you sure you want to update this record?")) {
                // Set the action to Update
                form.action = "updateServlet"; // Replace with your update servlet URL
                form.method = "post";

                // Submit the form
                form.submit();
            }
        }

        // Function to handle Delete operation
        function deleteRecord() {
            // Get the form element
            let form = document.getElementById("operationForm");

            // Perform validation (optional)
            if (confirm("Are you sure you want to delete this record?")) {
                // Set the action to Delete
                form.action = "deleteServlet"; // Replace with your delete servlet URL
                form.method = "post";

                // Submit the form
                form.submit();
            }
        }
    </script>
</body>
</html>
