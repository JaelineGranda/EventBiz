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
            <ul class="topnav">
                <li><a href="/EventBiz/allusers.htm">All Users</a></li>
                <li><a href="/EventBiz/adduser.htm">Add User</a></li>
                <li><a href="/EventBiz/allevents.htm">All Events</a></li>
                <li><a href="/EventBiz/addevent.htm">Add Event</a></li>
                <li><a href="/EventBiz/allbookings.htm">All bookings</a></li>
                <li class="right"><a href="/EventBiz/index.htm">Logout</a></li>
            </ul>
            <br>
        <span class="recent">ALL BOOKINGS</span>
        <br>
        <table>
            <tr>
                <td>Customer first name:</td>
                <td>Customer last name:</td>
                <td>Email</td>
                <td>Event Id</td>
                <td>Amount</td>
                <td>Tickets</td>
                <td>Booking Date</td>
            </tr>
            <c:forEach var="bk" items="${bookings}">
                <tr>
                    <td>${bk.firstname}</td>
                    <td>${bk.lastname}</td>
                    <td>${bk.email}</td>
                    <td><a href="/EventBiz/eventdetails.htm?id=<c:out value='${bk.eventid}' />">${bk.eventid}</a></td>
                    <td>${bk.amount}</td>
                    <td>${bk.tickets}</td>
                    <td>${bk.date}</td>
                    <td>
                        <a class="delete-booking" href="/EventBiz/delete-booking.htm?id=<c:out value='${bk.bookingid}'/>">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $('.delete-booking').click(function () {
            return confirm("Are you sure you want to delete this booking?");
        });
    </script>
</html>
