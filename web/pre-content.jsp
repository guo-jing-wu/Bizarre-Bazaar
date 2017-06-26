<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.WebUser.*" %>   
<%@page import="dbUtils.DbConn"%>

<%
    // We need to initialize the variables to persist user logon credentials and logon success/failure message
    // regardless of whether we are showing the logon area or not.
    String strEmailAddress = "";
    String strUserPwd = "";
    String logonMsg = "";

    // Assume the user is logged on, so display a log off link and do NOT display the log on form
    String logonLink = "<a href='logoff.jsp' style='text-decoration:none; color: red;'>Log Off</a>";
    String logOnAreaVisibility = " display:none; ";

    // check if user is logged on or not
    if (session.getAttribute("member") == null) {

        // the user is NOT logged on. provide link for them to be able to log on 
        // (logon funcationality is provided by the index page)
        logonLink = "<a href='index.jsp' style='text-decoration:none;'>Log On</a>";

        //Is this is the index/logon page?
        String logonPage = request.getParameter("logonPage");
        if (logonPage != null) {

            // This is the index/logon page. 
            // Instead of showing them a log on link, show them the log on area
            logonLink = "";
            logOnAreaVisibility = " display:inline-block; ";

            // is this postback for user logon form?
            if (request.getParameter("emailAddress") != null) {

                // Logon form postback. Persist then check user entered logon credentials.
                strEmailAddress = request.getParameter("emailAddress");
                strUserPwd = request.getParameter("userPwd");

                // Get a database connection so we can check the database for logon credentials
                DbConn dbc = new DbConn();
                logonMsg = dbc.getErr();
                if (logonMsg.length() == 0) { // we have a good database connection

                    // pass in user's email address and password (along with open db connection)
                    // to find method. The find method will return null if not found, else
                    // it will return a customer StringData object.
                    WebUserMods msg = new WebUserMods(dbc);
                    StringData loggedOnCust = msg.findEmail(strEmailAddress, strUserPwd);
                    if (loggedOnCust == null) {
                        // Customer's credentials were not found in customer table in DB.
                        logonMsg = "Invalid email address or password";
                        try {
                            //session.invalidate(); // this try/catch seems to not work
                            // it throws an unhandled exception when you try to invalidate
                            // the session in cases where the session was already invalidated.
                        } catch (Exception e) {
                            // don't care. If session was already invalidated, then I dont 
                            // need to do anything.
                        }
                    } else if (loggedOnCust.errorMsg.length() > 0) {
                        // some exception was thrown in the find method, discover the error msg.
                        // Normally would not get this unless program has a bug.
                        logonMsg = "Error " + loggedOnCust.errorMsg;

                    } else {
                        logonMsg = "Welcome " + loggedOnCust.userEmail;

                        // put object loggedOnCust into the session, giving it the name
                        // "cust" - must use "cust" from other pages, to pull info back out of the session. 
                        session.setAttribute("member", loggedOnCust);
                        logOnAreaVisibility = " display:none; "; // hide logon area. they have already logged on.

                    } // they logged on, provide logon success message
                } // db connection is good (so credentials can be checked)
                dbc.close();
            } // it is postback from the index/logon page
        } // it is the index/logon page
    } // user is not logged on

    // Check the session to see if the customer object is in there.
    // Since we used the name "cust" putting into the session, we have to use the same name
    // "cust" when extracting from the session. What comes out from the session is an object, 
    // so type cast it to what it really is/was: customer StringData.
    StringData loggedOnCust = (StringData) session.getAttribute("member");
    if (loggedOnCust != null) { // means use is logged in
        logonLink = "Welcome " + loggedOnCust.userEmail
                + ", <a href='logoff.jsp' style='text-decoration:none;'>Log Off</a>";
    }
%>
<body>
    <br/>
    <div id="container">
        <div class="welcomeDiv">
            <%=logonLink%>
            <div style= "<%=logOnAreaVisibility%> float:right">
                <form action="index.jsp" method="get">
                    <table style="font-size:13px;">
                        <tr>
                            <td>
                                Email Address
                                <input type="text" name="emailAddress" value="<%=strEmailAddress%>"/>
                                Password
                                <input type="text" name="userPwd" value="<%=strUserPwd%>"/>
                                <input type="submit" value="Logon"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=logonMsg%>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div id="title">
            Bizarre Bazaar
        </div>  <!-- finishes off the title div -->
        <div id="nav">
            <div id="home" class="tab">
                <a href="index.jsp" style="display: block;">Home</a></div>
            <div id="info" class="tab">
                <a href="info.jsp" style="display: block;">Pricing Info</a></div>
            <div id="product" class="tab">
                <a href="product.jsp" style="display: block;">Product</a></div>
            <div id="users" class="tab">
                <a href="users.jsp" style="display: block;">Users</a></div>
            <div id="search" class="tab">
                <a href="search.jsp" style="display: block;">Search</a></div>
            <div id="contact" class="tab">
                <a href="contact.jsp" style="display: block;">Contact</a></div>
            <div id="labs" class="tab">
                <a href="labs.jsp" style="display: block;">Labs</a></div>
            <div id="member" class="tab">
                <a href="membersOnly.jsp" style="display: block;">Member</a></div>
            <div class="newLine"></div>
        </div>
        <div id="content" class="selected">