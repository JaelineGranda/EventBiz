<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
            <li><a href="/EventBiz/mybookings.htm">My bookings</a></li>
            <li class="right"><a href="/EventBiz/index.htm">Logout</a></li>
            </ul>
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
    <c:set var="date" value="${date}"/>
    <c:if test="${event.price > 0}">
        <p class ="price"> Price: $${event.price} </p>
                
        <form:form action="/EventBiz/confirmation.htm" modelAttribute ="booking">
        Number of tickets:
        <form:hidden path="customerid" value="${sessionScope.myUser.userid}"/>
        <form:hidden path="firstname" value="${sessionScope.myUser.firstname}"/>
        <form:hidden path="lastname" value="${sessionScope.myUser.lastname}"/>
        <form:hidden path="email" value="${sessionScope.myUser.email}"/>
        <form:hidden path="eventid" value="${event.eventid}"/>
        <form:select path="tickets" id="numtickets" onchange="myFunc()">
            <form:option value="1" />
            <form:option value="2" />
            <form:option value="3" />
            <form:option value="4" />
            <form:option value="5" />
        </form:select>
        <form:hidden id="amount" path="amount" value="${event.price}"/>
        <br>
        <br>
        Enter payment details
        <br>
        <br>
        <div id="payment">
            Name on Card: <input type="text" name="custname" required/>
            <br>
            Card Number:  <input type="text" name="card" placeholder="0000 0000 0000 0000" minlength="16" required/>
            <br>
            Expiration Date: <input type= "text" name="exp" placeholder="12/2021" minlength="7" required/>
            <br>
            CVV: <input type= "text" name="cvv" placeholder="000" minlrequired/>
            <br>
            <input id="price" type="hidden" value="${event.price}"/>
            <br>
            <div id="total">Total: $ ${event.price}</div>
        <br>
        <form:hidden path="date" value="${date}"/>
        <input type="hidden" name="eventid" value="${event.eventid}">
        <input class="start" type="submit" value="Submit Payment"/>
        </form:form>
        </div>
    </c:if>
        
    <c:if test="${event.price == 0}">
        <form:form action="/EventBiz/confirmation.htm" modelAttribute ="booking">
        Number of tickets:
        <br>
        <form:select path="tickets" id="numtickets" class="numtickets">
            <form:option value="1" />
            <form:option value="2" />
            <form:option value="3" />
            <form:option value="4" />
            <form:option value="5" />
        </form:select>
        <br>
        <form:hidden path="amount" value="0.00"/>
        <form:hidden path="date" value="${date}"/>
        <input type="hidden" name="eventid" value="${event.eventid}">
        <input class="start" type="submit" value="Reserve"/>    
        </form:form>
    </c:if>
    </div>
    </div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
function myFunc() {
    var tickets = $("#numtickets").val();
    var price = $("#price").val();
    $("#amount").val(price*tickets);
    $("#total").text("Total: $" + (price*tickets).toFixed(2));
   }
</script>
</html>
