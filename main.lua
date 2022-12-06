-- Load some default values for our rectangle.
function love.load()
    obj_player = {x = 1, y = 1, xspd = 0, yspd = 0, grounded = false}
    obj_ground = {y = 100, h = 100}
    
end



-- Increase the size of the rectangle every frame.
function love.update(dt)

end

-- Draw a coloured rectangle.
function love.draw()
    -- In versions prior to 11.0, color component values are (0, 102, 102)
    obj_ground.draw()
end
