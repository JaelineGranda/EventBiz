<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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

        <span class="recent">ADD NEW USER</span>
        <div class="form">
        <form:form action="/EventBiz/adduser.htm" modelAttribute ="user">
            <form:errors path="*"/>
            <br>
            <br>
            First Name <form:input path="firstname"/>
            <br>
            <br>
            Last Name <form:input path="lastname"/>
            <br>
            <br>
            Username <form:input path="username" /> 
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
            Email: <form:input path="email"/>
            <br>
            <br>
            Password: <form:input path="password"/>
            <br>
            <br>
            <input class="start" type="submit" value="Add User"/>
        </form:form>
        </div>
    </body>
</html>
