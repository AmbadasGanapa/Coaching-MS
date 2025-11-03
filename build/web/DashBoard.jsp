<%-- 
    Document   : DashBoard
    Created on : Oct 31, 2024, 1:13:59 PM
    Author     : Admin
--%>


<%@include file="Header.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DashBoard</title>
        <!-- Hero Section CSS -->

<!-- Hero Section CSS -->
<style>
  /* Hero Section */
  .hero {
    height: 100vh;
    background-color: #1e2a38;  /*Dark educational-themed background*/ 
    background-image: url("Back.jpg");
    background-size:cover;
    background-repeat: no-repeat;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    color: #ffffff;
    padding: 20px;
    position: relative;
    overflow: hidden;
  }

  /* Gradient Overlay */
  .hero::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(135deg, #222f3d 0%, #1e2a38 100%);
    opacity: 0.95;
    z-index: 1;
  }

  /* Hero Content */
  .hero-content {
    position: relative;
    z-index: 2;
    max-width: 700px;
    animation: fadeIn 2s ease forwards;
  }

  /* Title */
  .hero-title {
    font-size: 3rem;
    margin: 0;
    font-weight: 700;
    color: #f6c453; /* Soft gold for educational emphasis */
    animation: growText 1.5s ease forwards;
    transform: scale(0);
  }

  /* Description Text */
  .hero-description {
    font-size: 1.4rem;
    margin: 20px 0 10px;
    color: #d1d1d1;
    animation: fadeIn 3s ease forwards 0.5s;
    opacity: 0;
  }

  /* Subtext */
  .hero-subtext {
    font-size: 1rem;
    color: #c0c0c0;
    margin-bottom: 20px;
  }

  /* Stats Box */
  .stats-box {
    display: flex;
    justify-content: space-around;
    background-color: #2a3b4d;
    padding: 20px;
    border-radius: 10px;
    margin-top: 20px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
  }

  .stat-item {
    text-align: center;
    color: #e8e8e8;
  }

  .stat-item h3 {
    font-size: 2rem;
    color: #ffd700; /* Gold color for numbers */
    margin: 0;
  }

  .stat-item p {
    font-size: 1rem;
    margin: 5px 0 0;
    color: #c0c0c0;
  }

  /* Call-to-Action Button */
  .hero-button {
    margin-top: 20px;
    background-color: #ff6347; /* Accent color */
    color: #ffffff;
    padding: 12px 24px;
    font-size: 1rem;
    font-weight: bold;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: transform 0.3s ease, background-color 0.3s ease;
  }

  .hero-button:hover {
    background-color: #ff7f50;
    transform: scale(1.1);
  }

  /* Animations */
  @keyframes growText {
    0% {
      transform: scale(0);
    }
    100% {
      transform: scale(1);
    }
  }

  @keyframes fadeIn {
    from {
      opacity: 0;
      transform: translateY(20px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  /* Responsive Design */
  @media (max-width: 768px) {
    .hero-title {
      font-size: 2.4rem;
    }

    .hero-description {
      font-size: 1.1rem;
    }

    .hero-subtext {
      font-size: 0.9rem;
    }

    .stats-box {
      flex-direction: column;
      padding: 15px;
    }

    .stat-item h3 {
      font-size: 1.8rem;
    }

    .hero-button {
      font-size: 0.9rem;
      padding: 10px 20px;
    }
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
    int totalStudents=1;
    int totalFaculty=1;
    int totalCourses=1;
    Connection conn = null;
    Statement state = null;
    boolean success = false;
    ResultSet resultset=null;
    
   
    conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
 
     String ids= "SELECT Count(StudentID) AS MaxRows FROM TblStudentMaster;";
        state = conn.createStatement();
        resultset = state.executeQuery(ids);
        while(resultset.next())
        {
           totalStudents=resultset.getInt("MaxRows");
        }
        resultset.close();
        
         String ids2= "SELECT Count(FacultyID) AS MaxRows FROM TblFacultyMaster";
        state = conn.createStatement();
        resultset = state.executeQuery(ids2);
        while(resultset.next())
        {
           totalFaculty=resultset.getInt("MaxRows");
        }
        
         String ids3= "SELECT Count(CourseID) AS MaxRows FROM tblcourses;";
        state = conn.createStatement();
        resultset = state.executeQuery(ids3);
        while(resultset.next())
        {
           totalCourses=resultset.getInt("MaxRows");
        }
     Date currentDate = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String formattedDate = formatter.format(currentDate);

        %>
<section class="hero">
  <div class="hero-content">
    <h1 class="hero-title">Classmate Software</h1>
    <p class="hero-description">Your Academic Companion for Collaborative Learning</p>
    <p class="hero-subtext">
      Simplifying study management and enhancing collaboration for students. Access resources, organize notes, and track progress—all in one platform.
    </p>
    <div class="stats-box">
      <div class="stat-item">
        <h3 ><%=totalStudents%>+</h3>
        <p>Registered Students</p>
      </div>
      <div class="stat-item">
        <h3><%=totalFaculty%>+</h3>
        <p>Faculty Members</p>
      </div>
      <div class="stat-item">
        <h3><%=totalCourses%>+</h3>
        <p>Courses Available</p>
      </div>
      <div class="stat-item">
        <h3>98%</h3>
        <p>Student Satisfaction</p>
      </div>
    </div>
    <button class="hero-button">Explore Features</button>
  </div>
</section>


       <%@include  file="FooterPage.jsp"%>
           <script>
        // Disable right-click context menu
        document.addEventListener("contextmenu", function(e) {
            e.preventDefault();
           
        });
    </script>

    </body>
</html>
