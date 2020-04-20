Fighter = {}

function Fighter.new(name, x, y, keyMap, direction, screenDimX, regHeight, animations, player, screenDimX)
    local f = {}
    f.name = name
    f.health = 100
    f.keyMap = keyMap
    f.direction = direction
    f.velY = 0
    f.x = x
    f.y = y
    f.width = 125
    f.height = 150
    f.hitboxX = f.width/2
    f.hitboxY = f.height/2
    f.screenDimX = screenDimX
    f.regHeight = regHeight
    f.walkRight = false;
    f.walkLeft = false;
    f.jumpUp = false;
    f.jumpFall = false; 
    f.punch = false;
    f.punchCooldown = false
    f.onCooldown = 0;
    f.animations = animations
    f.punchCounter = 0;
    f.animationCounter = 0;
    f.player = player
    f.screenDimX = screenDimX
    f.displayHealthLoss = 0
    f.healthLost = 0
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

function Fighter:walkRightAction()
    if self.x >= (self.screenDimX - self.width) then
        self.x = self.screenDimX - self.width
    elseif self.x < (self.screenDimX - self.width) then
        self.x = self.x + 10
    end
    self.direction = 'right'
end

function Fighter:walkLeftAction()
    if self.x <= 0 then
        self.x = 0
    elseif self.x > 0 then
        self.x = self.x - 10
    end
    self.direction = 'left'
end

function Fighter:loseHealth(player2)
    if player2.punchCounter == 0 then
        loss = math.random(1, 8)
        self.displayHealthLoss = 25
        self.healthLost = loss
        if self.health - loss < 0 then
            self.health = 0
        else
            self.health = self.health - loss
        end
    end
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
    -- if self.onCooldown > 0 then
    --     self.onCooldown = self.onCooldown - 1;
    -- end
    if self.displayHealthLoss > 0 then
        self.displayHealthLoss = self.displayHealthLoss - 1
    end
    if self.animationCounter > 20 then
        self.animationCounter = 0
    end
    if self.punchCounter == 0 then 
        self.punchCounter = 10
        self.punch = false
    end
    if self.punchCounter > 0 then
        self.punchCounter = self.punchCounter - 1
    end
    if not love.keyboard.isDown(self.keyMap['right']) then
        self.walkRight = false
        
    end
    if not love.keyboard.isDown(self.keyMap['left']) then
        self.walkLeft = false
    end
    if not love.keyboard.isDown(self.keyMap['left']) and not love.keyboard.isDown(self.keyMap['right']) then
        self.animationCounter = 0
    end
    if love.keyboard.isDown(self.keyMap['right']) then
        self.walkRight = true;
        self.animationCounter = self.animationCounter + 1
    end
    if love.keyboard.isDown(self.keyMap['left']) then
        self.walkLeft = true
        self.animationCounter = self.animationCounter + 1
    end
    if not self.jumpUp and not self.jumpFall and love.keyboard.isDown(self.keyMap['up']) then
        self.velY = 22
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

    self:animate(currentTime)
end

function Fighter:keypressed(key, unicode)
    if key == self.keyMap['punch'] then
        self.punch = true
        self.punchCounter = 10;
    end
end

function Fighter:animate(dt)
    if self.displayHealthLoss > 0 then
        love.graphics.print("-" .. self.healthLost, self.x + self.width/2 - 5, self.y - 50)
    end
    if self.player == 1 then 
        scale = 0.1
        moveLeft = 75
        if self.punch then
            if self.direction == "right" then
                love.graphics.draw(self.animations.punchright, self.x-moveLeft, self.y, 0, scale, scale)
            else
                love.graphics.draw(self.animations.punchleft, self.x-moveLeft, self.y, 0, scale, scale)
            end
        elseif self.walkRight then
            if self.animationCounter < 10 then
                love.graphics.draw(self.animations.stance1right, self.x-moveLeft, self.y, 0, scale, scale)
            else
                love.graphics.draw(self.animations.stance2right, self.x-moveLeft, self.y, 0, scale, scale)
            end
        elseif self.walkLeft then
            if self.animationCounter < 10 then
                love.graphics.draw(self.animations.stance2left, self.x-moveLeft, self.y, 0, scale, scale)
            else
                love.graphics.draw(self.animations.stance1left, self.x-moveLeft, self.y, 0, scale, scale)
            end
        else
            if self.direction == "right" then
                love.graphics.draw(self.animations.stance1right, self.x-moveLeft, self.y, 0, scale, scale)
            else 
                love.graphics.draw(self.animations.stance2left, self.x-moveLeft, self.y, 0, scale, scale)
            end
        end
    else 
        moveUp = 30
        if self.punch then
            if self.direction == "right" then
                love.graphics.draw(self.animations.punchright, self.x-100, self.y-moveUp, 0, 0.1, 0.1)
            else
                love.graphics.draw(self.animations.punchleft, self.x-100, self.y-moveUp, 0, 0.1, 0.1)
            end
        elseif self.walkRight then
            if self.animationCounter < 10 then
                love.graphics.draw(self.animations.stance1right, self.x-100, self.y-moveUp, 0, 0.1, 0.1)
            else
                love.graphics.draw(self.animations.stance2right, self.x-100, self.y-moveUp, 0, 0.1, 0.1)
            end
        elseif self.walkLeft then
            if self.animationCounter < 10 then
                love.graphics.draw(self.animations.stance2left, self.x-100, self.y-moveUp, 0, 0.1, 0.1)
            else
                love.graphics.draw(self.animations.stance1left, self.x-100, self.y-moveUp, 0, 0.1, 0.1)
            end
        else
            if self.direction == "right" then
                love.graphics.draw(self.animations.stance1right, self.x-100, self.y-moveUp, 0, 0.1, 0.1)
            else 
                love.graphics.draw(self.animations.stance1left, self.x-100, self.y-moveUp, 0, 0.1, 0.1)
            end
        end
    end
    -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
