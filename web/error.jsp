<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
        <script type="text/javascript" src="myscript.js"></script>
        <link id="cssLinkID" href="style/mystyle.css" rel="stylesheet" type="text/css" >
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>
            readCookieSetStyle();
            $(document).ready(function () {
                $("p").hide();
                $("h2").click(function () {
                    $(this).next().slideToggle(200); // slide in 200 milliseconds
                });
            });
            $(document).ready(function () {
                $("p").hide();
                $("h3").click(function () {
                    $(this).next().slideToggle(200); // slide in 200 milliseconds
                });
            });
        </script>
        <title>Bizarre Bazaar</title>
        <%
            String msg = "";
            if (request.getParameter("denyMsg") != null) {
                msg = request.getParameter("denyMsg");
            }
        %>
    </head>
    <jsp:include page="pre-content.jsp" />
    <script>
        document.getElementById("home").className = "tab selected";
    </script>
    <h2 id='text' style="text-align: center">Welcome to the Bizarre Bazaar</h2>

    <h3>Sorry, but you must be logged on to view the page.</h3>
    <p><%=msg%></p>
    <jsp:include page="post-content.jsp" />
