local gO = require("gameobject")
local ennemy = {}

setmetatable(ennemy, {__index = gO})

function ennemy:new(xPos, yPos) 
    local instance = gO:new(xPos, yPos)
    instance.grounded = false
    instance.sprite = {index = "src/sprites/spr_ennemy1.png", image = 0, loaded = 0}
    instance.sprite.loaded = love.graphics.newImage(instance.sprite.index)
    instance.collision = Collision:new(0, 0, instance.sprite.loaded:getWidth(), instance.sprite.loaded:getHeight())
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
    if self.x >= 0 then
        self.xspd = -3
    else
        self:kill()
        self.xspd = 0
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
        love.graphics.draw(love.graphics.newImage(self.sprite.index), self.x, self.y)
    end
end



return ennemy