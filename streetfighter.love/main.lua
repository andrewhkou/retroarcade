local fighter = require "fighter"
local fight = require "fight"

screenDimX = 1280;
screenDimY = 720;
local keymap1 = {up="w",down="s",left="a",right="d",punch="g"}
local keymap2 = {up="up",down="down",left="left",right="right",punch=";"}

player1Stance1right = love.graphics.newImage("ryanstance1.png")
player1Stance2right = love.graphics.newImage("ryanstance2.png")
player1Punchright = love.graphics.newImage("ryanpunch.png")
player1Stance1left = love.graphics.newImage("ryanstance1left.png")
player1Stance2left = love.graphics.newImage("ryanstance2left.png")
player1Punchleft = love.graphics.newImage("ryan1punchleft.png")

player2Stance1right = love.graphics.newImage("alexstance1right.png")
player2Stance2right = love.graphics.newImage("alexstance2right.png")
player2Punchright = love.graphics.newImage("alexpunchright.png")
player2Stance1left = love.graphics.newImage("alexstance1left.png")
player2Stance2left = love.graphics.newImage("alexstance2left.png")
player2Punchleft = love.graphics.newImage("alexpunchleft.png")

player1Anims = {
    stance1right = player1Stance1right,
    stance2right = player1Stance2right,
    punchright = player1Punchright,
    stance1left = player1Stance1left,
    stance2left = player1Stance2left,
    punchleft = player1Punchleft
}

player2Anims = {
    stance1right = player2Stance1right,
    stance2right = player2Stance2right,
    punchright = player2Punchright,
    stance1left = player2Stance1left,
    stance2left = player2Stance2left,
    punchleft = player2Punchleft
}

fighter1 = Fighter.new("jon xu", 200, 450, keymap1, "right", screenDimX, 450, player1Anims,1, screenDimX)
fighter2 = Fighter.new("alan gill", 1000, 450, keymap2, "left", screenDimX, 450, player2Anims,2, screenDimX)


game = Fight.new(fighter1, fighter2)
isGoing = true

function love.load()
    love.window.setTitle("Street Fighter");
    love.window.setMode(screenDimX, screenDimY)
    love.graphics.setNewFont(40)
    mainMenu = true;
end

function newGame()
    screenDimX = 1280;
    screenDimY = 720;
    player1Stance1right = love.graphics.newImage("ryanstance1.png")
    player1Stance2right = love.graphics.newImage("ryanstance2.png")
    player1Punchright = love.graphics.newImage("ryanpunch.png")
    player1Stance1left = love.graphics.newImage("ryanstance1left.png")
    player1Stance2left = love.graphics.newImage("ryanstance2left.png")
    player1Punchleft = love.graphics.newImage("ryan1punchleft.png")

    player2Stance1right = love.graphics.newImage("alexstance1right.png")
    player2Stance2right = love.graphics.newImage("alexstance2right.png")
    player2Punchright = love.graphics.newImage("alexpunchright.png")
    player2Stance1left = love.graphics.newImage("alexstance1left.png")
    player2Stance2left = love.graphics.newImage("alexstance2left.png")
    player2Punchleft = love.graphics.newImage("alexpunchleft.png")

    player1Anims = {
        stance1right = player1Stance1right,
        stance2right = player1Stance2right,
        punchright = player1Punchright,
        stance1left = player1Stance1left,
        stance2left = player1Stance2left,
        punchleft = player1Punchleft
    }

    player2Anims = {
        stance1right = player2Stance1right,
        stance2right = player2Stance2right,
        punchright = player2Punchright,
        stance1left = player2Stance1left,
        stance2left = player2Stance2left,
        punchleft = player2Punchleft
    }

    fighter1 = Fighter.new("jon xu", 200, 450, keymap1, "right", screenDimX, 450, player1Anims,1, screenDimX)
    fighter2 = Fighter.new("alan gill", 1000, 450, keymap2, "left", screenDimX, 450, player2Anims,2, screenDimX)


    game = Fight.new(fighter1, fighter2)
    mainMenu = true
    isGoing = true
end

function mainMenuOptions()
    if love.keyboard.isDown("return") then
        mainMenu = false
    end
end

function gameOverMenu()
    if (love.keyboard.isDown('return')) then
        newGame();
    end
end

function love.update(dt)
    if mainMenu then
        mainMenuOptions()
    else
        if isGoing then
            fighter1:checkCollisionRight(fighter2)
            fighter1:checkCollisionLeft(fighter2)
            fighter2:checkCollisionRight(fighter1)
            fighter2:checkCollisionLeft(fighter1)
            game:applyDamage()
            if game.winner ~= 0 then
                isGoing = false
            end
        end
    end
end

function love.keypressed(key, unicode)
    fighter1:keypressed(key)
    fighter2:keypressed(key)

    -- if key == "escape" then
    --     love.event.push("quit")
    -- end
end

function love.draw()
    love.graphics.setNewFont(40)
    if mainMenu then
        love.graphics.setColor(0,0,0);
        love.graphics.rectangle("fill", 0, 0, screenDimX, screenDimY)
        love.graphics.setColor(.36, 0, 0);
        love.graphics.print("Press Enter to Start", screenDimX/2, screenDimY/2)
    elseif isGoing then
        love.graphics.reset()
        love.graphics.line(0, 600, screenDimX, 600)
        -- health bars
        love.graphics.print("PLAYER 1", 50, 22)
        love.graphics.rectangle('fill', 50, 50, (screenDimX / 2 - 100) * (fighter1.health/100), 30)
        love.graphics.print("HP: " .. fighter1.health, 50, 90)

        love.graphics.print("PLAYER 2", screenDimX - 110, 22)
        love.graphics.rectangle('fill', screenDimX / 2 + 50 + (screenDimX / 2 - 100) * (1 - (fighter2.health/100)), 50, (screenDimX / 2 - 100) - (screenDimX / 2 - 100) * (1 - (fighter2.health/100)), 30)
        love.graphics.print("HP: " .. fighter2.health, screenDimX - 100, 90)

        updateFighters()
    else
        love.graphics.setColor(0,0,0);
        love.graphics.rectangle("fill", 0, 0, screenDimX, screenDimY)
        love.graphics.setColor(.36, 0, 0);
        love.graphics.print("Game Over", screenDimX/2, screenDimY/2 - 100)
        love.graphics.print("Player " .. game.winner .. " Wins", screenDimX/2, screenDimY/2)
        gameOverMenu()
    end

end

function updateFighters()
    fighter1:update()
    fighter2:update()
end
