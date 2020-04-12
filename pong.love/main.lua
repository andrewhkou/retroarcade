screenDimX = 1280;
screenDimY = 720;
totalTimeElapsed = 0;
highScore = 0;
score = 0;
score1 = 0;
score2 = 0;
timeElapsed = 0;
paddleSpeed = 5;

player1 = {
    points = 0;
}

player2 = {
    points = 0;
}

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
    x = 100,
    y = 100,
    velX = 7,
    velY = -1,
    radius = 8
}

function getPaddle1LowerY()
    return paddle1.y + paddleHeight
end

function getPaddle1UpperY()
    return paddle1.y
end

function getPaddle2LowerY()
    return paddle2.y + paddleHeight
end

function getPaddle2UpperY()
    return paddle2.y
end

function detectPaddle1Collision(ball)
    if paddle1.x + paddleWidth - ballXBorder(ball, "left") >= 0 and ball.y <= getPaddle1LowerY() and ball.y >= getPaddle1UpperY() then
        return true
    end
    return false
end

function detectPaddle2Collision(ball)
    if paddle2.x - ballXBorder(ball, "right") <= 0 and ball.y <= getPaddle2LowerY() and ball.y >= getPaddle2UpperY() then
        return true
    end
    return false
end

function resetBall1()
    ball.x = paddle1.x + paddleWidth + ball.radius + 5
    ball.y = paddle1.y + paddleHeight/2
    ball.velX = 5
    ball.velY = 0
end

function resetBall2()
    ball.x = paddle2.x - ball.radius - 5
    ball.y = paddle2.y + paddleHeight/2
    ball.velX = -5
    ball.velY = 0
end

function ballXBorder(ball, direction) 
    if (direction == "left") then
        return ball.x - ball.radius
    end
    if (direction == "right") then
        return ball.x + ball.radius
    end
    return ball.x + ball.radius
end

function ballYBorder(ball) 
    if (direction == "top") then
        return ball.y - ball.radius
    end
    if (direction == "bottom") then
        return ball.y + ball.radius
    end
    return ball.y + ball.radius
end

function wallVerticalCollision(ball)
    ball.velY = -ball.velY
end

function incrementPoints(player) 
    player.points = player.points + 1
end

function handlePaddle1Collision(ball)
    if paddle1.vel > 0 then
        ball.velY = ball.velY/2 + paddle1.vel
    elseif paddle1.vel < 0 then
        ball.velY = ball.velY/2 - paddle1.vel
    end
    ball.velX = -ball.velX
end

function handlePaddle2Collision(ball)
    if paddle2.vel > 0 then
        ball.velY = ball.velY/2 + paddle2.vel
    elseif paddle2.vel < 0 then
        ball.velY = ball.velY/2 - paddle2.vel
    end
    ball.velX = -ball.velX
end

function love.load()
    love.window.setTitle("Pong");
    love.window.setMode(screenDimX, screenDimY)
    love.graphics.setNewFont(40)
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
    if ballXBorder(ball, "left") <= 0 then
        incrementPoints(player2)
        resetBall1()
    end

    if ballXBorder(ball, "right") >= screenDimX then
        incrementPoints(player1)
        resetBall2()
    end

    if ballYBorder(ball, "top") <= 0 or ballYBorder(ball, "bottom") >= screenDimY then
       wallVerticalCollision(ball)
    end 

    if detectPaddle1Collision(ball) then
        handlePaddle1Collision(ball)
    end 

    if detectPaddle2Collision(ball) then
        handlePaddle2Collision(ball)
    end 

    ball.x = ball.x + ball.velX
    ball.y = ball.y + ball.velY


end

function love.draw() 
    love.graphics.line(screenDimX/2, screenDimY, screenDimX/2, 0)
    love.graphics.rectangle('fill', paddle1.x, paddle1.y, paddleWidth, paddleHeight)
    love.graphics.rectangle('fill', paddle2.x, paddle2.y, paddleWidth, paddleHeight)
    love.graphics.circle('fill', ball.x, ball.y, ball.radius)

    love.graphics.print(player1.points, screenDimX/2 - 100, 50)
    love.graphics.print(player2.points, screenDimX/2 + 75, 50)
end
