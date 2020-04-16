local fighter = require "fighter"

screenDimX = 1280;
screenDimY = 720;
local keymap1 = {up="w",down="s",left="a",right="d",punch="g"}
fighter1 = Fighter.new("jonalan xugill", keymap1)




function love.load()
    love.window.setTitle("Pong");
    love.window.setMode(screenDimX, screenDimY)
    love.graphics.setNewFont(40)
end

function love.update(dt) 

end

function love.draw() 
    love.graphics.reset()
    fighter1:animate()
end
