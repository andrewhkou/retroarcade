local fighter = require "fighter"
local fight = require "fight"

screenDimX = 1280;
screenDimY = 720;
local keymap1 = {up="w",down="s",left="a",right="d",punch="g"}
local keymap2 = {up="up",down="down",left="left",right="right",punch=";"}
fighter1 = Fighter.new("jon xu", 200, 400, keymap1, "right", screenDimX, 400)
fighter2 = Fighter.new("alan gill", 1000, 400, keymap2, "left", screenDimX, 400)

game = Fight.new(fighter1, fighter2)
isGoing = true

function love.load()
    love.window.setTitle("Street Fighter");
    love.window.setMode(screenDimX, screenDimY)
    love.graphics.setNewFont(40)
end

function love.update(dt) 
    if not isGoing then
        --mainmenu()
    else 
        game:applyDamage()
        if game.winner ~= 0 then
            isGoing = false
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
    love.graphics.reset()
    love.graphics.line(0, 600, screenDimX, 600)
    love.graphics.print(fighter1.health, screenDimX/2 - 100, 50)
    love.graphics.print(fighter2.health, screenDimX/2 + 75, 50)
    updateFighters()
    if not isGoing then
        love.graphics.print("Game Over", screenDimX/2, screenDimY/2)
    end

end

function updateFighters() 
    fighter1:update()
    fighter2:update()
end
