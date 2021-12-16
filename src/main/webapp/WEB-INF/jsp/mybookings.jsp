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
        <c:if test = "${sessionScope.myUser.role == 'customer'}">
            <ul class="topnav">
            <li><a href="/EventBiz/welcome.htm">Search for events</a></li>
            <li><a href="/EventBiz/mybookings.htm">My bookings</a></li>
            <li class="right"><a href="/EventBiz/index.htm">Logout</a></li>
            </ul>
        </c:if>
        <c:if test = "${sessionScope.myUser.role == 'event admin'}">
            <ul class="topnav">
            <li><a href="/EventBiz/welcome.htm">Search for events</a></li>
            <li><a href="/EventBiz/addevent.htm">Add new event</a></li>
            <li><a href="/EventBiz/eventlist.htm">View my events</a></li>
            <li><a href="/EventBiz/eventbookings.htm">View event bookings</a></li>
            <li class="right"><a href="/EventBiz/index.htm">Logout</a></li>
            </ul>
        </c:if>
        <c:if test="${sessionScope.myUser.role == 'customer'}">
        <c:if test="${bookings.isEmpty()}">
            <br>
<span class="recent">NO RECENT BOOKINGS</span>
        </c:if>
        <c:if test="${!bookings.isEmpty()}">
<span class="recent">MY RECENT BOOKINGS</span>
        <c:set var="ev" value="${events}"/>        
        <table>
            <tr>
                <td>
                    Booking Date
                </td>
                <td>
                    Event Name
                </td>
                <td>
                    Event Date
                </td>
                <td>
                    Address
                </td>
                <td>
                    Number of Tickets
                </td>
                <td>
                    Total Payment
                </td>
            </tr>
        <c:forEach var="bk" items="${bookings}" varStatus="loop">
        <tr>
            <c:set var = "index" value = "${loop.index}"/>
            <td><c:out value="${bk.date}"/></td>
            <td><c:out value="${ev[index].eventname}"/></td>
            <td><c:out value="${ev[index].eventdate}"/></td>
            <td><c:out value="${ev[index].street}"/> <c:out value="${ev[index].city}"/>, <c:out value="${ev[index].state}"/> <c:out value="${ev[index].zipcode}"/></td>
            <td><c:out value="${bk.tickets}"/></td>
            <td>$ <c:out value="${bk.amount}"/></td>
            
        </tr>
        </c:forEach>
        </table>
        </c:if>
        </c:if>
        <c:if test="${sessionScope.myUser.role == 'event admin'}">
        <c:if test="${list.isEmpty()}">
        <br>
<span class="recent">NO RECENT BOOKINGS</span>
        </c:if>
<br>
<span class="recent">MY RECENT BOOKINGS</span>
        <c:if test="${!list.isEmpty()}">
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
            <c:forEach var="book" items="${bookings}">
                <tr>
                    <td>${book.firstname}</td>
                    <td>${book.lastname}</td>
                    <td>${book.email}</td>
                    <td><a href="/EventBiz/eventdetails.htm?id=<c:out value='${book.eventid}' />">${book.eventid}</a></td>
                    <td>${book.amount}</td>
                    <td>${book.tickets}</td>
                    <td>${book.date}</td>
                    <td>
                        <a class="delete-booking" href="/EventBiz/delete-booking.htm?id=<c:out value='${book.bookingid}'/>">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
        </c:if>
        </c:if>
    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $('.delete-booking').click(function () {
            return confirm("Are you sure you want to delete this user?");
        });
    </script>
</html>
