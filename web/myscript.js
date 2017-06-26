function displayButtons() {
    if (document.getElementById("registered").checked) {
        document.getElementById("admin").disabled = false;
        document.getElementById("supplier").disabled = false;
        document.getElementById("customer").disabled = false;
    }
    else {
        document.getElementById("admin").disabled = true;
        document.getElementById("supplier").disabled = true;
        document.getElementById("customer").disabled = true;
    }
}

function changeStyle(choice) {
    if (choice.value == "clear") {
        eraseCookieValue("theme");
        document.getElementById('cssLinkID').href = "style/mystyle.css";
    } else {
        document.getElementById('cssLinkID').href = choice.value;
        setCookieValue("theme", choice.value, 3)
    }
}

function setCookieValue(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    }
    else
        var expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}

function getCookieValue(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ')
            c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0)
            return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function eraseCookieValue(name) {
    setCookieValue(name, "", -1);
}

function showCookieValue(name) {
    var val = getCookieValue(name);
    if (val == null) {
        alert("There is no cookie value named '" + name + "'");
    }
    else {
        alert(name + " = " + val);
    }
}

function showWholeCookie() {
    alert("whole cookie is " + document.cookie);
}

function readCookieSetStyle() {
    var cookieVal = getCookieValue("theme");
    if (cookieVal == null) {
        document.getElementById('cssLinkID').href = "style/mystyle.css";
    }
    else {
        document.getElementById('cssLinkID').href = cookieVal;
    }
}