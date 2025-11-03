<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Attendance</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">

    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
        }
        .container2 {
            margin-top: 50px;
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            font-weight: 700;
            color: #222f3d;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-label {
            font-weight: 500;
        }
        .table {
            margin-top: 20px;
        }
        .table thead {
            background-color: #222f3d;
            color: white;
        }
        .table tbody tr:hover {
            background-color: #f1f1f1;
        }
        .toggle-container {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .toggle {
            position: relative;
            width: 50px;
            height: 25px;
            background: #ddd;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .toggle:before {
            content: '';
            position: absolute;
            top: 2px;
            left: 2px;
            width: 21px;
            height: 21px;
            background: white;
            border-radius: 50%;
            transition: all 0.3s ease;
        }
        .toggle.active {
            background: #4caf50;
        }
        .toggle.active:before {
            transform: translateX(25px);
        }
        .btn-submit {
            background-color: #222f3d;
            color: white;
            font-size: 16px;
            font-weight: bold;
            padding: 10px;
            border: none;
            border-radius: 5px;
            width: 100%;
        }
        .btn-submit:hover {
            background-color: #1a1f27;
        }
       
    </style>
</head>
<body>
    <!-- Include Header -->
    <%@include file="Header.jsp" %>

    <div class="container2">
        <h2>Mark Attendance</h2>
        <form action="MarkAttendanceServlet" method="post">
            <!-- Subject Dropdown -->
            <div class="mb-4">
                <label for="subject" class="form-label">Select Subject:</label>
                <select class="form-select" name="subject_id" id="subject">
                    <%
                        // Fetch subjects from the database
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/attendance_db", "root", "Amul@2004");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM Subjects");
                        while (rs.next()) {
                    %>
                    <option value="<%= rs.getInt("subject_id") %>">
                        <%= rs.getString("subject_name") %>
                    </option>
                    <%
                        }
                        con.close();
                    %>
                </select>
            </div>

            <!-- Students Attendance Table -->
            <div class="table-responsive">
                <table class="table table-bordered text-center">
                    <thead>
                        <tr>
                            <th>Student Name</th>
                            <th>Mark Attendance</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Fetch students from the database
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/attendance_db", "root", "Amul@2004");
                            stmt = con.createStatement();
                            rs = stmt.executeQuery("SELECT * FROM Students");
                            while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("student_name") %></td>
                            <td>
                                <div class="toggle-container">
                                    <input type="hidden" name="status_<%= rs.getInt("student_id") %>" value="Absent">
                                    <div class="toggle" onclick="toggleAttendance(this, 'status_<%= rs.getInt("student_id") %>')"></div>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                            con.close();
                        %>
                    </tbody>
                </table>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-submit">Submit Attendance</button>
        </form>
    </div>

    
    <!-- Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

    <!-- Custom JavaScript -->
    <script>
        function toggleAttendance(toggleElement, inputName) {
            // Toggle the active class for the switch
            toggleElement.classList.toggle('active');

            // Change the hidden input value based on toggle state
            const inputElement = document.getElementsByName(inputName)[0];
            inputElement.value = toggleElement.classList.contains('active') ? 'Present' : 'Absent';
        }
    </script>
    <%@include file="FooterPage.jsp" %>
</body>
</html>
