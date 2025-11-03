
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fees Management</title>
    <!--<link rel="stylesheet" href="feesStyles.css">-->
    <style>
        body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f9;
    margin: 0;
    padding: 0;
}

h2 {
    text-align: center;
    color: #333;
}

.container {
    display: flex;
    justify-content: space-between;
    margin: 20px;
}

.form-container {
    width: 49%;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.table-container {
    width: 49%;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

table th, table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

table th {
    background-color: #222f3d;
    color: white;
}

form label {
    display: block;
    margin: 8px 0;
}

form input {
    width: 95%;
    padding: 10px;
    margin: 0px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

form button {
    padding: 10px 20px;
    background-color: #222f3d;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

form button:hover {
    background-color: #1d2c3d;
}

    </style>
</head>
<body>
    <%@include  file="Header.jsp" %>
    <br> <h2>Fees Management</h2>
    <div class="container">
        <!-- Fee Form -->
        <div class="form-container">
            <h3>Add Fee Payment</h3>
            <form action="feesManagement.jsp" method="POST">
                <label for="StudentID">Student ID:</label>
                <input type="text" id="StudentID" name="StudentID" value="<%= request.getParameter("StudentID") != null ? request.getParameter("StudentID") : "" %>" required><br><br>
                
                <!--java Code Starts here--> 
                 <%
            // Initialize variables
            String id = request.getParameter("StudentID");
            
            String Name = "";
            String Email = "";
            String Batch= "";
            String CourseName= "";
           // String CourseFees= "";
            String TotalFees="";
            String AmountPaid= "";
            String RemainingFees="";

            if (id != null && !id.isEmpty()) {
                // Database connection
                String url = "jdbc:mysql://localhost:3307/mydb";              
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, username, password);

                    // Query to fetch data based on ID
                    String sql = "SELECT Name,Email,Batch,CourseName,TotalFees,AmountPaid,RemainingFees FROM yourTable WHERE id = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, id);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        
                        Name = rs.getString("name");
                        Email = rs.getString("email");
                  
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
                <!--Java Code end here-->
                <label for="studentName">Student Name:</label>
                <input type="text" id="studentName" name="studentName" required><br><br>

                <label for="studentEmail">Student Email:</label>
                <input type="text" id="studentEmail" name="studentEmail" required><br><br>

                <label for="batch">Batch:</label>
                <input type="text" id="batch" name="batch" required><br><br>

                 <label for="studentName">Course Name:</label>
                <input type="text" id="studentName" name="studentName" required><br><br>

                <label for="totalFee">Total Fee:</label>
                <input type="number" id="totalFee" name="totalFee" required><br><br>

                <label for="amountPaid">Amount Paid:</label>
                <input type="number" id="amountPaid" name="amountPaid" required><br><br>

                <label for="amountPaid">Remaining Fees:</label>
                <input type="number" id="amountPaid" name="amountPaid" required><br><br>

                <button type="submit" name="submitFee">Submit Payment</button>
            </form>
        </div>

        <!-- Fee Records Table -->
        <div class="table-container">
            <h3>Fee Records</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Student Name</th>
                        <th>Batch</th>
                        <th>Total Fee</th>
                        <th>Amount Paid</th>
                        <th>Balance</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Example of populating the table with data (this would be dynamically done using a servlet or back-end logic)
                        // Simulating records with hardcoded data for display purpose

                        String[] studentNames = {"John Doe", "Jane Smith", "Mark Twain"};
                        String[] batches = {"Batch A", "Batch B", "Batch C"};
                        double[] totalFees = {5000, 6000, 4500};
                        double[] amountPaid = {2000, 3000, 1000};

                        for (int i = 0; i < studentNames.length; i++) {
                            double balance = totalFees[i] - amountPaid[i];
                    %>
                    <tr>
                        <td><%= i + 1 %></td>
                        <td><%= studentNames[i] %></td>
                        <td><%= batches[i] %></td>
                        <td><%= totalFees[i] %></td>
                        <td><%= amountPaid[i] %></td>
                        <td><%= balance %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
