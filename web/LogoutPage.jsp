<%-- 
    Document   : LogoutPage
    Created on : Oct 31, 2024, 7:03:13 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout Page</title>
    </head>
    <body>

        <%
            String message="Are You Sure to logout..?";
        %>

<% if (!message.isEmpty()) { %>
    <script type="text/javascript">
        alert("<%= message %>");
            <%
//                response.sendRedirect("index.html");
HttpSession se=request.getSession();
se.invalidate();
             %>
                 window.location.href="index.html";
       
    </script>
<% } %>
      </body>
</html>
