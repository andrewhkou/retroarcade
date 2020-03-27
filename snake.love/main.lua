function love.load()
    screenDimX = 1280;
    screenDimY = 720;
    blockSize = 20;
    totalTimeElapsed = 0;
    highScore = 0;
    score = 0;
    love.window.setTitle("Snake");
    love.window.setMode(screenDimX, screenDimY)
    changeSpeed = false;

    function mainMenuOptions()
        if (love.keyboard.isDown(1)) then
            mainMenu = false;
            singlePlayer = true;
        elseif (love.keyboard.isDown(2)) then
            mainMenu = false;
            twoPlayer = true;
        end
    end

    function gameOverMenu()
        if (love.keyboard.isDown("space")) then
            newGame();
        end
    end

    function newGame()
        score = 0;
        snake1 = {
            {x = 0, y = 0},
            {x = 0, y = (1 * blockSize)},
            {x = 0, y = (2 * blockSize)},
            {x = 0, y = (3 * blockSize)},
            {x = 0, y = (4 * blockSize)},
        };
        snake2 = {
            {x = screenDimX - blockSize, y = 0},
            {x = screenDimX - blockSize, y = 2 * blockSize},
            {x = screenDimX - blockSize, y = 4 * blockSize},
            {x = screenDimX - blockSize, y = 6 * blockSize},
            {x = screenDimX - blockSize, y = 8 * blockSize},
        };
        direction1 = 3;
        direction2 = 3;
        speed = blockSize;
        mainMenu = true;
        gameOver = false;
        twoPlayer = false;
        singlePlayer = false;
        timeElapsed = 0;
        timeLimit = .1;
        numBlocksX = screenDimX / blockSize;
        numBlocksY = screenDimY / blockSize;
        foodX = math.random(170, numBlocksX - 1) * blockSize;
        foodY = math.random(60, numBlocksY - 1) * blockSize;
    end

    function eatenFood(snakeBody)
        if (snakeBody[1].x == foodX and snakeBody[1].y == foodY) then
            foodX = math.random(165, numBlocksX -1) * blockSize;
            foodY = math.random(60, numBlocksY -1) * blockSize;
            score = score + 1;
            highScore = math.max(score, highScore);
            return true;
        else
            return false;
        end
    end

    function keyboardPlayer1()
        if (love.keyboard.isDown("w")) then
            if (direction1 ~= 1) then
                direction1 = 3;
            end
        elseif (love.keyboard.isDown("d")) then
            if (direction1 ~= 4) then
                direction1 = 2;
            end
        elseif (love.keyboard.isDown("s")) then
            if (direction1 ~= 3) then
                direction1 = 1;
            end
        elseif (love.keyboard.isDown("a")) then
            if (direction1 ~= 2) then
                direction1 = 4;
            end
        end
    end

    function updateSnake1()
        currX = snake1[1].x;
        currY = snake1[1].y;

        if (direction1 == 1) then
            newY = currY + speed;
            if (newY > screenDimY - blockSize) then
                newY = 0;
            end
            table.insert(snake1, 1, {x = currX, y = newY});
        elseif (direction1 == 2) then
            newX = currX + speed;
            if (newX > screenDimX + blockSize) then
                newX = 0;
            end
            table.insert(snake1, 1, {x = newX, y = currY});
        elseif (direction1 == 3) then
            newY = currY - speed;
            if (newY < 0) then
                newY = screenDimY - blockSize;
            elseif (newY < 60 and currX < 170) then
                newY = screenDimY - blockSize;
            end
            table.insert(snake1, 1, {x = currX, y = newY});
        elseif (direction1 == 4) then
            newX = currX - speed;
            if (newX < 0) then
                newX = screenDimX + blockSize;
            elseif (newX < 170 and currY < 60) then
                newX = screenDimX + blockSize;
            end
            table.insert(snake1, 1, {x = newX, y = currY});
        end
        if (not eatenFood(snake1)) then
            table.remove(snake1);
        end
    end

    function collisionSingle()
        local nextX = snake1[1].x;
        local nextY = snake1[1].y;
        for index, place in ipairs(snake1) do
            xBoolean = place.x == nextX;
            yBoolean = place.y == nextY;
            if (xBoolean and yBoolean and index ~= 1) then
                return true;
            end
        end
        return false;
    end

    function collision(player1Snake, player2Snake)
        for a, i in ipairs(player1Snake) do
            for b, j in ipairs(player2Snake) do
                xBoolean = i.x == j.x;
                yBoolean = i.y == j.y;
                if (xBoolean and yBoolean) then
                    return true;
                end
            end
        end
        return false;
    end

    newGame()
end

function love.update(dt)
    timeElapsed = timeElapsed + dt;
    totalTimeElapsed = totalTimeElapsed + 1;
    if (math.fmod(score, 4) == 3) then
        changeSpeed = true;
    elseif (math.fmod(score, 4) == 0 and score ~= 0 and changeSpeed == true) then
        timeLimit = timeLimit -.007;
        changeSpeed = false;
    end

    if (mainMenu) then
        mainMenuOptions()
    elseif (singlePlayer) then
        if (timeElapsed > timeLimit) then
                keyboardPlayer1();
                updateSnake1();
                if (collisionSingle()) then
                    singlePlayer = false;
                    gameOver = true;
                end
            timeElapsed = 0;
        end
    elseif (twoPlayer) then
    end
end

function love.draw()
    --THIS IS THE MAIN MENU. WE SHOULD HAVE RULES AND OPTIONS TO PLAY
    if (mainMenu) then
        love.graphics.setColor(.36, 0, 0);
        love.graphics.rectangle('fill', 0, 0, screenDimX, screenDimY);
        love.graphics.setColor(.82, .57, 0);
        love.graphics.print("use WASD to move. press 1 to start single player, 2 to start two player", screenDimX/2 - 500, screenDimY/2 - 200, 0, 5);
        love.graphics.print("we need a better design lol", screenDimX/2 - 500, screenDimY/2 - 100, 0, 5);

    --Single Player Mode
    elseif (singlePlayer) then
        love.graphics.setColor(.82, .57, 0);
        love.graphics.rectangle('fill', 0, 0, screenDimX, screenDimY);
        love.graphics.setColor(.5, 0, 1);
        love.graphics.rectangle('fill', foodX, foodY, blockSize, blockSize);
        love.graphics.setColor(1, 1, 1);
        love.graphics.rectangle('fill', 0, 0, 170, 60);
        love.graphics.setColor(.36, 0, 0);
        love.graphics.print("Your score: "..tostring(score), 0, 0, 0, 2);
        love.graphics.print("High score: "..tostring(highScore), 0, 25, 0, 2);
        for index, array in ipairs(snake1) do
            love.graphics.setColor(.36, 0, 0);
            love.graphics.rectangle('fill', array.x, array.y, blockSize, blockSize);
        end
    elseif (twoPlayer) then
    elseif (gameOver) then
        love.graphics.setColor(.5, 0, 1);
        love.graphics.rectangle('fill', 0, 0, screenDimX, screenDimY);
        love.graphics.setColor(.36, 0, 0);
        love.graphics.print("YOU LOST", screenDimX/2 - 200, screenDimY/2 - 300, 0, 5);
        love.graphics.print("Your score: "..tostring(score), screenDimX/2 - 200, screenDimY/2 - 240, 0, 5);
        love.graphics.print("High score: "..tostring(highScore), screenDimX/2 - 200, screenDimY/2 - 180, 0, 5);
        love.graphics.print("Press space to get back to main screen", screenDimX/2 - 600, screenDimY/2 - 120, 0, 5);
        gameOverMenu();
    end
end
