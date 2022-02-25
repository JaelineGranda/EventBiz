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
        <h1>Welcome to EventBiz</h1>
        <div class="form">
            <span class="user">LOGIN</span>
            <form:form modelAttribute ="user">
                <br>
                <form:errors path="*"/>
                <br>
                <br>
                Username: <form:input path="username" /> 
                <br>
                <br>
                Password: <form:password path="password" />
                <br>
                <br>
                User type: <form:select path="role">  
                    <form:option value="" label="--select--"/>
                    <form:option value="customer" label="customer"/>  
                    <form:option value="event admin" label="event admin"/>
                    <form:option value="admin" label="admin"/>
                </form:select>  
                <br>
                <br>
                <input type="submit" class="start" value="Login"/>
                <br>
                <br>
                New User?
                <a href="/EventBiz/register.htm">Register</a>
            </form:form>
        </div>
    </body>
</html>
