<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%=request.getContextPath()%>/resources/css/main.css" rel="stylesheet">
        <title>EventBiz</title>
    </head>

    <body>
        <h1 id="index">Welcome to EventBiz</h1>
        <div class="index">
            Find your next event!
            <br>
            <br>
            Create an event to share with others!
            <br>
            <br>
            It all starts here!
            <br>
            <br>
            <br>
            <a class="start" href="<spring:url value='/login.htm' />">Login</a>
            <a class="start" href="<spring:url value='/register.htm' />">Register</a>
        </div>
    </body>
</html>
