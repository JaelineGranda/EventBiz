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
        <br>
        <span class="recent">EDIT EVENT</span>
        <div class="form">
        <form:form action="/EventBiz/update-event.htm" modelAttribute="event">
            <form:errors path="*"/>
            <br>
            <br>
            Event Name <form:input path="eventname" value="${event.eventname}"/>
            <br>
            <br>
            Region <form:select path="region">  
                <form:option value="" label="--select--"/>
                <form:option value="Boston" label="Boston" />
                <form:option value="Chicago" label="Chicago" />   
                <form:option value="New York" label="New York"/>
                <form:option value="Tennessee" label="Tennessee" />
                <form:option value="Los Angeles" label="Los Angeles" />
                <form:option value="Dallas" label="Dallas"/>
            </form:select>
            <br>
            <br>
            Street <form:input path="street" value="${event.street}"/>
            <br>
            City <form:input path="city" value="${event.city}"/>
            <br>
            State <form:input path="state" value="${event.state}"/>
            <br>
            Zipcode <form:input path="zipcode" value="${event.zipcode}"/>      
            <br>
            <br>
            Date (mm-dd-yyyy) <form:input path="eventdate" value="${event.eventdate}"/>
            <br>
            <br>
            Type of Event <form:select path="type" >
                <form:option value="" label="--select--"/>
                <form:option value="Art" label="Art"/>
                <form:option value="Sports" label="Sports"/>
                <form:option value="Food" label="Food"/>
                <form:option value="Entertainment" label="Entertainment"/>
                <form:option value="Education" label="Education"/>
            </form:select>
            <br>
            <br>
            Ticket Price $<form:input path="price" value="${event.price}"/>
            <form:hidden path = "eventid" value = "${event.eventid}"/>
            <form:hidden path = "creatorid" value = "${event.creatorid}"/>
            <input type="hidden" id="eventid" value="${event.eventid}"/>
            <br>
            <br>
            Image Filename <form:input path="imagefile" value= "${event.imagefile}"/>
            <br>
            <br>
            <input class="start" type="submit" value="Update"/>
        </form:form>
        <c:if test="${sessionScope.myUser.role == 'event admin'}">
            <a href="/EventBiz/eventlist.htm">Cancel</a>
        </c:if>
        <c:if test="${sessionScope.myUser.role == 'admin'}">
            <a href="/EventBiz/allevents.htm">Cancel</a>
        </c:if>
        </div>
    </body>
</html>
