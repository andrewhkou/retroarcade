function love.load()
    screenDimX = 1280;
    screenDimY = 720;
    totalTimeElapsed = 0;
    highScore = 0;
    score = 0;
    score1 = 0;
    score2 = 0;
    timeElapsed = 0;
    paddleSpeed = 5;

    paddleWidth = 20
    paddleHeight = 70

    paddle1 = {
        x = 50,
        y = (screenDimY / 2) -  (paddleHeight / 2);
        vel= 0;
    }

    paddle2 = {
        x = screenDimX - 50 - paddleWidth,
        y = (screenDimY / 2) -  (paddleHeight / 2), 
        vel = 0;
    }


    ball = {
        x = 50,
        y = 50,
        velX = 2,
        velY = -1,
        radius = 8
    }

    love.window.setTitle("Pong");
    love.window.setMode(screenDimX, screenDimY)

    function ballXBorder(ball) 
        return ball.x + ball.radius
    end

    function ballYBorder(ball) 
        return ball.y + ball.radius
    end

    function paddle1Collision(ball, paddle1)
        return true 
    end

    function paddle2Collision(ball, paddle2)
        return true
    end

    function wallVerticalCollision(ball)
        ball.velY = -ball.velY
    end

    function wallHorizontalCollision(ball)
        ball.velX = -ball.velX
    end
end

function love.update(dt) 
    timeElapsed = timeElapsed + dt;
    totalTimeElapsed = totalTimeElapsed + 1;

    -- handles keyboard inputs
    if not love.keyboard.isDown('w') or not love.keyboard.isDown('s') then
        paddle1.vel = 0;
    end

    if not love.keyboard.isDown('up') or not love.keyboard.isDown('down') then
        paddle2.vel = 0;
    end

    if love.keyboard.isDown('w') and paddle1.y > 0 then
        paddle1.y = paddle1.y - paddleSpeed
        paddle1.vel = 5
    end
    if love.keyboard.isDown('s') and (paddle1.y + paddleHeight) < screenDimY then
        paddle1.y = paddle1.y + paddleSpeed 
        paddle1.vel = -5
    end
    if love.keyboard.isDown('up') and paddle2.y > 0 then
        paddle2.y = paddle2.y - paddleSpeed
        paddle2.vel = 5
    end
    if love.keyboard.isDown('down') and (paddle2.y + paddleHeight) < screenDimY then
        paddle2.y = paddle2.y + paddleSpeed
        paddle2.vel = -5
    end

    -- handles ball movement
    if ballXBorder(ball) <= 0 or ballXBorder(ball) >= screenDimX then
        wallHorizontalCollision(ball)
    end

    if ballYBorder(ball) <= 0 or ballYBorder(ball) >= screenDimY then
        wallVerticalCollision(ball)
    end 

    ball.x = ball.x + ball.velX
    ball.y = ball.y + ball.velY


end

function love.draw() 
    love.graphics.line(screenDimX/2, screenDimY, screenDimX/2, 0)
    love.graphics.rectangle('fill', paddle1.x, paddle1.y, paddleWidth, paddleHeight)
    love.graphics.rectangle('fill', paddle2.x, paddle2.y, paddleWidth, paddleHeight)
    love.graphics.circle('fill', ball.x, ball.y, ball.radius)
end
