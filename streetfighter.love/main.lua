local fighter = require "fighter"
local fight = require "fight"
require "joystick"

onComputer = false;
totalTimeElapsed = 0;
screenDimX = 1920;
screenDimY = 1200;
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

homescreen = love.graphics.newImage("streetfighterhome.png")
helpscreen = love.graphics.newImage("streetfighterhelp.png")
background = love.graphics.newImage("background.png")
gameover = love.graphics.newImage("gameover.png")

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

fighter1 = Fighter.new("jon xu", 320, 800, keymap1, "right", screenDimX, 800, player1Anims,1, screenDimX, false, false, false, false)
fighter2 = Fighter.new("alan gill", 1620, 800, keymap2, "left", screenDimX, 800, player2Anims,2, screenDimX, false, false, false, false)


game = Fight.new(fighter1, fighter2)
isGoing = true

function love.load()
    timeLimit = .1;
    love.window.setTitle("Street Fighter");
    love.window.setMode(screenDimX, screenDimY)
    love.graphics.setNewFont(40)
    mainMenu = true;
    mainMenuHelp = false;
    mainMenuPlay = true;
end

function newGame()
    fighter1.x = 320
    fighter1.y = 800
    fighter1.health = 100
    fighter1.direction = "right"

    fighter2.x = 1620
    fighter2.y = 800
    fighter2.health = 100
    fighter2.direction = "left"

    game = Fight.new(fighter1, fighter2)
    mainMenu = true
    mainMenuPlay = true
    mainMenuHelp = false
    displayHelp = false
    isGoing = false
end

function love.update(dt)
    totalTimeElapsed = totalTimeElapsed + dt;
    if (totalTimeElapsed > 2 * timeLimit) then
        totalTimeElapsed = 0;
        if displayHelp then
            if selectPressed1() then
                displayHelp = false
            end
        elseif mainMenu then 
            if mainMenuPlay then
                if selectPressed1() then
                    mainMenu = false
                    isGoing = true
                end
            elseif mainMenuHelp then
                if selectPressed1() then
                    displayHelp = true
                end
            elseif not isGoing then
                if selectPressed1() then
                    newGame()
                end
            end
        elseif mainMenu and notDisplayHelp and joystick1Right() then
            mainMenuHelp = true
            mainMenuPlay = false
        elseif mainMenu and notDisplayHelp and joystick1Left() then
            mainMenuHelp = false
            mainMenuPlay = true
        end
        if not mainMenu then
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
end

function love.keypressed(key, unicode)
    fighter1:keypressed(key)
    fighter2:keypressed(key)

    if key == "return" then
        if displayHelp then
            displayHelp = false
        elseif mainMenu then
            if mainMenuPlay then
                mainMenu = false
                isGoing = true
            elseif mainMenuHelp then
                displayHelp = true
            end
        elseif not isGoing then
            newGame()
        end
    elseif key == "d" and mainMenu and not DisplayHelp then
        mainMenuHelp = true
        mainMenuPlay = false
    elseif key == "a" and mainMenu and not DisplayHelp then
        mainMenuHelp = false
        mainMenuPlay = true
    end
end

function love.draw()
    love.graphics.setNewFont(40)
    if mainMenu then
        if displayHelp then 
            love.graphics.draw(helpscreen,0,0)
            love.graphics.setLineWidth(10)
            love.graphics.rectangle("line", 1772, 1052, 122, 118, 0, 0);
        else
            love.graphics.draw(homescreen,0,0);
            love.graphics.setLineWidth(10)
            if mainMenuPlay then
                love.graphics.rectangle("line", 693, 940, 577, 150, 75, 75);
            elseif mainMenuHelp then 
                love.graphics.rectangle("line", 1772, 1052, 122, 118, 0, 0);
            end
        end
    elseif isGoing then
        love.graphics.reset()
        -- love.graphics.line(0, 600, screenDimX, 600)
        -- health bars
        love.graphics.draw(background,0,0);
        -- love.graphics.rectangle('fill', 0, 0, screenDimX, 150)
        love.graphics.setNewFont(25)
        love.graphics.print("PLAYER 1", 50, 22)
        love.graphics.rectangle('fill', 50, 60, (screenDimX / 2 - 100) * (fighter1.health/100), 60)
        love.graphics.print("HP: " .. fighter1.health, 50, 130)

        love.graphics.print("PLAYER 2", screenDimX - 165, 22)
        love.graphics.rectangle('fill', screenDimX / 2 + 50 + (screenDimX / 2 - 100) * (1 - (fighter2.health/100)), 60, (screenDimX / 2 - 100) - (screenDimX / 2 - 100) * (1 - (fighter2.health/100)), 60)
        love.graphics.print("HP: " .. fighter2.health, screenDimX - 150, 130)

        updateFighters()
    else
        font = love.graphics.newFont("VT323-Regular.ttf", 200);
        love.graphics.setFont(font);
        love.graphics.draw(gameover,0,0);
        love.graphics.print("PLAYER " .. game.winner .. " WINS", screenDimX/2 - 590, screenDimY/2)
        love.graphics.setLineWidth(10)
        love.graphics.rectangle("line", 1772, 1052, 122, 118, 0, 0);
    end

end

function updateFighters()
    fighter1:update()
    fighter2:update()
    updateJoysticks()
end


function updateJoysticks() 
    if joystick1Left() then
        fighter1.joystickLeft = true
    else
        fighter1.joystickLeft = false
    end
    if joystick1Right() then
        fighter1.joystickRight = true
    else
        fighter1.joystickRight = false
    end
    if joystick1Up() then
        fighter1.joystickUp = true
    else
        fighter1.joystickUp = false
    end
    if joystick1Down() then
        fighter1.joystickDown = true
    else
        fighter1.joystickDown = false
    end

    if joystick2Left() then
        fighter2.joystickLeft = true
    else
        fighter2.joystickLeft = false
    end
    if joystick2Right() then
        fighter2.joystickRight = true
    else
        fighter2.joystickRight = false
    end
    if joystick2Up() then
        fighter2.joystickUp = true
    else
        fighter2.joystickUp = false
    end
    if joystick2Down() then
        fighter2.joystickDown = true
    else
        fighter2.joystickDown = false
    end
end
