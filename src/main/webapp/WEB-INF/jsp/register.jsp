<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%=request.getContextPath()%>/resources/css/main.css" rel="stylesheet">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Welcome to EventBiz</h1>
        <div class="form">
            <span class="user">REGISTER</span>
        <form:form modelAttribute ="user">
            <form:errors path="*" />
            <br>
            <br>
            Username: <form:input path="username" /> 
            <br>
            <br>
            First Name: <form:input path="firstname" />
            <br>
            <br>
            Last Name: <form:input path="lastname" />
            <br>
            <br>
            Email: <form:input path="email" />
            <br>
            <br>
            Set password: <form:password path="password" />
            <br>
            <br>
            User type: <form:select path="role">
            <form:option value="" label="--select--"/>
            <form:option value="customer" label="customer"/>  
            <form:option value="event admin" label="event admin"/> 
            </form:select> 
            <br>
            <br>
            <input class="start" type="submit" value="Register"/>
        </form:form>
            <br>
            <br>
            Already have an account?
        <a href="/EventBiz/login.htm">Login</a>
        <div>
    </body>
</html>
