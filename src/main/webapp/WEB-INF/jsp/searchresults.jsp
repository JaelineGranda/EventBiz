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
        <br>
        <div class="searchbar">
        <div>Search for Events</div>
        <br>
        <form:form action="/EventBiz/events.htm" modelAttribute="event">
            Region: <form:select path="region">  
                <form:option value="" label="All"/>
                <form:option value="Boston" label="Boston"/>
                <form:option value="Chicago" label="Chicago"/>   
                <form:option value="New York" label="New York"/>
                <form:option value="Tennessee" label="Tennessee"/>
                <form:option value="Los Angeles" label="Los Angeles"/>
                <form:option value="Dallas" label="Dallas"/>
            </form:select>
            <br>
            Type of Event <form:select path="type" >
                <form:option value="" label="All"/>
                <form:option value="Art" label="Art"/>
                <form:option value="Sports" label="Sports"/>
                <form:option value="Food" label="Food"/>
                <form:option value="Entertainment" label="Entertainment"/>
                <form:option value="Education" label="Education"/>
            </form:select>
            <br>
            Keyword:
            <form:input path="eventname" />
            <br>
            <input type="radio" id="paid" name="payment" value="paid"/> Paid
            <input type="radio" id="free" name="payment" value="free"/> Free
            <br>
            <br>
            <input class="start" type="submit" value="Search"/>
        </form:form>
        </div>
        <br>
<span class="recent">RESULTS FOR YOUR SEARCH</span>
        <br>
        <br>
        <c:set var="list" value="${events}"/>
        <c:if test="${list!=null}"> 
        <div class="grid-container">
            <c:forEach var="ev" items="${events}">
            <div class="grid-item">
                <img src="<%=request.getContextPath()%>/resources/images/${ev.imagefile}.jpg" width="10%">
                <br>
                ${ev.eventname}
                <br>
                ${ev.region}
                <br>
                ${ev.eventdate}
                <br>
                ${ev.type}
                <br>
                <c:if test="${ev.price <= 0}">
                    FREE
                </c:if>
                <c:if test="${ev.price > 0}">
                $ ${ev.price}
                </c:if>
                <br>
                <c:if test= "${sessionScope.myUser.role == 'customer'}">
                    <c:choose>
                        <c:when test="${ev.price > 0}">
                            <a class="start2" href="/EventBiz/bookevent.htm?id=<c:out value='${ev.eventid}' />">Buy ticket</a>
                            <br>
                        </c:when>
                        <c:otherwise>  
                            <a class="start2" href="/EventBiz/bookevent.htm?id=<c:out value='${ev.eventid}' />">Reserve</a>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                </div>
            </c:forEach>
        </div>
        </c:if>

        <c:if test="${list.isEmpty()}">
        <div class="grid-container"> 
        <div class="grid-item">
        No matches found for this search
            <br>
            <a href="/EventBiz/welcome.htm">Search again</a>
        </div>
        </div>
        </c:if>
    </body>
</html>
