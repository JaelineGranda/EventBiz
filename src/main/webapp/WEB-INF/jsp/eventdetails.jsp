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
        <c:if test = "${sessionScope.myUser.role == 'event admin'}">
            <ul class="topnav">
            <li><a href="/EventBiz/welcome.htm">Search for events</a></li>
            <li><a href="/EventBiz/addevent.htm">Add new event</a></li>
            <li><a href="/EventBiz/eventlist.htm">View my events</a></li>
            <li><a href="/EventBiz/eventbookings.htm">View event bookings</a></li>
            <li class="right"><a href="/EventBiz/index.htm">Logout</a></li>
            </ul>
        </c:if>
        <c:if test = "${sessionScope.myUser.role == 'customer'}">
            <ul class="topnav">
            <li><a href="/EventBiz/welcome.htm">Search for events</a></li>
            <li><a href="/EventBiz/mybookings.htm">My bookings</a></li>
            <li class="right"><a href="/EventBiz/index.htm">Logout</a></li>
            </ul>
        </c:if>
            <br>
        <span class="recent">EVENT SUMMARY</span>
        <div class="grid-container">
        <div class="grid-item" id="confirm">
        <img src="<%=request.getContextPath()%>/resources/images/${event.imagefile}.jpg" width="10%">
        <br>
        <br>
        ${event.eventname}
        <br>
        Date: ${event.eventdate}
        <br>
        Type: ${event.type}
        <br>
        Region: ${event.region}
        <br>
        Address: ${event.street} ${event.city}, ${event.state} ${event.zipcode}
        <br>
        <c:if test="${sessionScope.myUser.role == 'admin'}">
        Creator id: ${event.creatorid}
        </c:if>
        <br>
        <br>
        <c:if test="${sessionScope.myUser.role == 'admin'}">
        <a href="/EventBiz/allbookings.htm">Go back to all bookings</a>
        <br>
        </c:if>
        <c:if test="${sessionScope.myUser.role == 'event admin'}">
        <a href="/EventBiz/eventbookings.htm">Go back to bookings</a>
        <br>
        </c:if>
        <c:if test="${sessionScope.myUser.role == 'customer'}">
        <a href="/EventBiz/mybookings.htm">Go back to my bookings</a>
        <br>
        <br>
        </c:if>
        </div>
        </div>
    </body>
</html>
