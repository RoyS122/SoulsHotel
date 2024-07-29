local gO = require("gameobject")
local ennemy = {}

setmetatable(ennemy, {__index = gO})

function ennemy:new(xPos, yPos) 
    local instance = gO:new(xPos, yPos)
    instance.grounded = false
    instance.group = {"ennemy"}
    instance.sprite = {index = "src/sprites/spr_ennemy_runner.png", image = 0, loaded = 0, xscale = 1, yscale = 1}
    instance.sprite.loaded = love.graphics.newImage(instance.sprite.index)
    instance.sprite.scale = 2
    instance.animation = {col = 10, row = 1, speed = 5, step = 0, timer = 0}
    instance.collision = Collision:new(0, 0, instance.sprite.loaded:getWidth(), instance.sprite.loaded:getHeight())
    instance.xspd = -1 * math.random(4, 11)
    setmetatable(instance, {__index = ennemy})
    return instance
end

function ennemy:isGrounded()
    local img = self.sprite.loaded
    if self.y + img:getHeight() >= ground.y then
        return true
    else
        return false
    end
end

function ennemy:step()
   -- print(self.x)
    if self.x <= 0 then
        self:kill()
    end
    
    self.grounded = self:isGrounded();

    if self.grounded then
        self.yspd = 0
    else
        self.yspd = self.yspd + 1;
    end

    for i = 1, Engine.abs(self.yspd) do
        self.y = self.y + Engine.sign(self.yspd)
        if self:isGrounded() then
            break
        end
    end

    self.x = self.x + self.xspd
    

end

function ennemy:draw()
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



return ennemy