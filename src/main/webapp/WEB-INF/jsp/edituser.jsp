<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%=request.getContextPath()%>/resources/css/main.css" rel="stylesheet">
        <title>EventBiz</title>
    </head>
    <body>
        <h1>Welcome to EventBiz ${sessionScope.myUser.firstname}!</h1>
        <ul class="topnav">
            <li><a href="/EventBiz/allusers.htm">All Users</a></li>
            <li><a href="/EventBiz/adduser.htm">Add User</a></li>
            <li><a href="/EventBiz/allevents.htm">All Events</a></li>
            <li><a href="/EventBiz/addevent.htm">Add Event</a></li>
            <li><a href="/EventBiz/allbookings.htm">All bookings</a></li>
            <li class="right"><a href="/EventBiz/index.htm">Logout</a></li>
        </ul>
        <br>
        <span class="recent">EDIT USER</span>
        <div class="form">
            <form:form action="/EventBiz/update-user.htm" modelAttribute="user">
                <form:errors path="*"/>
                <br>
                <br>
                Username: <form:input path="username" value="${user.username}"/>
                <br>
                <br>
                First name: <form:input path="firstname" value="${user.firstname}"/>
                <br>
                <br>
                Last name: <form:input path="lastname" value="${user.lastname}"/>
                <br>
                <br>
                Email: <form:input path="email" value="${user.email}"/>
                <br>
                <br>
                Role: <form:select path="role">  
                    <form:option value="" label="--select--"/>
                    <form:option value="admin" label="admin"/>
                    <form:option value="event admin" label="event admin"/>   
                    <form:option value="customer" label="customer"/>   
                </form:select>
                <br>
                <br>
                Password: <form:input path="password" value="${user.password}"/>
                <form:hidden path="userid" value="${user.userid}"/>
                <br>
                <br>
                <input class="start" type="submit" value="Update"/>
            </form:form>
                <a href="/EventBiz/allusers.htm">Cancel</a>
        </div>
    </body>
</html>
