Fighter = {}

function Fighter.new(name, x, y, keyMap, direction, screenDimX, regHeight)
    local f = {}
    f.name = name
    f.health = 100
    f.keyMap = keyMap
    f.direction = direction
    f.velY = 0
    f.x = x
    f.y = y
    f.width = 100
    f.height = 200
    f.hitboxX = f.width/2
    f.hitboxY = f.height/2
    f.screenDimX = screenDimX
    f.regHeight = regHeight
    f.walkRight = false;
    f.walkLeft = false;
    f.jumpUp = false;
    f.jumpFall = false; 
    f.punch = false;
    setmetatable(f, {__index = Fighter})
    return f
end

function Fighter:getState() 
    return self.state
end

function Fighter:getCoord()
    return {x = self.x, y = self.y}
end 

function Fighter:getHeight()
    return self.height
end

function Fighter:getWidth()
    return self.width
end

-- function Fighter:hitPlayer(player2)
--     xDist = self.width
--     yDist = self.height
--     p2Coords = {
--         x = player2.x,
--         y = player2.y
--     }
--     if (p2Coords.y > self.y and p2Coords.y - self.y <= yDist) or (p2Coords.y <= self.y and self.y - p2Coords.y <= yDist) then
--          if (p2Coords.x > self.x and p2Coords.x - self.x <= xDist) or (p2Coords.x <= self and self.x - p2Coords.x <= xDist) then
--              if player2.getState() == "punch" then 
--                  self.height = self.height - 40
--                  return true  
--              end
--          end
--      end
-- end

function Fighter:walkRightAction()
    if self.x >= (self.screenDimX - self.width) then
        self.x = self.screenDimX - self.width
    elseif self.x < (self.screenDimX - self.width) then
        self.x = self.x + 10
    end
end

function Fighter:walkLeftAction()
    if self.x <= 0 then
        self.x = 0
    elseif self.x > 0 then
        self.x = self.x - 10
    end
end

function Fighter:loseHealth(player2)
    loss = math.random(1, 8)
    if self.health - loss < 0 then
        self.health = 0
    else
        self.health = self.health - math.random(1, 8)
    end
    player2.punch = false
end

function Fighter:isDead()
    if self.health <= 0 then
        return true
    end
    return false
end

function Fighter:jumpUpAction()
    if self.velY > 0 then
        self.y = self.y - self.velY
        self.velY = self.velY - 1
    else
        self.jumpUp = false
        self.jumpFall = true
    end
end

function Fighter:jumpFallAction()
    if self.y >= self.regHeight then
        self.y = self.regHeight 
        self.jumpFall = false
    else
        self.y = self.y - self.velY
        self.velY = self.velY - 1
    end
end


function Fighter:update(dt)
    if not love.keyboard.isDown(self.keyMap['right']) then
        self.walkRight = false
    end
    if not love.keyboard.isDown(self.keyMap['left']) then
        self.walkLeft = false
    end
    if love.keyboard.isDown(self.keyMap['right']) then
        self.walkRight = true;
    end
    if love.keyboard.isDown(self.keyMap['left']) then
        self.walkLeft = true
    end
    if not self.jumpUp and not self.jumpFall and love.keyboard.isDown(self.keyMap['up']) then
        self.velY = 25
        self.y = self.y - 20
        self.jumpUp = true
    end

    if self.walkRight then
       self:walkRightAction()
    end
    if self.walkLeft then
        self:walkLeftAction()
    end
    if self.jumpUp then
        self:jumpUpAction()
    end
    if self.jumpFall then 
        self:jumpFallAction()
    end
    self:animate()
end

function Fighter:keypressed(key, unicode)
    if key == self.keyMap['punch'] then
        self.punch = true
    end 
end

function Fighter:animate()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
