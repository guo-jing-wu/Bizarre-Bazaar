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
    </head>
    <jsp:include page="pre-content.jsp?logonPage=yes" />
    <script>
        document.getElementById("home").className = "tab selected";
    </script>
    <h2 id='text' style="text-align: center">Welcome to the Bizarre Bazaar</h2>
    <p id='text'>
        <img id="image" src ="images/image.jpg" alt ="Image" align="left">
        Welcome to the Bizarre Bazaar, a wonderful little web site filled with various curiosities.
        Delight your mind with these oddities as you scoured through our collection from various unique people across the world.
        We have everything you need to satisfy that itch for the weird, strange, and the bizarre.
    </p>
    <h3 id='text' style="text-align: center">What can the Bizarre Bazaar offer you?</h3>
    <p id='text'>
        <img id="image" src ="images/snake-oil.jpg" alt ="Image" align="right">
        Some of our most popular items are a horse mask, snake oil, a sample of uranium ore and so much more.
        Customers have been fully satisfied with these wondrous family-friendly gifts.
        If there is something you want that we don't possessed in our collection, we will find it and offer it at half the price.
        Still unsatisfied? Then send us back the product within 30 days and we will refund you with no charges.
    </p>

    <jsp:include page="post-content.jsp" />
