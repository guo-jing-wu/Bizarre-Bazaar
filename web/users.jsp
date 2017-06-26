<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="dbUtils.DbConn" %>
<%@page language="java" import="view.WebUserView" %>
<%@page language="java" import="model.WebUser.StringData" %>
<%@page language="java" import="model.WebUser.Validate" %>
<%@page language="java" import="model.WebUser.WebUserMods" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
        <link id="cssLinkID" href="style/mystyle.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="myscript.js"></script>
        <script>
            readCookieSetStyle();
        </script>
        <title>Bizarre Bazaar</title>
    </head>
    <jsp:include page="pre-content.jsp" />
    <script>
        document.getElementById("users").className = "tab selected";
    </script>
    <%
        // All properties of a new webUserStringData object are "" (empty string).
        StringData webUserStringData = new StringData();

        // All error mesages in the new Validate object are "" (empty string)  
        // This is good for first display.
        Validate webUserValidate = new Validate();

        String strWebUserId = ""; // will be null or "" unless user is trying to update 

        // This will hold a confirmation or error message relating to user's update attempt
        String formMsg = "";

        DbConn dbc = new DbConn();
        String dbErrorOrData = dbc.getErr();
        if (dbErrorOrData.length() == 0) { // got open connection

            // This object can do update, delete, insert.
            WebUserMods webUserMods = new WebUserMods(dbc);

            // webUserId (html form input) will have a value (not null, not empty)
            // if the user is trying to update.
            strWebUserId = request.getParameter("webUserId");
            if (strWebUserId != null && strWebUserId.length() > 0) {

                // postback -- fill WebUserData object with form data.
                webUserStringData.webUserId = request.getParameter("webUserId");
                webUserStringData.userEmail = request.getParameter("userEmail");
                webUserStringData.userPw = request.getParameter("userPw");
                webUserStringData.userPw2 = request.getParameter("userPw2");
                webUserStringData.membershipFee = request.getParameter("membershipFee");
                webUserStringData.birthday = request.getParameter("birthday");
                webUserStringData.userRoleId = request.getParameter("userRoleId");

                webUserValidate = new Validate(webUserStringData); // populate error messages from user inputs

                // try to update the Web User record. returns error message or empty string
                formMsg = webUserMods.update(webUserValidate); // empty string means went in OK.
                if (formMsg.length() == 0) { //trying to insert from a web user validation object.
                    formMsg = "Record " + webUserStringData.userEmail + " updated. ";
                }

            } // checking if strWebUserId not null (means they wanted to update)

            // got open connection, check to see if the user wants to delete a row.
            String delKey = request.getParameter("deletePK");
            if (delKey != null && delKey.length() > 0) {

                // yep, they want to delete a row, instantiate objects needed to do the delete.
                WebUserMods sqlMods = new WebUserMods(dbc);

                // try to delete the row that has PK = delKey
                String delMsg = sqlMods.delete(delKey);
                if (delMsg.length() == 0) {
                    out.println("<h3>Web User " + delKey + " has been deleted</h3>");
                } else {
                    out.println("<h3>Unable to delete Web User " + delKey + ". " + sqlMods.getErrorMsg() + "</h3>");
                }
            } else {
                out.println(""); // place holder for message (so data grid remains in same place before and after delete.s
            }
            // delete processed (if necessary)
            
            // this is a String that holds the whole result set formated into a HTML table.
            dbErrorOrData = WebUserView.listAllUsers("resultSetFormat",
                    "javascript:sendRequest", "icons/update.png", "javascript:deleteRow", "icons/delete.png", dbc);

        } // got open connection

        // PREVENT DB connection leaks: shouldnt hurt to close it even if it was never opened.
        dbc.close();
    %>

    <h1 id='text' style="text-align: center">Web Users</h1>
    <form action="insertUser.jsp">
        <input type="submit" value="Register">
    </form>
    <div id="inputArea"> <!-- user input area for updating field values -->
        <form name="updateForm" action="users.jsp" method="get">           
            <input type="hidden"  size="6" name="webUserId" value="<%= webUserStringData.webUserId%>" />
            <br/>
            <table class="inputTable">
                <tr>
                    <td class="prompt">User Email:</td>
                    <td><input type="text" name="userEmail" size="45" value="<%= webUserStringData.userEmail%>" /></td>
                    <td class="error"><%=webUserValidate.getUserEmailMsg()%></td>
                </tr>
                <tr>
                    <td class="prompt">Password:</td>
                    <td><input type="password" name="userPw" size="45" value="<%= webUserStringData.userPw%>" /></td>
                    <td class="error"><%=webUserValidate.getUserPwMsg()%></td>
                </tr>
                <tr>
                    <td class="prompt">Retype Password:</td>
                    <td><input type="password" name="userPw2" size="45" value="<%= webUserStringData.userPw%>" /></td>
                    <td class="error"><%=webUserValidate.getUserPw2Msg()%></td>
                </tr>
                <tr>
                    <td class="prompt">Membership Fee:</td>
                    <td><input type="text" name="membershipFee" value="<%= webUserStringData.membershipFee%>" /></td>
                    <td class="error"><%=webUserValidate.getMembershipFeeMsg()%></td>   
                <tr>
                    <td class="prompt">User Role:</td>
                    <td><input type="text" name="userRoleId" value="<%= webUserStringData.userRoleId%>" /></td>
                    <td class="error"><%=webUserValidate.getUserRoleMsg()%></td>
                </tr>
                <tr>
                    <td class="prompt">Birthday:</td>
                    <td><input type="text" name="birthday" value="<%= webUserStringData.birthday%>" /></td>
                    <td class="error"><%=webUserValidate.getBirthdayMsg()%></td>                    
                </tr>
                <tr>
                    <td class="prompt"><input type="submit" value="Update" /></td>
                    <td><input type="button" value="Cancel / Done" onclick="cancelDone()"/></td>
                    <td id="message"><%=formMsg%></td>
                </tr>
            </table>          
        </form>
    </div>  <!-- end of user input area -->
    <form name="updateDelete" action="users.jsp" method="get">
        <input type="hidden" name="deletePK">
    </form>
    <% out.print(dbErrorOrData);%>
    <script language="Javascript" type="text/javascript">

        // The input area starts out being invisible (display: none).  
        // When the user clicks the edit button javascript function sendRequest makes this area visible
        // (display: block). When the user clicks submit (after edit complete), this JSP page posts to 
        // itself and the input area needs to stay visible (to show validation error messages or sucess message).
        // That's why this function is called at body onload time.
        function setInputArea() {
            if (document.updateForm.webUserId.value != null &&
                    document.updateForm.webUserId.value.length > 0) {
                $("inputArea").style.display = "block";
            }
        }

        function $(id) {  // it is easier to call this $() function than having to write document.getElementById()
            return document.getElementById(id);
        }

        // Note: These next 9 lines of javascript are global (not in any funtion).
        // This is needed for asynchronous calls. 
        // 
        // Make the XMLHttpRequest Object
        var httpReq;
        if (window.XMLHttpRequest) {
            httpReq = new XMLHttpRequest();  //For Firefox, Safari, Opera
        }
        else if (window.ActiveXObject) {
            httpReq = new ActiveXObject("Microsoft.XMLHTTP");         //For IE 5+
        } else {
            alert('ajax not supported');
        }

        // this is ajax call to server, 
        // asking for all the data associated with a particular primary key
        function sendRequest(primaryKey) {
            httpReq.open("GET", "get_webUser_JSON.jsp?primaryKey=" + primaryKey);
            httpReq.onreadystatechange = handleResponse;
            httpReq.send(null);
        }
        function handleResponse() {

            // Make visible the input area (where user will see the data values and be able to update them) 
            document.getElementById("inputArea").style.display = "block";

            if (httpReq.readyState == 4 && httpReq.status == 200) {
                //alert('handling response ready 4 status 200');
                var response = httpReq.responseText;

                // be careful -- field names on the document are case sensative
                // field names extracted from the JSON response are also case sensative.
                var webUserObj = eval(response);

                document.updateForm.webUserId.value = webUserObj.webUserId;

                document.updateForm.userEmail.value = webUserObj.userEmail;

                document.updateForm.userPw.value = webUserObj.userPw;

                document.updateForm.userPw2.value = webUserObj.userPw2;

                document.updateForm.membershipFee.value = webUserObj.membershipFee;

                document.updateForm.userRoleId.value = webUserObj.userRoleId;

                document.updateForm.birthday.value = webUserObj.birthday;

                $("message").innerHTML = ""; // clear out the previous form message.

                var q = document.getElementsByClassName("error");
                var i = 0;
                while (q[i] != null) {
                    q[i].innerHTML = "";
                    i++;
                }
            }
        }

        function cancelDone() {
            //alert("clearing...")
            document.getElementById("inputArea").style.display = "none";
        }
        function deleteRow(primaryKey) {
            if (confirm("Do you really want to delete web user " + primaryKey + "?")) {
                document.updateDelete.deletePK.value = primaryKey;
                document.updateDelete.submit();
            }
        }
        setInputArea();
    </script>
    <jsp:include page="post-content.jsp" />