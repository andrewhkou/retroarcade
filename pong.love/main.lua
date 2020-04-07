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

    paddlex1 = 50
    paddley1 = (screenDimY / 2) -  (paddleHeight / 2)

    paddlex2 = screenDimX - 50 - paddleWidth
    paddley2 = (screenDimY / 2) -  (paddleHeight / 2)

    love.window.setTitle("Pong");
    love.window.setMode(screenDimX, screenDimY)
end

function love.update(dt) 
    timeElapsed = timeElapsed + dt;
    totalTimeElapsed = totalTimeElapsed + 1;
    if love.keyboard.isDown('w') and paddley1 > 0 then
        paddley1 = paddley1 - paddleSpeed
    end
    if love.keyboard.isDown('s') and (paddley1 + paddleHeight) < screenDimY then
        paddley1 = paddley1 + paddleSpeed 
    end
    if love.keyboard.isDown('up') and paddley2 > 0 then
        paddley2 = paddley2 - paddleSpeed
    end
    if love.keyboard.isDown('down') and (paddley2 + paddleHeight) < screenDimY then
        paddley2 = paddley2 + paddleSpeed
    end
end

function love.draw() 
    love.graphics.line(screenDimX/2, screenDimY, screenDimX/2, 0)
    love.graphics.rectangle('fill', paddlex1, paddley1, paddleWidth, paddleHeight)
    love.graphics.rectangle('fill', paddlex2, paddley2, paddleWidth, paddleHeight)
end
