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
        document.getElementById("contact").className = "tab selected";
    </script>
    <h1 id='text'>Contact Us</h1>
    <p>
        If you need help, contact us with this form. We'll be able to help you with any issues.
    </p>
    <form name="contact" method="post" action="http://www.temple.edu/cgi-bin/mail?tue41582@temple.edu">
        <table>
            <tr>
                <td>Name: </td>
                <td><input type="text" name="name" /></td>
            </tr>
            <tr>
                <td>Email: </td>
                <td><input type="text" name="email" /></td>
            </tr>
            <tr>
                <td>User: </td>
                <td><input id="registered" type="checkbox" name="registered" onclick="displayButtons()" /></td>
            </tr>
            <tr>
                <td>Account Type: </td>
                <td>
                    <input id="admin" type="radio" name="usertype" value="a" disabled="true" />Admin
                    <input id="supplier" type="radio" name="usertype" value="s" disabled="true" />Supplier
                    <input id="customer" type="radio" name="usertype" value="c" disabled="true" />Customer
                </td>
            </tr>
            <tr>
                <td>Subject: </td>
                <td>
                    <select name="subject">
                        <option value="No Subject">&lt; Choose Issue &gt;</option>
                        <option value="Shipping">Shipping & Delivery</option>
                        <option value="Return">Returns & Refunds</option>
                        <option value="Money">Payment, Pricing & Promotions</option>
                        <option value="Order">Ordering</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Body: </td>
                <td>
                    <textarea name="body" cols="45" rows="5"></textarea>
                </td>
            </tr>
            <tr>
                <td><input type="submit" value="Submit"></td>
            </tr>
        </table>
    </form>

    <jsp:include page="post-content.jsp" />