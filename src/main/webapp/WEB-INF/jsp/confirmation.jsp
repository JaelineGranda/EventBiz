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
            <li><a href="/EventBiz/mybookings.htm">My bookings</a></li>
            <li class="right"><a href="/EventBiz/index.htm">Logout</a></li>
            </ul>
        <br>
        <div class="grid-container">
        <div class="grid-item" id="confirmation">
        <div>Congrats ${myUser.firstname}! You're going to "${event.eventname}!"</div>
        <img src="<%=request.getContextPath()%>/resources/images/${event.imagefile}.jpg" width="100%">
        <br>
        ${event.eventdate}
        <br>
        ${event.street} ${event.city}, ${event.state} ${event.zipcode}
        <br>
        Total Payment: $ ${booking.amount}
        </div>
        </div>
    </body>
</html>
