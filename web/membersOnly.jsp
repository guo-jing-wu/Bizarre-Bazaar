<%@page import="model.WebUser.*" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
        <script type="text/javascript" src="myscript.js"></script>
        <link id="cssLinkID" href="style/mystyle.css" rel="stylesheet" type="text/css" >
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script type="text/javascript" src="ball.js"></script>
        <title>Bizarre Bazaar</title>
    </head>
    <%
        String msg = "";

        // Check the session to see if the customer object is in there.
        // Must use same name ("cust") when getting the object out of the session
        // as you used when you put it into the session (in logon.jsp).
        // You have to type cast the object as it comes out of the session (StringData)
        // so that you can put the object into a customer StringData object.  
        StringData loggedOnCust = (StringData) session.getAttribute("member");
        if (loggedOnCust == null) { // means use is logged in
            try {
                response.sendRedirect("error.jsp?denyMsg="
                        + "You are not authorized to view the Members Only page.");
            } catch (Exception e) {
                msg += " Exception was thrown: " + e.getMessage();
            }

        }

    %>
    <jsp:include page="pre-content.jsp" />
    <script>
        document.getElementById("members").className = "tab selected";
    </script>
    <canvas id="myCanvas" width="578" height="200"></canvas>
    <script>
        bb();
    </script>
    <jsp:include page="post-content.jsp" />
