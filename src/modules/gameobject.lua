local gameobject = {}

function gameobject:new(posX, posY) 
    instance = {x = posX, y = posY, xspd = 0, yspd = 0, toKill = false, group = {}, sprite = {index = "src/sprites/spr_player.png", image = 0, loaded = 0, quads={}}, visible = true, collision = Collision:new(0,0,0,0)}
    setmetatable(instance, {__index = gameobject})
    return instance
end


function gameobject:kill() 
    self.toKill = true
end

function gameobject:collideWith(obj, x, y)             
    if obj ~= nil then 
        return (
            (x + self.collision.x < obj.x + (obj.collision.x + obj.collision.w)) and
            (x + (self.collision.x + self.collision.w) > obj.x + obj.collision.x) and
            (y + self.collision.y < obj.y + (obj.collision.y + obj.collision.h)) and
            (y + (self.collision.y + self.collision.h)> obj.y + obj.collision.y)
        )
    else
        return false    
    end
end

function gameobject:collideWithGroup(group, array, x, y)
   
    if (array ~= nil and group ~= nil) then 
        for i = 1, #array do
           
            if Engine.array_contains(array[i].group, group) then 
               
                if self:collideWith(array[i], x, y) then
                    
                    return true
                end
            end
        end
    end
    return false
end

return gameobject