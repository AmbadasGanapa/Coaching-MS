<%@ page import="java.io.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database Backup</title>
</head>
<body>
    <h1>Database Backup</h1>
    <form method="post">
        <button type="submit">Create Backup</button>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Database credentials
            String dbName = "mydb";
            String dbUser = "root";
            String dbPassword = "Amul@2004";

            // Path where the backup file will be stored on the D drive
            String backupPath = "D:/database_backups/";

            // Generate a timestamp for the backup file name
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
            String timestamp = sdf.format(new Date());
            String backupFileName = dbName + "_backup_" + timestamp + ".sql";

            String mysqldump="C:/Program Files/MySQL/MySQL Server 8.0/bin/mysqldump.exe";
            // Command to create the backup
            String command = "\"" + mysqldump + "\" -u " + dbUser + " -p" + dbPassword + " " + dbName + " -r " + backupPath + backupFileName;

            try {
                // Run the command
                Process process = Runtime.getRuntime().exec(command);
                int processComplete = process.waitFor();

                if (processComplete == 0) {
                    out.println("<p>Database backup created successfully at: " + backupPath + backupFileName + "</p>");
                } else {
                    out.println("<p>Could not create the database backup.</p>");
                }
            } catch (Exception e) {
             out.println(e.toString());
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
