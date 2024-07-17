local gO = require("gameobject")
local player = {}
setmetatable(player, {__index = gO})

function player:new(xPos, yPos) 
    local instance = gO:new(xPos, yPos)
    instance.grounded = false
    instance.sprite.index  = "src/sprites/spr_player-sheet.png"
    instance.sprite.loaded = love.graphics.newImage(instance.sprite.index)
    instance.sprite.scale = 2
    instance.animation = {col = 5, row = 1, speed = 2, step = 0, timer = 0}
    instance.collision = Collision:new(0, 0, instance.sprite.loaded:getWidth() / instance.animation.col * instance.sprite.scale, instance.sprite.loaded:getHeight() / instance.animation.row * instance.sprite.scale)
    setmetatable(instance, {__index = player})
    return instance
end

function player:isGrounded()
    local img = self.sprite.loaded
    if self.y + img:getHeight() * self.sprite.scale >= ground.y then
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


    if self.grounded and love.keyboard.isDown("space") then
        self.yspd = -20
    end

    if self:collideWithGroup("ennemy", instanced, self.x, self.y) then
        self:kill()
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
        love.graphics.draw(self.sprite.loaded, love.graphics.newQuad(xSprite, ySprite, self.sprite.loaded:getWidth() / self.animation.col , self.sprite.loaded:getHeight() / self.animation.row, self.sprite.loaded:getDimensions()),self.x, self.y, 0, self.sprite.scale, self.sprite.scale)
    end
end


return player 