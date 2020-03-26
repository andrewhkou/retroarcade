function love.load()
    screenDimX = 1280;
    screenDimY = 720;
    blockSize = 20;
    mainMenu = true;
    gameOver = false;
    twoPlayer = false;
    singlePlayer = false;

    love.window.setTitle("Snake");
    love.window.setMode(screenDimX, screenDimY)

    function mainMenuOptions()
        if (love.keyboard.isDown(1)) then
            mainMenu = false;
            singlePlayer = true;
        elseif (love.keyboard.isDown(2)) then
            mainMenu = false;
            twoPlayer = true;
        end
    end

    function newGame()
        snake1 = {
            {x = 0, y = 0},
            {x = 0, y = (2 * blockSize)},
            {x = 0, y = (4 * blockSize)},
            {x = 0, y = (6 * blockSize)},
            {x = 0, y = (8 * blockSize)},
        };
        snake2 = {
            {x = screenDimX - blockSize, y = 0},
            {x = screenDimX - blockSize, y = blockSize},
            {x = screenDimX - blockSize, y = 2 * blockSize},
            {x = screenDimX - blockSize, y = 3 * blockSize},
            {x = screenDimX - blockSize, y = 4 * blockSize},
        };
        direction1 = 3;
        direction2 = 3;
        speed = 1;
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
            end
            table.insert(snake1, 1, {x = currX, y = newY});
        elseif (direction1 == 4) then
            newX = currX - speed;
            if (newX < 0) then
                newX = screenDimX + blockSize;
            end
            table.insert(snake1, 1, {x = newX, y = currY});
        end
        table.remove(snake1);
    end

    function collision(player1Snake, player2Snake)
        for i in pairs(player1Snake) do
            for j in pairs(player2Snake) do
                xBoolean = math.abs(player1Snake[i].x - player2Snake[j].x) <= 5;
                yBoolean = math.abs(player1Snake[i].y - player2Snake[j].y) <= 5;
                if (xBoolean or yBoolean) then
                    if (i == j and player1Snake == player2Snake) then
                    else
                        return true;
                    end
                end
            end
        end
        return false;
    end 
    
    newGame()
end

function love.update(dt)
    if (mainMenu) then
        mainMenuOptions()
    elseif (singlePlayer) then
        keyboardPlayer1();
        updateSnake1();
        --if (collision(snake1, snake1)) then
          --  singlePlayer = false;
            --gameOver = true;
        --end
    elseif (twoPlayer) then
    elseif (gameover) then
        print("game over");
        if (love.keyboard.isDown("space")) then
            singlePlayer = true;
            gameOver = false;
        end
    end

end

function love.draw()

    if (mainMenu) then
        love.graphics.setColor(.36, 0, 0);
        love.graphics.rectangle('fill', 0, 0, screenDimX, screenDimY);
        --THIS IS THE MAIN MENU. WE SHOULD HAVE RULES AND OPTIONS TO PLAY
    elseif (singlePlayer) then
        love.graphics.setColor(.82, .57, 0);
        love.graphics.rectangle('fill', 0, 0, screenDimX, screenDimY);
        for index, array in ipairs(snake1) do
            love.graphics.setColor(.36, 0, 0);
            love.graphics.rectangle('fill', array.x, array.y, blockSize, blockSize);
        end
    elseif (twoPlayer) then
    elseif (gameOver) then
    end
end

