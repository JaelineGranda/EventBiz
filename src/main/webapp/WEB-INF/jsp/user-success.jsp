<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%=request.getContextPath()%>/resources/css/main.css" rel="stylesheet">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Welcome to EventBiz ${sessionScope.myUser.firstname}!</h1>
        <c:if test="${sessionScope.myUser.role == 'admin'}">
            <ul class="topnav">
                <li><a href="/EventBiz/allusers.htm">All Users</a></li>
                <li><a href="/EventBiz/adduser.htm">Add User</a></li>
                <li><a href="/EventBiz/allevents.htm">All Events</a></li>
                <li><a href="/EventBiz/addevent.htm">Add Event</a></li>
                <li><a href="/EventBiz/allbookings.htm">All bookings</a></li>
                <li class="right"><a href="/EventBiz/index.htm">Logout</a></li>
            </ul>
        </c:if>
        <div class="form">
        <span class="recent">USER UPDATED SUCCESSFULLY</span>
        <br>
        <a href="/EventBiz/allusers.htm">Go back to user list</a>
        </div>
    </body>
</html>
