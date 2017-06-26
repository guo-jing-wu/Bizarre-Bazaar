<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="dbUtils.DbConn" %>
<%@page language="java" import="view.PricingInfoView" %>
<%@page language="java" import="model.PricingInfo.PricingInfoMods" %>

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
        document.getElementById("info").className = "tab selected";
    </script>

    <%
        // Get database connection and check if you got it.
        DbConn dbc = new DbConn();
        String dbErrorOrData = dbc.getErr();
        if (dbErrorOrData.length() == 0) {

            // got open connection, check to see if the user wants to delete a row.
            String delKey = request.getParameter("deletePK");
            if (delKey != null && delKey.length() > 0) {

                // yep, they want to delete a row, instantiate objects needed to do the delete.
                PricingInfoMods sqlMods = new PricingInfoMods(dbc);

                // try to delete the row that has PK = delKey
                String delMsg = sqlMods.delete(delKey);
                if (delMsg.length() == 0) {
                    out.println("<h3>Pricing Info " + delKey + " has been deleted</h3>");
                } else {
                    out.println("<h3>Unable to delete Pricing Info " + delKey + ". " + sqlMods.getErrorMsg() + "</h3>");
                }
            } else {
                out.println(""); // place holder for message (so data grid remains in same place before and after delete.s
            }
            // delete processed (if necessary)

            // this is a String that holds the whole result set formated into a HTML table.
            dbErrorOrData = PricingInfoView.listDelInfo("resultSetFormat", dbc,
                    "javascript:deleteRow", "icons/delete.png");
        } // got open connection

        // PREVENT DB connection leaks: shouldnt hurt to close it even if it was never opened.
        dbc.close();
    %>

    <h1 id='text' style="text-align: center">Pricing Info</h1>
    <form name="updateDelete" action="info.jsp" method="get">
        <input type="hidden" name="deletePK">
    </form>
    <% out.print(dbErrorOrData);%>
    <script language="Javascript" type="text/javascript">
        function deleteRow(primaryKey) {
            if (confirm("Do you really want to delete pricing info " + primaryKey + "?")) {
                document.updateDelete.deletePK.value = primaryKey;
                document.updateDelete.submit();
            }
        }
    </script>
    <jsp:include page="post-content.jsp" />