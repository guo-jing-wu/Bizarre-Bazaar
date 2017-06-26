<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
        <link id="cssLinkID" href="style/mystyle.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="myscript.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>
            readCookieSetStyle();
            $(document).ready(function () {
                $("p").hide();
                $("h2").click(function () {
                    $(this).next().slideToggle(200); // slide in 200 milliseconds
                });
            });
        </script>
        <title>Bizarre Bazaar</title>
    </head>
    <jsp:include page="pre-content.jsp" />
    <script>
        document.getElementById("labs").className = "tab selected";
    </script>
    <h2 id='text'>Lab 1 Project Proposal</h2>
    <p>
        <a class="lab" href="lab/myproposal.pdf">Proposal</a>
    </p>
    <h2 id='text'>Lab 2 Data Model</h2>
    <p>
        <a class="lab" href="lab/model.pdf">Data Model </a>
    </p>
    <h2 id='text'>Lab 3 Home Page (HTML/CSS)</h2>
    <p>
        <a class="lab" href="index.jsp">Home Page</a>
    </p>
    <h2 id='text'>Lab 4 Forms, Javascript, Cookies</h2>
    <p>
        <a class="lab" href="contact.jsp">Contact Us</a>
    </p>
    <h2 id='text'>Lab 5 Display Data</h2>
    <p>
        <a class="lab" href="info.jsp">Pricing Info</a>
        <a class="lab" href="product.jsp">Product</a>
        <a class="lab" href="users.jsp">Users</a>
        <a class="lab" href="lab/error.pdf">Errors</a>
    </p>
    <h2 id='text'>Lab 6 Search</h2>
    <p>
        <a class="lab" href="search.jsp">Search</a>
    </p>
    <h2 id='text'>Lab 7 Insert</h2>
    <p>
        <a class="lab" href="users.jsp">Users</a>
        <a class="lab" href="product.jsp">Product</a>
    </p>
    <h2 id='text'>Lab 8 Log On</h2>
    <p>
        <a class="lab" href="index.jsp">Log On</a>
    </p>
    <h2 id='text'>Lab 9 Update Ajax</h2>
    <p>
        <a class="lab" href="users.jsp">Users</a>
        <a class="lab" href="product.jsp">Product</a>
    </p>
    <h2 id='text'>Lab 10 Delete</h2>
    <p>
        <a class="lab" href="info.jsp">Pricing Info</a>
        <a class="lab" href="users.jsp">Users</a>
        <a class="lab" href="product.jsp">Product</a>
    </p>
    <h2 id='text'>My Challenge</h2>
    <p>
        <a class="lab" href="membersOnly.jsp">HTML5</a>
    </p>
    <jsp:include page="post-content.jsp" />