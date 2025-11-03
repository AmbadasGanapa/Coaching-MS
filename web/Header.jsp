
<%@page import="java.text.Format"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ClassMates</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
        integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            *{
                padding:0px;
                margin:0px;
                
                box-sizing: border-box;
                font-family: Georgia, 'Times New Roman', Times, serif;
            }
            a:link{
                color:white;
            }
            a{
                color:white;
                text-decoration: none;
            }
       
            a:active{
                color:orange;
            }
           .panel{
                height:80px;
                background-color:#222f3d;
                color:white;
                display: flex;
                font-size: 28px;
                align-items: center;
                justify-content:space-evenly;  
                }
        .panel-ops p{
                display: inline;
                 font-size: 28px;
                margin-left: 20px;
              }
        .ManageList{
                  border:0px;
                   font-size: 28px;
                   background-color: transparent;
                   color:white;
              }
/*              .ManageList:after{
                  background-color: activecaption;
                  cursor: pointer;
              }*/
              .ManageList:focus{
                  background-color: #222f3d;;
                  cursor: pointer;
              }
/*         .ManageList:hover{
                  background-color: activecaption;
                  cursor: pointer;
              }*/
        .panel-ops{
                width:70%;
                font-size: 0.9rem;
        }
        .panel-deals{
                 /*// font-size: 1rem;*/
                   font-size: 28px;
                  font-weight:700;
}
.btnLogout{
    font-size: 28px;
    border: 2px solid whitesmoke;
    padding:0.6rem;
    border-radius: 5px;
    background-color: transparent;
    color:white;
}
.btnLogout:hover{
    border:2px solid white;
    box-shadow: 2px 0px 2px 0px white;
    background-color:orange;
    cursor: pointer;
    
}
.datetime{
    font-size: 22px;
    display: flex;
    justify-content: space-between;
    margin:5px 10px 5px 10px;
    align-items: center;
}
        </style>
    </head>
    <body>
       
        <header>
            <div class="datetime ">
               
                <div><%
                   
                    Date da=new Date();
                    Calendar cal=Calendar.getInstance();
                    SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-YYYY");
                   // SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy hh:mm a");


                    Format f=new SimpleDateFormat("EEEE");
                    
                    String s=f.format(new Date());

                  out.println("Date : " +sdf.format(cal.getTime())+"&emsp; Day : " + s + " &emsp;&emsp; Time : "+da.getHours() + " : " + da.getMinutes() );
                 
                
                %>
                </div>
                <div>
                    <%
                        
//            String username=(String)session.getAttribute("user");
//            String password=(String)session.getAttribute("pass");
            HttpSession se=request.getSession();
            String username=(String)se.getAttribute("user");
            String password=(String)se.getAttribute("pass");
            out.println("Welcome "+username+" ..!");
            %>
                   
                </div>
            </div>
            <div class="panel">
            <div class="panel-all">
               
                <a href="DashBoard.jsp"> Logo</a>
            </div>
            <div class="panel-ops">
                <p><select class="ManageList" id="ManageList"onchange="navigateToPage()">
                        <option>Masters</option>
                        <option value="StudentMaster.jsp">Student</option>
                        <option value="FacultyMaster.jsp"> Faculty</option>
                         <option value="Courses.jsp">Courses</option>
                        <option value="Batches.jsp">Batches</option>
                    </select></p>

            <p><select class="ManageList" id="ManageList2"onchange="navigateToPage2()">
                    <option value="DashBoard.jsp">Manage</option>
                        <option value="StudentAdmission.jsp">Assign</option>
                        <option value="Fees.jsp"> Fees</option>
                    </select></p>
            <p><select class="ManageList" id="ManageList3"onchange="navigateToPage3()">
                    <option value="DashBoard.jsp">Attendance</option>
                        <option value="mark_attendance.jsp">Mark </option>
                        <option value="view_attendance.jsp"> View </option>
                    </select></p>
              
                <p>Certificate</p>
                 
                <p>
                    <select class="ManageList" id="Settings"onchange="navigateToPage5()">
                        <option value="DashBoard.jsp">Settings</option>
                        <option value="BackupPage.jsp"> Backup</option>
                        <option  value="Fees.jsp"> Restore</option>
                    </select>
                </p>
            <a href="AboutUs.jsp"><p>About Us</p></a>
            </div>

            <div class="panel-deals">
                   <p><select class="ManageList" id="ManageList4"onchange="navigateToPage4()" >
                    <option value="DashBoard.jsp"><%=username%></option>
                    <option value="StudentMaster.jsp">Settings</option>
                    <option value="LogoutPage.jsp"> Logout</option>
                    </select></p>
                <!--<a href="LogoutPage.jsp"> <button class="btnLogout" >Logout</button></a>-->
            </div>
        </div>
        </header>


<script>
    
    function navigateToPage() {
    // Get the selected value from the dropdown
    const select = document.getElementById("ManageList");
    const selectedPage = select.value;
    
    // Redirect to the selected page if a page is selected
    if (selectedPage) {
        window.location.href = selectedPage;
    }
    };
function navigateToPage2() {
    // Get the selected value from the dropdown
    const select = document.getElementById("ManageList2");
    const selectedPage = select.value;
    
    // Redirect to the selected page if a page is selected
    if (selectedPage) {
        window.location.href = selectedPage;
    }
};

function navigateToPage3(){
    const select =document.getElementById("ManageList3");
    const selectedPage=select.value;
    
        if (selectedPage) {
        window.location.href = selectedPage;
    }
};

function navigateToPage4(){
    const select =document.getElementById("ManageList4");
    const selectedPage=select.value;
    
        if (selectedPage) {
        window.location.href = selectedPage;
    }
};

function navigateToPage5(){
    const select=document.getElementById("Settings");
    const selectedPage=select.value;
    
    if(selectedPage)
    {
        window.location.href=selectedPage;
    }
}
</script>


    </body>
</html>
