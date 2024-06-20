local gO = require("gameobject")
local player = {}
setmetatable(player, {__index = gO})

function player:new(xPos, yPos) 
    local instance = gO:new(xPos, yPos)
    instance.grounded = false
    instance.sprite.index  = "src/sprites/player.png"
    instance.sprite.loaded = love.graphics.newImage(instance.sprite.index)
    instance.animation = {col = 4, row = 1, speed = 2, step = 0, timer = 0}
    instance.collision = Collision:new(0, 0, instance.sprite.loaded:getWidth() / instance.animation.col, instance.sprite.loaded:getHeight()/ instance.animation.row)
    setmetatable(instance, {__index = player})
    return instance
end



function player:isGrounded()
    local img = self.sprite.loaded
    if self.y + img:getHeight() >= ground.y then
        return true
    else
        return false
    end
end

function player:step()
--    self.x = self.x + 1

    self.grounded = self:isGrounded();

    if self.grounded then
        self.yspd = 0
    else
        self.yspd = self.yspd + 1;
    end

--     if self:collideWith(instanced[2], self.x, self.y) then 
--         self.yspd = -100
--         self:kill()
--    end

    if self.grounded and love.keyboard.isDown("space") then
        self.yspd = -20
    end

    for i = 1, Engine.abs(self.yspd) do
        self.y = self.y + Engine.sign(self.yspd)
        if self:isGrounded() then
            break
        end
    end
    
--    self.y = self.y + self.yspd
end

function player:draw()
    if self.visible then
        self.animation.timer = self.animation.timer + 1
        if self.animation.timer > fps / self.animation.speed then 
            self.animation.step = (self.animation.step + 1) % (self.animation.col * self.animation.row)
            self.animation.timer = 0
        end

        local xSprite = self.animation.step % self.animation.col * (self.sprite.loaded:getWidth() / self.animation.col)
        local ySprite = math.floor( self.animation.step / self.animation.col) * (self.sprite.loaded:getHeight() / self.animation.row)
        love.graphics.draw(self.sprite.loaded, love.graphics.newQuad(xSprite, ySprite, self.sprite.loaded:getWidth() / self.animation.col , self.sprite.loaded:getHeight() / self.animation.row, self.sprite.loaded:getDimensions()),self.x, self.y)
    end
end


return player 