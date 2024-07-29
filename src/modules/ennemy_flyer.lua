local gO = require("gameobject")
local ennemy = {}

setmetatable(ennemy, {__index = gO})

function ennemy:new(xPos, yPos) 
    local instance = gO:new(xPos, yPos)
    instance.grounded = false
    instance.group = {"ennemy"}
    instance.sprite = {index = "src/sprites/spr_ennemy1.png", image = 0, loaded = 0, xscale = 1, yscale = 1}
    instance.sprite.loaded = love.graphics.newImage(instance.sprite.index)
    instance.collision = Collision:new(0, 0, instance.sprite.loaded:getWidth(), instance.sprite.loaded:getHeight())
    instance.xspd = -1 * math.random(6, 12)
    instance.y = math.random(300, 470)
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
    
    

 
    self.x = self.x + self.xspd
    

end

function ennemy:draw()
    if self.visible then
        love.graphics.draw(love.graphics.newImage(self.sprite.index), self.x, self.y)
    end
end



return ennemy