function bb() {
    window.requestAnimFrame = (function (callback) {
        return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame ||
                function (callback) {
                    window.setTimeout(callback, 1000 / 60);
                };
    })();

    function initBalls() {
        balls = [];

        var purple = '#7410FF';
        var blue = '#1A20FF';
        var turquoise = '#0B9AFF';

        // H
        balls.push(new Ball(94, 49, 0, 0, purple));
        balls.push(new Ball(81, 50, 0, 0, purple));
        balls.push(new Ball(91, 61, 0, 0, purple));
        balls.push(new Ball(90, 73, 0, 0, purple));
        balls.push(new Ball(92, 89, 0, 0, purple));
        balls.push(new Ball(90, 105, 0, 0, purple));
        balls.push(new Ball(90, 118, 0, 0, purple));
        balls.push(new Ball(88, 128, 0, 0, purple));
        balls.push(new Ball(100, 128, 0, 0, purple));
        balls.push(new Ball(102, 89, 0, 0, purple));
        balls.push(new Ball(112, 89, 0, 0, purple));
        balls.push(new Ball(122, 89, 0, 0, purple));
        balls.push(new Ball(132, 89, 0, 0, purple));
        balls.push(new Ball(144, 49, 0, 0, purple));
        balls.push(new Ball(131, 50, 0, 0, purple));
        balls.push(new Ball(141, 61, 0, 0, purple));
        balls.push(new Ball(140, 73, 0, 0, purple));
        balls.push(new Ball(142, 89, 0, 0, purple));
        balls.push(new Ball(140, 105, 0, 0, purple));
        balls.push(new Ball(140, 118, 0, 0, purple));
        balls.push(new Ball(138, 128, 0, 0, purple));
        balls.push(new Ball(150, 128, 0, 0, purple));

        // E
        balls.push(new Ball(176, 101, 0, 0, blue));
        balls.push(new Ball(186, 98, 0, 0, blue));
        balls.push(new Ball(201, 95, 0, 0, blue));
        balls.push(new Ball(199, 83, 0, 0, blue));
        balls.push(new Ball(193, 78, 0, 0, blue));
        balls.push(new Ball(180, 77, 0, 0, blue));
        balls.push(new Ball(168, 82, 0, 0, blue));
        balls.push(new Ball(164, 93, 0, 0, blue));
        balls.push(new Ball(162, 108, 0, 0, blue));
        balls.push(new Ball(170, 120, 0, 0, blue));
        balls.push(new Ball(180, 127, 0, 0, blue));
        balls.push(new Ball(192, 130, 0, 0, blue));
        balls.push(new Ball(200, 125, 0, 0, blue));

        // L
        balls.push(new Ball(229, 49, 0, 0, turquoise));
        balls.push(new Ball(216, 50, 0, 0, turquoise));
        balls.push(new Ball(226, 61, 0, 0, turquoise));
        balls.push(new Ball(225, 73, 0, 0, turquoise));
        balls.push(new Ball(227, 89, 0, 0, turquoise));
        balls.push(new Ball(225, 105, 0, 0, turquoise));
        balls.push(new Ball(225, 118, 0, 0, turquoise));
        balls.push(new Ball(223, 128, 0, 0, turquoise));
        balls.push(new Ball(235, 128, 0, 0, turquoise));

        // L
        var oOffset = 35;
        balls.push(new Ball(oOffset + 229, 49, 0, 0, turquoise));
        balls.push(new Ball(oOffset + 216, 50, 0, 0, turquoise));
        balls.push(new Ball(oOffset + 226, 61, 0, 0, turquoise));
        balls.push(new Ball(oOffset + 225, 73, 0, 0, turquoise));
        balls.push(new Ball(oOffset + 227, 89, 0, 0, turquoise));
        balls.push(new Ball(oOffset + 225, 105, 0, 0, turquoise));
        balls.push(new Ball(oOffset + 225, 118, 0, 0, turquoise));
        balls.push(new Ball(oOffset + 223, 128, 0, 0, turquoise));
        balls.push(new Ball(oOffset + 235, 128, 0, 0, turquoise));

        // O
        balls.push(new Ball(300, 81, 0, 0, blue));
        balls.push(new Ball(287, 91, 0, 0, blue));
        balls.push(new Ball(286, 103, 0, 0, blue));
        balls.push(new Ball(290, 116, 0, 0, blue));
        balls.push(new Ball(299, 127, 0, 0, blue));
        balls.push(new Ball(313, 130, 0, 0, blue));
        balls.push(new Ball(327, 127, 0, 0, blue));
        balls.push(new Ball(334, 114, 0, 0, blue));
        balls.push(new Ball(332, 98, 0, 0, blue));
        balls.push(new Ball(327, 86, 0, 0, blue));
        balls.push(new Ball(315, 81, 0, 0, blue));

        return balls;
    }
    function getMousePos(canvas, evt) {
        // get canvas position
        var obj = canvas;
        var top = 0;
        var left = 0;
        while (obj.tagName !== 'BODY') {
            top += obj.offsetTop;
            left += obj.offsetLeft;
            obj = obj.offsetParent;
        }

        // return relative mouse position
        var mouseX = evt.clientX - left + window.pageXOffset;
        var mouseY = evt.clientY - top + window.pageYOffset;
        return {
            x: mouseX,
            y: mouseY
        };
    }
    function updateBalls(canvas, balls, timeDiff, mousePos) {
        var context = canvas.getContext('2d');
        var collisionDamper = 0.3;
        var floorFriction = 0.0005 * timeDiff;
        var mouseForceMultiplier = 1 * timeDiff;
        var restoreForce = 0.002 * timeDiff;

        for (var n = 0; n < balls.length; n++) {
            var ball = balls[n];
            // set ball position based on velocity
            ball.y += ball.vy;
            ball.x += ball.vx;

            // restore forces
            if (ball.x > ball.origX) {
                ball.vx -= restoreForce;
            }
            else {
                ball.vx += restoreForce;
            }
            if (ball.y > ball.origY) {
                ball.vy -= restoreForce;
            }
            else {
                ball.vy += restoreForce;
            }

            // mouse forces
            var mouseX = mousePos.x;
            var mouseY = mousePos.y;

            var distX = ball.x - mouseX;
            var distY = ball.y - mouseY;

            var radius = Math.sqrt(Math.pow(distX, 2) + Math.pow(distY, 2));

            var totalDist = Math.abs(distX) + Math.abs(distY);

            var forceX = (Math.abs(distX) / totalDist) * (1 / radius) * mouseForceMultiplier;
            var forceY = (Math.abs(distY) / totalDist) * (1 / radius) * mouseForceMultiplier;

            if (distX > 0) {// mouse is left of ball
                ball.vx += forceX;
            }
            else {
                ball.vx -= forceX;
            }
            if (distY > 0) {// mouse is on top of ball
                ball.vy += forceY;
            }
            else {
                ball.vy -= forceY;
            }

            // floor friction
            if (ball.vx > 0) {
                ball.vx -= floorFriction;
            }
            else if (ball.vx < 0) {
                ball.vx += floorFriction;
            }
            if (ball.vy > 0) {
                ball.vy -= floorFriction;
            }
            else if (ball.vy < 0) {
                ball.vy += floorFriction;
            }

            // floor condition
            if (ball.y > (canvas.height - ball.radius)) {
                ball.y = canvas.height - ball.radius - 2;
                ball.vy *= -1;
                ball.vy *= (1 - collisionDamper);
            }

            // ceiling condition
            if (ball.y < (ball.radius)) {
                ball.y = ball.radius + 2;
                ball.vy *= -1;
                ball.vy *= (1 - collisionDamper);
            }

            // right wall condition
            if (ball.x > (canvas.width - ball.radius)) {
                ball.x = canvas.width - ball.radius - 2;
                ball.vx *= -1;
                ball.vx *= (1 - collisionDamper);
            }

            // left wall condition
            if (ball.x < (ball.radius)) {
                ball.x = ball.radius + 2;
                ball.vx *= -1;
                ball.vx *= (1 - collisionDamper);
            }
        }
    }
    function Ball(x, y, vx, vy, color) {
        this.x = x;
        this.y = y;
        this.vx = vx;
        this.vy = vy;
        this.color = color;
        this.origX = x;
        this.origY = y;
        this.radius = 10;
    }
    function animate(canvas, balls, lastTime, mousePos) {
        var context = canvas.getContext('2d');

        // update
        var date = new Date();
        var time = date.getTime();
        var timeDiff = time - lastTime;
        updateBalls(canvas, balls, timeDiff, mousePos);
        lastTime = time;

        // clear
        context.clearRect(0, 0, canvas.width, canvas.height);

        // render
        for (var n = 0; n < balls.length; n++) {
            var ball = balls[n];
            context.beginPath();
            context.arc(ball.x, ball.y, ball.radius, 0, 2 * Math.PI, false);
            context.fillStyle = ball.color;
            context.fill();
        }

        // request new frame
        requestAnimFrame(function () {
            animate(canvas, balls, lastTime, mousePos);
        });
    }
    var canvas = document.getElementById('myCanvas');
    var balls = initBalls();
    var date = new Date();
    var time = date.getTime();
    /*
     * set mouse position really far away
     * so the mouse forces are nearly obsolete
     */
    var mousePos = {
        x: 9999,
        y: 9999
    };

    canvas.addEventListener('mousemove', function (evt) {
        var pos = getMousePos(canvas, evt);
        mousePos.x = pos.x;
        mousePos.y = pos.y;
    });

    canvas.addEventListener('mouseout', function (evt) {
        mousePos.x = 9999;
        mousePos.y = 9999;
    });
    animate(canvas, balls, time, mousePos);
}