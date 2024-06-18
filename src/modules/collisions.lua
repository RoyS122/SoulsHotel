local collisionBox = {}

function collisionBox:new(rX, rY, w, h){
    -- The collision box constructor requiered 4 inputs:
    -- * The relative x
    -- * The relative y
    -- * The width of the box
    -- * The height of the box

    instance = {x, y, width, height}
    setmetatable(instance, {__index = collisionBox})
    return instance
}   

function collisionBox:collideWith(object, x, y) {
    
}

return collisionBox 