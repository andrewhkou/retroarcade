screenDimX = 1220;
screenDimY = 800;
totalTimeElapsed = 0;
highScore = 0;
score = 0;
score1 = 0;
score2 = 0;
timeElapsed = 0;
paddleSpeed = 5;
timeLimit = .1;

player1 = {
    points = 0;
}

player2 = {
    points = 0;
}

paddleWidth = 20
paddleHeight = 70

paddle1 = {
    x = 75,
    y = (screenDimY / 2) -  (paddleHeight / 2);
    vel= 0;
}

paddle2 = {
    x = screenDimX - 75 - paddleWidth,
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
    if paddle1.x + paddleWidth - ballXBorder(ball, "left") >= 0 and ball.y <= getPaddle1LowerY() and ball.y >= getPaddle1UpperY() + 2 then
        return true
    end
    return false
end

function detectPaddle2Collision(ball)
    if paddle2.x - ballXBorder(ball, "right") <= 0 and ball.y <= getPaddle2LowerY() and ball.y >= getPaddle2UpperY() + 2 then
        return true
    end
    return false
end

function resetBall1()
    ball.x = screenDimX/2
    ball.y = screenDimY/2
    ball.velX = 5
    ball.velY = 0
end

function resetBall2()
    ball.x = screenDimX/2
    ball.y = screenDimY/2
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
    mainMenu = true;
    mainMenuBack = false;
    mainMenuPNG = love.graphics.newImage("PongMenu.png")
    love.window.setTitle("Pong");
    love.window.setMode(screenDimX, screenDimY)
    love.graphics.setNewFont(40)
    font = love.graphics.newFont("VT323-Regular.ttf", 130);
    love.graphics.setFont(font);
    gameOver2PNG = love.graphics.newImage("GameOver2.png")

    function enterPressed()
        return love.keyboard.isDown("return")
    end

    function player1right()
        return love.keyboard.isDown("d")
    end

    function player2right()
        return love.keyboard.isDown("right")
    end 

    function player1left()
        return love.keyboard.isDown("a")
    end

    function player2left()
        return love.keyboard.isDown("left")
    end 

    function mainMenuOptions()
        if (player2right() or player1right()) then
            mainMenu = false;
            mainMenuBack = true;
        end
        if (player2left() or player1left()) then
            mainMenu = true;
            mainMenuBack = false;
        end
        if (enterPressed()) then
            if (mainMenu and not mainMenuBack) then
                mainMenu = false;
                newGame();
            end
            if (mainMenuBack) then 
                love.event.push("quit");
            end
        end
    end

    function newGame() 
        totalTimeElapsed = 0;
        score = 0;
        score1 = 0;
        score2 = 0;
        timeElapsed = 0;
        paddleSpeed = 5;
        gameOver2 = 0;

        player1 = {
            points = 0;
        }

        player2 = {
            points = 0;
        }
        paddle1 = {
            x = 75,
            y = (screenDimY / 2) -  (paddleHeight / 2);
            vel= 0;
        }
        
        paddle2 = {
            x = screenDimX - 75 - paddleWidth,
            y = (screenDimY / 2) -  (paddleHeight / 2), 
            vel = 0;
        }
        
        ball = {
            x = 0,
            y = 0,
            velX = 7,
            velY = -1,
            radius = 8
        }

        resetBall1();
    end

    function gameOverMenu()
        if (love.keyboard.isDown("return")) then
            start = true;
            newGame();
        end
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
    if player1.points == 10 or player2.points == 10 then
        ball.velX = 0
        ball.velY = 0
    end

    if ballXBorder(ball, "left") <= 0 then
        incrementPoints(player2)
        if player2.points == 10 then
            gameOver2 = 2
        end
        resetBall1()
    end

    if ballXBorder(ball, "right") >= screenDimX then
        incrementPoints(player1)
        if player1.points == 10 then
            gameOver2 = 1
        end
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

    -- handles main menu
    if (mainMenu) then
        ball.velX = 0;
        ball.velY = 0;
        if (timeElapsed > 2 * timeLimit) then
            mainMenuOptions();
            timeElapsed = 0;
        end
    end

end

function love.draw() 
    if (mainMenu) then
        love.graphics.setColor(1,1,1);
        love.graphics.draw(mainMenuPNG,0,0,0,1920/7680, 1200/4800);
        if (mainMenuBack) then
            love.graphics.rectangle("line", 1760, 1025, 160, 172);
        end
    end
    if (not mainMenu and not mainMenuBack) then
        love.graphics.line(screenDimX/2, screenDimY, screenDimX/2, 0)
        love.graphics.rectangle('fill', paddle1.x, paddle1.y, paddleWidth, paddleHeight)
        love.graphics.rectangle('fill', paddle2.x, paddle2.y, paddleWidth, paddleHeight)
        love.graphics.circle('fill', ball.x, ball.y, ball.radius)

        love.graphics.print(player1.points, screenDimX/2 - 100, 50)
        love.graphics.print(player2.points, screenDimX/2 + 75, 50)
    end
    if (gameOver2 == 1) then
        love.graphics.setColor(1, 1, 1);
        love.graphics.draw(gameOver2PNG, 0, 0)
        love.graphics.print("TWO", 910, 73);
        love.graphics.print(score1, 760, 995, 0, .5, .5);
        love.graphics.print(score2, 1500, 990, 0, .5, .5);
        love.graphics.rectangle("line", 1760, 1025, 160, 172)
        gameOverMenu();
    elseif (gameOver2 == 2) then
        love.graphics.setColor(1, 1, 1);
        love.graphics.draw(gameOver2PNG, 0, 0)
        love.graphics.print("ONE", 910, 73);
        love.graphics.print(score1, 760, 995, 0, .5, .5);
        love.graphics.print(score2, 1500, 990, 0, .5, .5);
        love.graphics.rectangle("line", 1760, 1025, 160, 172)
        gameOverMenu();
end
end
