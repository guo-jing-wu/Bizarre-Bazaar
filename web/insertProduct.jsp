<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="model.Product.*" %>
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
        document.getElementById("addProduct").className = "tab selected";
    </script>
    <%

        // Constructor sets all fields of WebUser.StringData to "" (empty string) - good for 1st rendering
        StringData wuStringData = new StringData();

        // Default constructor sets all error messages to "" - good for 1st rendering
        Validate wuValidate = new Validate();

        String msg = "";

        if (request.getParameter("productName") != null) { // postback 

            // fill WebUserData object with form data (form data is always String)
            wuStringData.productName = request.getParameter("productName");
            wuStringData.productDesc = request.getParameter("productDesc");
            wuStringData.productPrice = request.getParameter("price");

            wuValidate = new Validate(wuStringData); // validate user input, set error messages.
            if (wuValidate.isValidated()) { // data is good, proceed to try to insert

                DbConn dbc = new DbConn();
                msg = dbc.getErr();
                if (msg.length() == 0) { // means no error getting db connection

                    // Instantiate Web User Mod object and pass validated String Data to its insert method
                    ProductMods productMods = new ProductMods(dbc);
                    msg = productMods.insert(wuValidate);

                    if (msg.length() == 0) { // empty string means record was sucessfully inserted
                        msg = "Record inserted. ";
                    }
                }
                dbc.close(); // NEVER have db connection leaks !!!
            }
        } // postback

    %>
    <h1 id='text' style="text-align: center">Add Product</h1>
    <form name="myForm" action="insertProduct.jsp" method="POST">
        <table style="text-align:left; padding:5px;">
            <tr>
                <td>Product Name</td>
                <td><input type="text" name="productName" value="<%= wuStringData.productName%>" /></td>
                <td class="error"><%=wuValidate.getProductNameMsg()%></td>
            </tr>
            <tr>
                <td>Description</td>
                <td><input type="text" name="productDesc" value="<%= wuStringData.productDesc%>" /></td>
                <td class="error"><%=wuValidate.getProductDescMsg()%></td>
            </tr>
            <tr>
                <td>Price</td>
                <td><input type="text" name="price" value="<%= wuStringData.productPrice%>" /></td>
                <td class="error"><%=wuValidate.getProductPriceMsg()%></td>
            </tr>
            <tr>
                <td><input type="submit" value="Submit" /></td>
                <td colspan="2" class="error"><%=msg%></td>
            </tr>
        </table>
    </form>
    <form action="product.jsp">
        <input type="submit" value="Go back">
    </form>
    <jsp:include page="post-content.jsp" />

    <%! /**
         * can put methods here
         *
         * public String hello() { return "hello"; }
         */
    %>