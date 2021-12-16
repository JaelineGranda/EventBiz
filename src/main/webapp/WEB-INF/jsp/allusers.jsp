<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
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
        <span class="recent">ALL USERS</span>
        <br>
        <c:set var="list" value="${users}"/>
        <c:if test="${list!=null}">
            <table>
                <tr>
                <td>Username</td>
                <td>First name</td>
                <td>Last name</td>
                <td>Email</td>
                <td>Password</td>
                <td>Role</td>
                </tr>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>
                            ${user.username}
                        </td>
                        <td>
                            ${user.firstname}
                        </td>
                        <td>
                            ${user.lastname}
                        </td>
                        <td>
                            ${user.email}
                        </td>
                        <td>
                            ${user.password}
                        </td>
                        <td>
                            ${user.role}
                        </td>
                        <td>
                            <a href="/EventBiz/edituser.htm?id=<c:out value='${user.userid}' />">Edit</a>
                            <a class="delete-user" href="/EventBiz/delete-user.htm?id=<c:out value='${user.userid}'/>">Deactivate</a>
                        </td>
                    </tr>    
                </c:forEach>
            </table>
        </c:if>                
        <c:if test="${list.isEmpty()}">
            <div>No users joined EventBiz yet</div>
        </c:if>
    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $('.delete-user').click(function () {
            return confirm("Are you sure you want to delete this user?");
        });
    </script>
</html>
