-- Load objects types and other predefined data for the game
function love.load()
    width, height = love.graphics.getDimensions( )

    obj_player = {x = 1, y = 1, xspd = 0, yspd = 0, grounded = false, sprite = {index = "src/sprites/spr_player.png", image = 0}, visible = 1}
    function obj_player.step()
        self.x = self.x + 1
    end
    -- Definition du sol
    ground = {y = 500, h = 100}
    function ground.draw()
        love.graphics.rectangle("fill", 0, ground.y, width, ground.h)
    end
    -- Création de la liste des instances
    instanced = {}
    instanced[1] = obj_player

end




function love.update(dt)
    for ins_upd = 1, #instanced do
        instanced[ins_upd].step()
    end
    print(obj_player.x)


end


function love.draw()
    -- In versions prior to 11.0, color component values are (0, 102, 102)
        love.graphics.setColor(0, 0.4, 0.4)
        ground.draw()

end
