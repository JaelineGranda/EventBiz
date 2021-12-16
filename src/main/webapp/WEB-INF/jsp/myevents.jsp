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
            <li><a href="/EventBiz/welcome.htm">Search for events</a></li>
            <li><a href="/EventBiz/addevent.htm">Add new event</a></li>
            <li><a href="/EventBiz/eventlist.htm">View my events</a></li>
            <li><a href="/EventBiz/eventbookings.htm">View event bookings</a></li>
            <li class="right"><a href="/EventBiz/index.htm">Logout</a></li>
        </ul>
        <br>
        My events
        <br>
        <c:set var="list" value="${events}"/>

        <c:if test="${list.isEmpty() == false}">
            <table>
                <tr>
                    <td>Event name</td>
                    <td>Date</td>
                    <td>Type</td>
                    <td>Region</td>
                    <td>Address</td>
                    <td>Price</td>
                </tr>
                <c:forEach var="ev" items="${events}">
                    <tr>
                        <td>
                            <img src="<%=request.getContextPath()%>/resources/images/${ev.imagefile}.jpg" width="10%">
                            ${ev.eventname}
                        </td>
                        <td>
                            ${ev.eventdate}
                        </td>
                        <td>
                            ${ev.type}
                        </td>
                        <td>
                            ${ev.region}
                        </td>
                        <td>
                            ${ev.street} ${ev.city}, ${ev.state} ${ev.zipcode}
                        </td>
                        <td>
                            $ ${ev.price}
                        </td>
                        <td>
                            <a href="/EventBiz/editevent.htm?id=<c:out value='${ev.eventid}' />">Edit</a>
                            <a class="delete-event" href="/EventBiz/delete-event.htm?id=<c:out value='${ev.eventid}' />">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>                
        <c:if test="${list.isEmpty()}">
            <div>No events created yet</div>
        </c:if>
    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $('.delete-event').click(function () {
            return confirm("Are you sure you want to delete this event?");
        });
    </script>
</html>
