<%@page import="view.Search"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="dbUtils.DbConn" %>
<%@page import="view.PricingInfoView"%>

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
            document.getElementById("search").className = "tab selected";
        </script>
        <%
            String strUser = "";
            String strProduct = "";
            String strDisrate = "";
            int userId = 0;
            int productId = 0;

            DbConn dbc = new DbConn();
            String msg = dbc.getErr(); // returns "" if connection is good, else error msg.
            String userListSql = "SELECT web_user_id, user_email " //sql used for the user pick list
                    + "FROM web_user "
                    + "ORDER BY user_email";
            String productListSql = "SELECT product_id, product_name " //dql used for product pick list
                    + "FROM product "
                    + "ORDER BY product_name";
            if (msg.length() == 0) { // got open db connection
                if (request.getParameter("user") != null) {
                    strUser = request.getParameter("user");
                    userId = Integer.parseInt(strUser);
                    strProduct = request.getParameter("product");
                    productId = Integer.parseInt(strProduct);
                    strDisrate = request.getParameter("disc");
                    msg = Search.searchInfo("resultSetFormat", strUser, strProduct, strDisrate, dbc);
                } else {
                    // returns a string that contains a HTML table with the db data in it
                    // this is for first rendering (show them all the data)
                    msg = PricingInfoView.listAllInfo("resultSetFormat", dbc);
                }
            }
        %>

        <h1 id='text' style="text-align: center">Search</h1>

        <form action="search.jsp" method="GET">
            <table style="margin: 0px auto">
                <tr>
                    <th>Users:</th>
                    <th>Products:</th>
                    <th>Discount Rate</th>
                </tr>
                <tr>
                    <td>
                        <% out.print(Search.selectTag(userListSql, "user", 0, "&lt;All&gt;", userId, dbc));%>
                    </td>
                    <td>
                        <% out.print(Search.selectTag(productListSql, "product", 0, "&lt;All&gt;", productId, dbc));%>
                    </td>
                    <td>
                        <input name="disc" value = "<%out.print(strDisrate);%>"/>
                    </td>
                    <td>
                        <input type="submit" value="Click to Search">
                    </td>
                </tr>
            </table>
        </form>

        <%// PREVENT DB connection leaks:
            dbc.close(); //    EVERY code path that opens a db connection, must also close it.
            out.print(msg);%>

        <jsp:include page="post-content.jsp" />