<%@page import="view.Search"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="model.WebUser.*" %>
<%@page language="java" import="dbUtils.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        document.getElementById("addUser").className = "tab selected";
    </script>
    <%
        // Constructor sets all fields of WebUser.StringData to "" (empty string) - good for 1st rendering
        StringData wuStringData = new StringData();

        // Default constructor sets all error messages to "" - good for 1st rendering
        Validate wuValidate = new Validate();

        DbConn dbc = new DbConn();
        String msg = "";
        String strUser = "";
        int userid = 0;
        msg = dbc.getErr();
        String sql = "Select user_role_id ,user_role from user_role order by user_role";

        if (msg.length() == 0) { // means no error getting db connection
            if (request.getParameter("userEmail") != null) { // postback 

                // fill WebUserData object with form data (form data is always String)
                wuStringData.userEmail = request.getParameter("userEmail");
                wuStringData.userPw = request.getParameter("userPw");
                wuStringData.userPw2 = request.getParameter("userPw2");
                wuStringData.membershipFee = request.getParameter("membershipFee");
                wuStringData.birthday = request.getParameter("birthday");
                wuStringData.userRoleId = request.getParameter("userRoleId");
                userid = Integer.parseInt(wuStringData.userRoleId);
                wuValidate = new Validate(wuStringData); // validate user input, set error messages.
                if (wuValidate.isValidated()) { // data is good, proceed to try to insert

                    // Instantiate Web User Mod object and pass validated String Data to its insert method
                    WebUserMods webUserMods = new WebUserMods(dbc);
                    msg = webUserMods.insert(wuValidate);

                    if (msg.length() == 0) { // empty string means record was sucessfully inserted
                        msg = "Record inserted. ";
                    }
                }
            } // postback
        }

    %>
    <h1 id='text' style="text-align: center">User Registration</h1>
    <form name="myForm" action="insertUser.jsp" method="POST">
        <table style="text-align:left; padding:5px;">
            <tr>
                <td>User Email</td>
                <td><input type="text" name="userEmail" value="<%= wuStringData.userEmail%>" /></td>
                <td class="error"><%=wuValidate.getUserEmailMsg()%></td>
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="password" name="userPw" value="<%= wuStringData.userPw%>" /></td>
                <td class="error"><%=wuValidate.getUserPwMsg()%></td>
            </tr>
            <tr>
                <td>Re-type Password</td>
                <td><input type="password" name="userPw2" value="<%= wuStringData.userPw2%>" /></td>
                <td class="error"><%=wuValidate.getUserPw2Msg()%></td>
            </tr>
            <tr>
                <td>Membership Fee</td>
                <td><input type="text" name="membershipFee" value="<%= wuStringData.membershipFee%>" /></td>
                <td class="error"><%=wuValidate.getMembershipFeeMsg()%></td>
            </tr>
            <tr>
                <td>User Role</td>
                <td><%out.print(Search.selectTag(sql, "userRoleId", 0, "Select User Role", userid, dbc));%></td>
                <td class="error"><%=wuValidate.getUserRoleMsg()%></td>
            </tr>
            <tr>
                <td>Birthday</td>
                <td><input type="text" name="birthday" value="<%= wuStringData.birthday%>" /></td>
                <td class="error"><%=wuValidate.getBirthdayMsg()%></td>                    </tr>
            <tr>
                <td><input type="submit" value="Submit" /></td>
                <td colspan="2" class="error"><%=msg%></td>
            </tr>
        </table>
    </form>
    <form action="users.jsp">
        <input type="submit" value="Go back">
    </form>

    <%// PREVENT DB connection leaks:
        dbc.close(); //    EVERY code path that opens a db connection, must also close it.
    %>
    <jsp:include page="post-content.jsp" />

    <%! /**
         * can put methods here
         *
         * public String hello() { return "hello"; }
         */
    %>