<%@ page import="java.sql.*" %>
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
            background-color: #f4f4f4;
            color: #343a40;
        }

        .container {
            margin-top: 50px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #222f3d;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-select,
        .btn {
            font-size: 16px;
            padding: 10px;
        }

        .btn {
            background-color: #222f3d;
            color: white;
            font-weight: bold;
            width: 100%;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #1a1f27;
        }

        table {
            margin-top: 30px;
            width: 100%;
            border-collapse: collapse;
        }

        table th,
        table td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #222f3d;
            color: white;
        }

        table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .alert {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>

<%@ include file="Header.jsp" %>

<body>

    <div class="container">
        <h1>View Attendance</h1>

        <!-- Subject Dropdown Form -->
        <form action="ViewAttendanceServlet" method="get">
            <div class="form-group">
                <label for="subject" class="form-label">Select Subject:</label>
                <select class="form-select" name="subject_id" id="subject" required>
                    <option value="" disabled selected>-- Select Subject --</option>
                    <% 
                        Connection con = null;
                        try {
                            // Database connection
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/attendance_db", "root", "Amul@2004");

                            // Query to fetch subjects
                            String query = "SELECT * FROM Subjects";
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery(query);

                            // Populate dropdown with subjects
                            while (rs.next()) {
                                int subjectId = rs.getInt("subject_id");
                                String subjectName = rs.getString("subject_name");
                    %>
                    <option value="<%= subjectId %>"><%= subjectName %></option>
                    <% 
                            }
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn">View Attendance</button>
        </form>

        <!-- Attendance Table Display -->
        <%
            String subjectIdParam = request.getParameter("subject_id");
            if (subjectIdParam != null && !subjectIdParam.isEmpty()) {
                int subjectId = Integer.parseInt(subjectIdParam);

                Connection conReport = null;
                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conReport = DriverManager.getConnection("jdbc:mysql://localhost:3307/attendance_db", "root", "Amul@2004");

                    // Query to fetch attendance data
                    String query = "SELECT s.student_name, a.date, a.status FROM Attendance a " +
                                   "JOIN Students s ON a.student_id = s.student_id " +
                                   "WHERE a.subject_id = ? ORDER BY a.date ASC";

                    PreparedStatement ps = conReport.prepareStatement(query);
                    ps.setInt(1, subjectId);
                    ResultSet rsReport = ps.executeQuery();

                    if (rsReport.next()) {
        %>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Student Name</th>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    do {
                %>
                <tr>
                    <td><%= rsReport.getString("student_name") %></td>
                    <td><%= rsReport.getDate("date") %></td>
                    <td><%= rsReport.getString("status") %></td>
                </tr>
                <%
                    } while (rsReport.next());
                %>
            </tbody>
        </table>
        <% 
                    } else {
        %>
        <div class="alert alert-warning">
            No attendance records found for the selected subject.
        </div>
        <% 
                    }
                    conReport.close();
                } catch (Exception e) {
                    out.println("<h3>Error: " + e.getMessage() + "</h3>");
                }
            }
        %>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>

</html>
