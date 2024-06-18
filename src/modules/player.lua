--local Engine = require("engine")

local player = {}

function player:new(xPos, yPos) 
    local instance = {x = xPos, y = yPos, xspd = 0, yspd = 0, grounded = false, sprite = {index = "src/sprites/spr_player.png", image = 0, loaded = 0}, visible = true, jump = 50}
    instance.sprite.loaded = love.graphics.newImage(instance.sprite.index)
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
        love.graphics.draw(love.graphics.newImage(self.sprite.index), self.x, self.y)
    end
end

return player 