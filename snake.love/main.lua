function love.load()
    mainMenuPNG = love.graphics.newImage("Snake_Main_Menu.png")
    gameMenu1PNG = love.graphics.newImage("Game_Screen_1.png")
    gameMenu2PNG = love.graphics.newImage("Game_Screen_2.png")
    gameOver1PNG = love.graphics.newImage("GameOver1.png")
    gameOver2PNG = love.graphics.newImage("GameOver2.png")
    font = love.graphics.newFont("VT323-Regular.ttf", 130);
    love.graphics.setFont(font);
    screenDimX = 1920;
    screenDimY = 1200;
    blockSize = 20;
    totalTimeElapsed = 0;
    highScore = 0;
    score = 0;
    score1 = 0;
    score2 = 0;
    love.window.setTitle("Snake");
    love.window.setMode(screenDimX, screenDimY)
    changeSpeed = false;
    up1 = "w";
    right1 = "d";
    down1 = "s";
    left1 = "a";
    up2 = "up";
    right2 = "right";
    down2 = "down";
    left2 = "left";
    enter = "return"
    joysticks = love.joystick.getJoysticks();
    if (#joysticks > 1) then
        joystick1 = joysticks[0];
        joystick2 = joystick[1];
    end
    mainMenuHelp = false;
    mainMenuSingle = true;
    mainMenuTwo = false;
    mainMenuBack = false;

    function joystick1Up()
        if (#joysticks > 1) then
            if (joystick1.getAxis(1) > .3) then
                return true;
            end
        end
        return false;
    end

    function joystick1Down()
        if (#joysticks > 1) then
            if (joystick1.getAxis(1) < -.3) then
                return true;
            end
        end
        return false;
    end

    function joystick1Left()
        if (#joysticks > 1) then
            if (joystick1.getAxis(2) < -.3) then
                return true;
            end
        end
        return false;
    end

    function joystick1Right()
        if (#joysticks > 1) then
            if (joystick1.getAxis(2) > .3) then
                return true;
            end
        end
        return false;
    end

    function mainMenuOptions()
        if (mainMenuSingle) then
            if (love.keyboard.isDown(down1) or joystick1Down()) then
                mainMenuSingle = false;
                mainMenuTwo = true;
            end
        elseif (mainMenuTwo) then
            if (love.keyboard.isDown(up1) or joystick1Up()) then
                mainMenuSingle = true;
                mainMenuTwo = false;
            elseif (love.keyboard.isDown(left1) or joystick1Left()) then
                mainMenuHelp = true;
                mainMenuTwo = false;
            elseif (love.keyboard.isDown(right1) or joystick1Right()) then
                mainMenuTwo = false;
                mainMenuBack = true;
            end
        elseif (mainMenuHelp) then
            if (love.keyboard.isDown(right1) or joystick1Right()) then
                mainMenuHelp = false;
                mainMenuTwo = true;
            end
        elseif (mainMenuBack) then
            if (love.keyboard.isDown(left1) or joystick1Left()) then
                mainMenuBack = false;
                mainMenuTwo = true;
            end
        end
        if (love.keyboard.isDown(enter)) then
            if (mainMenuSingle) then
                singlePlayer = true;
            elseif (mainMenuTwo) then
                twoPlayer = true;
            elseif (mainMenuBack) then
                -- ANDRE DO THIS LOL
            elseif (mainMenuHelp) then
                -- HELP MENU
            end
            mainMenu = false;
        end
    end

    function gameOverMenu()
        if (love.keyboard.isDown(enter)) then
            start = true;
            newGame();
        end
    end

    function newGame()
        score = 0;
        score1 = 0;
        score2 = 0;
        snake1 = {
            {x = 100, y = 0},
            {x = 100, y = 1 * blockSize},
            {x = 100, y = 2 * blockSize},
            {x = 100, y = 3 * blockSize},
            {x = 100, y = 4 * blockSize},
        };
        snake2 = {
            {x = screenDimX - blockSize - 80, y = 0},
            {x = screenDimX - blockSize - 80, y = 1 * blockSize},
            {x = screenDimX - blockSize - 80, y = 2 * blockSize},
            {x = screenDimX - blockSize - 80, y = 3 * blockSize},
            {x = screenDimX - blockSize - 80, y = 4 * blockSize},
        };
        direction1 = 3;
        direction2 = 3;
        speed = blockSize;
        mainMenu = true;
        gameOver1 = false;
        gameOver2 = 0;
        twoPlayer = false;
        singlePlayer = false;
        timeElapsed = 0;
        timeLimit = .1;
        numBlocksX = screenDimX / blockSize;
        numBlocksY = screenDimY / blockSize;
        foodX = math.random(9, numBlocksX - 1) * blockSize;
        foodY = math.random(3, numBlocksY - 1) * blockSize;
        mainMenuHelp = false;
        mainMenuSingle = true;
        mainMenuTwo = false;
        mainMenuBack = false;
        while (foodX == snake1[1].x)
        do
          foodX = math.random(9, numBlocksX - 1) * blockSize;
        end
        while (foodY == snake1[1].y)
        do
          foodY = math.random(3, numBlocksY - 1) * blockSize;
        end
    end

    function eatenFood(snakeBody, num)
        if (snakeBody[1].x == foodX and snakeBody[1].y == foodY) then
            if (singlePlayer) then
                foodX = math.random(9, numBlocksX - 1) * blockSize;
                foodY = math.random(3, numBlocksY - 1) * blockSize;
            elseif (twoPlayer) then
                foodX = math.random(1, numBlocksX - 1) * blockSize;
                foodY = math.random(1, numBlocksY - 1) * blockSize;
                while (foodX > screenDimX/2 - 100 and foodX < screenDimX/2 + 100 and foodY < 60)
                do
                  foodX = math.random(1, numBlocksX - 1) * blockSize;
                  foodY = math.random(1, numBlocksY - 1) * blockSize;
                end
            end
            score = score + 1;
            if (num == 1) then
                score1 = score1 + 1;
            elseif (num == 2) then
                score2 = score2 + 1;
            end
            highScore = math.max(score, highScore);
            return true;
        else
            return false;
        end
    end

    function keyboardPlayer1()
        if (love.keyboard.isDown(up1) or (joystick1Up())) then
            if (direction1 ~= 1) then
                direction1 = 3;
            end
        elseif (love.keyboard.isDown(right1) or joystick1Right()) then
            if (direction1 ~= 4) then
                direction1 = 2;
            end
        elseif (love.keyboard.isDown(down1) or joystick1Down()) then
            if (direction1 ~= 3) then
                direction1 = 1;
            end
        elseif (love.keyboard.isDown(left1) or joystick1Left()) then
            if (direction1 ~= 2) then
                direction1 = 4;
            end
        end
    end

    function keyboardPlayer2()
        if (love.keyboard.isDown(up2)) then
            if (direction2 ~= 1) then
                direction2 = 3;
            end
        elseif (love.keyboard.isDown(right2)) then
            if (direction2 ~= 4) then
                direction2 = 2;
            end
        elseif (love.keyboard.isDown(down2)) then
            if (direction2 ~= 3) then
                direction2 = 1;
            end
        elseif (love.keyboard.isDown(left2)) then
            if (direction2 ~= 2) then
                direction2 = 4;
            end
        end
    end

    function updateSnake1()
        currX = snake1[1].x;
        currY = snake1[1].y;
        -- should prolly change this but ill do it later
        if (singlePlayer) then
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
        elseif (twoPlayer) then
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
                elseif (newX < screenDimX/2 + 80 and newX > screenDimX/2 - 120 and currY < 60) then
                    newX = screenDimX/2 + 100;
                end
                table.insert(snake1, 1, {x = newX, y = currY});
            elseif (direction1 == 3) then
                newY = currY - speed;
                if (newY < 0) then
                    newY = screenDimY - blockSize;
                elseif (newY < 60 and currX < screenDimX/2 + 100 and currX > screenDimX/2 - 100) then
                    newY = screenDimY - blockSize;
                end
                table.insert(snake1, 1, {x = currX, y = newY});
            elseif (direction1 == 4) then
                newX = currX - speed;
                if (newX < 0) then
                    newX = screenDimX + blockSize;
                elseif (newX < screenDimX/2 + 100 and newX > screenDimX/2 - 120 and currY < 60) then
                    newX = screenDimX/2 - 100 - blockSize;
                end
                table.insert(snake1, 1, {x = newX, y = currY});
            end
        end
        if (not eatenFood(snake1, 1)) then
            table.remove(snake1);
        end
    end
    function updateSnake2()
        currX = snake2[1].x;
        currY = snake2[1].y;
        if (singlePlayer) then
            if (direction2 == 1) then
                newY = currY + speed;
                if (newY > screenDimY - blockSize) then
                    newY = 0;
                end
                table.insert(snake2, 1, {x = currX, y = newY});
            elseif (direction2 == 2) then
                newX = currX + speed;
                if (newX > screenDimX + blockSize) then
                    newX = 0;
                end
                table.insert(snake2, 1, {x = newX, y = currY});
            elseif (direction2 == 3) then
                newY = currY - speed;
                if (newY < 0) then
                    newY = screenDimY - blockSize;
                elseif (newY < 60 and currX < 170) then
                    newY = screenDimY - blockSize;
                end
                table.insert(snake2, 1, {x = currX, y = newY});
            elseif (direction2 == 4) then
                newX = currX - speed;
                if (newX < 0) then
                    newX = screenDimX + blockSize;
                elseif (newX < 170 and currY < 60) then
                    newX = screenDimX + blockSize;
                end
                table.insert(snake2, 1, {x = newX, y = currY});
            end
        elseif (twoPlayer) then
            if (direction2 == 1) then
                newY = currY + speed;
                if (newY > screenDimY - blockSize) then
                    newY = 0;
                end
                table.insert(snake2, 1, {x = currX, y = newY});
            elseif (direction2 == 2) then
                newX = currX + speed;
                if (newX > screenDimX + blockSize) then
                    newX = 0;
                elseif (newX < screenDimX/2 + 80 and newX > screenDimX/2 - 120 and currY < 60) then
                    newX = screenDimX/2 + 100;
                end
                table.insert(snake2, 1, {x = newX, y = currY});
            elseif (direction2 == 3) then
                newY = currY - speed;
                if (newY < 0) then
                    newY = screenDimY - blockSize;
                elseif (newY < 60 and currX < screenDimX/2 + 100 and currX > screenDimX/2 - 100) then
                    newY = screenDimY - blockSize;
                end
                table.insert(snake2, 1, {x = currX, y = newY});
            elseif (direction2 == 4) then
                newX = currX - speed;
                if (newX < 0) then
                    newX = screenDimX + blockSize;
                elseif (newX < screenDimX/2 + 100 and newX > screenDimX/2 - 120 and currY < 60) then
                    newX = screenDimX/2 - 100 - blockSize;
                end
                table.insert(snake2, 1, {x = newX, y = currY});
            end
        end
        if (not eatenFood(snake2, 2)) then
            table.remove(snake2);
        end
    end

    function collisionSingle(snakeBody)
        local nextX = snakeBody[1].x;
        local nextY = snakeBody[1].y;
        for index, place in ipairs(snake1) do
            xBoolean = place.x == nextX;
            yBoolean = place.y == nextY;
            if (xBoolean and yBoolean and index ~= 1) then
                return true;
            end
        end
        return false;
    end

    function collisionTwoPlayer(snakeBody, num)
        local nextX = snakeBody[1].x;
        local nextY = snakeBody[1].y;
        for index, place in ipairs(snakeBody) do
            xBoolean = place.x == nextX;
            yBoolean = place.y == nextY;
            if (xBoolean and yBoolean and index ~= 1) then
                return num;
            end
        end
        return 0;
    end

    function collision(player1Snake, player2Snake)
        for a, i in ipairs(player1Snake) do
            if (player2Snake[1].x == i.x and player2Snake[1].y == i.y) then
              return 2;
            end
        end
        for a, j in ipairs(player2Snake) do
            if (player1Snake[1].x == j.x and player1Snake[1].y == j.y) then
              return 1;
            end
        end
    end
    newGame();
end

function love.update(dt)
    if (love.keyboard.isDown('escape')) then
        love.event.push("quit");
    end
    timeElapsed = timeElapsed + dt;
    totalTimeElapsed = totalTimeElapsed + 1;
    if (singlePlayer) then
        if (math.fmod(score, 4) == 3) then
            changeSpeed = true;
        elseif (math.fmod(score, 4) == 0 and score ~= 0 and changeSpeed == true) then
            timeLimit = timeLimit -.005;
            if (timeLimit < 0.05) then
              timeLimit = 0.05
              changeSpeed = false;
            end
        end
    elseif (twoPlayer) then
      if (math.fmod(score, 8) == 7) then
          changeSpeed = true;
      elseif (math.fmod(score, 8) == 0 and score ~= 0 and changeSpeed == true) then
          timeLimit = timeLimit -.005;
          if (timeLimit < 0.05) then
            timeLimit = 0.05
            changeSpeed = false;
          end
      end
    end
    if (mainMenu) then
        if (timeElapsed > timeLimit) then
            mainMenuOptions();
            timeElapsed = 0;
        end
    elseif (singlePlayer) then
        if (timeElapsed > timeLimit) then
            keyboardPlayer1();
            updateSnake1();
            if (collisionSingle(snake1)) then
                singlePlayer = false;
                gameOver1 = true;
            end
            timeElapsed = 0;
        end
    elseif (twoPlayer) then
      if (timeElapsed > timeLimit) then
            keyboardPlayer1();
            updateSnake1();
            keyboardPlayer2();
            updateSnake2();
            loserSelf1 = collisionTwoPlayer(snake1, 1);
            loserSelf2 = collisionTwoPlayer(snake2, 2);
            loserCollide = collision(snake1, snake2);
            if (loserSelf1 == 1) then
                twoPlayer = false;
                gameOver2 = 1;
            elseif (loserSelf2 == 2) then
                twoPlayer = false;
                gameOver2 = 2;
            elseif (loserCollide == 1) then
                twoPlayer = false;
                gameOver2 = 1;
            elseif (loserCollide == 2) then
                twoPlayer = false;
                gameOver2 = 2;
            end
            timeElapsed = 0;
      end
    end
end

function love.draw()
    --THIS IS THE MAIN MENU. WE SHOULD HAVE RULES AND OPTIONS TO PLAY
    if (mainMenu) then
        love.graphics.setLineWidth(10)
        love.graphics.setColor(1,1,1);
        love.graphics.draw(mainMenuPNG,0,0);
        if (mainMenuSingle) then
            love.graphics.rectangle("line", 433, 623, 1040.38, 179.64)
        elseif (mainMenuTwo) then
            love.graphics.rectangle("line", 433, 856, 1040.38, 179.64)
        elseif (mainMenuHelp) then
            love.graphics.circle("line", 70, 1089+35, 50)
        elseif (mainMenuBack) then
            love.graphics.rectangle("line", 1760, 1025, 160, 172)
        end
    --Single Player Mode
    elseif (singlePlayer) then
        love.graphics.setColor(1,1,1);
        love.graphics.draw(gameMenu1PNG,0,0)
        love.graphics.setColor(.5, 0, 1);
        love.graphics.rectangle('fill', foodX, foodY, blockSize, blockSize);
        love.graphics.setColor(1, 1, 1);
        love.graphics.print(score, 225, 34, 0, .5, .5);
        for index, array in ipairs(snake1) do
            love.graphics.setColor(0, 0, 0);
            love.graphics.rectangle('fill', array.x, array.y, blockSize, blockSize);
        end
    elseif (twoPlayer) then
        love.graphics.setColor(1, 1, 1);
        love.graphics.draw(gameMenu2PNG, 0, 0);
        love.graphics.setColor(.5, 0, 1);
        love.graphics.rectangle('fill', foodX, foodY, blockSize, blockSize);
        love.graphics.setColor(.36, 0, 0);
        love.graphics.print(score1, 450, 36, 0, .5, .5);
        love.graphics.setColor(.82, .57, 0);
        love.graphics.print(score2, 450, 126, 0, .5, .5);
        for index, array in ipairs(snake1) do
            love.graphics.setColor(.36, 0, 0);
            love.graphics.rectangle('fill', array.x, array.y, blockSize, blockSize);
        end
        for index, array in ipairs(snake2) do
            love.graphics.setColor(.82, .57, 0);
            love.graphics.rectangle('fill', array.x, array.y, blockSize, blockSize);
        end
    elseif (gameOver1) then
        love.graphics.setColor(1, 1, 1);
        love.graphics.draw(gameOver1PNG, 0, 0);
        love.graphics.print(score, 975, 110, 0, .7, .7)
        love.graphics.rectangle("line", 1760, 1025, 160, 172)
        gameOverMenu();
    elseif (gameOver2 == 1) then
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
