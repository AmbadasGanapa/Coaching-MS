<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Attendance</title>

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
        .container {
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
        .btn-back {
            background-color: #222f3d;
            color: white;
            font-size: 16px;
            font-weight: bold;
            padding: 10px;
            border: none;
            border-radius: 5px;
            width: 100%;
        }
        .btn-back:hover {
            background-color: #1a1f27;
        }
        footer {
            margin-top: 30px;
            text-align: center;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <%@include file="Header.jsp" %>

    <div class="container">
        <h2>Attendance Report</h2>
        <form action="ViewAttendanceServlet" method="get">
            <!-- Subject Dropdown -->
            <div class="mb-4">
                <label for="subject" class="form-label">Select Subject:</label>
                <select class="form-select" name="subject_id" id="subject" required>
                    <option value="" disabled selected>-- Select Subject --</option>
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

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary w-100">View Attendance</button>
        </form>

        <!-- Attendance Table -->
        <%
            String subjectId = request.getParameter("subject_id");
            if (subjectId != null && !subjectId.isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3307/attendance_db", "root", "Amul@2004");

                    PreparedStatement ps = con.prepareStatement(
                        "SELECT s.student_name, a.date, a.status FROM Attendance a JOIN Students s ON a.student_id = s.student_id WHERE a.subject_id = ?"
                    );
                    ps.setInt(1, Integer.parseInt(subjectId));
                    rs = ps.executeQuery();

                    if (!rs.isBeforeFirst()) {
                        out.println("<p class='text-danger mt-4'>No attendance records found for the selected subject.</p>");
                    } else {
        %>
        <div class="table-responsive mt-4">
            <table class="table table-bordered text-center">
                <thead>
                    <tr>
                        <th>Student Name</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("student_name") %></td>
                        <td><%= rs.getDate("date") %></td>
                        <td>
                            <span class="badge bg-<%= rs.getString("status").equals("Present") ? "success" : "danger" %>">
                                <%= rs.getString("status") %>
                            </span>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <%
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("<p class='text-danger mt-4'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>

    <!-- Footer -->
    <footer>
        Attendance Management System © 2024
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
