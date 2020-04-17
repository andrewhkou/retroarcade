local fighter = require "fighter"

screenDimX = 1280;
screenDimY = 720;
local keymap1 = {up="w",down="s",left="a",right="d",punch="g"}
local keymap2 = {up="up",down="down",left="left",right="right",punch=";"}
fighter1 = Fighter.new("jon xu", 200, 400, keymap1, "right", screenDimX, 400)
fighter2 = Fighter.new("alan gill", 1000, 400, keymap2, "left", screenDimX, 400)

function love.load()
    love.window.setTitle("Street Fighter");
    love.window.setMode(screenDimX, screenDimY)
    love.graphics.setNewFont(40)
end

function love.update(dt) 

end

function love.draw() 
    love.graphics.reset()
    love.graphics.line(0, 600, screenDimX, 600)
    updateFighters()
end

function updateFighters() 
    fighter1:update()
    fighter2:update()
end
