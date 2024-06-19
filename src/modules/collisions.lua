local Collision = {}
function Collision:new(posx, posy, width, height)
    return {x = posx, y = posy, w = width, h = height}
end 

return Collision