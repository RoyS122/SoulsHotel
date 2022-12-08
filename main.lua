function sign(number)
    if number < 0 then
        return -1
    else
        if number > 0 then
            return 1
        end
    end
    return 0
end

function abs(number)
    if number < 0 then
        return number / - 1
    end
    return number
end


-- Load objects types and other predefined data for the game
function love.load()
    width, height = love.graphics.getDimensions( )
    -- Objet player
    obj_player = {x = 1, y = 1, xspd = 0, yspd = 0, grounded = false, sprite = {index = "src/sprites/spr_player.png", image = 0}, visible = true, jump = 50}
    -- Fonctions(methodes) de l'objet player
    function obj_player.isGrounded()
        local img = love.graphics.newImage(obj_player.sprite.index)
        if obj_player.y + img:getHeight() >= ground.y then
            return true
        else
            return false
        end
    end

    function obj_player.step()
    --    obj_player.x = obj_player.x + 1
        obj_player.grounded = obj_player.isGrounded();

        if obj_player.grounded then
            obj_player.yspd = 0
        else
            obj_player.yspd = obj_player.yspd + 1;
        end

        if obj_player.grounded and love.keyboard.isDown("space") then
            obj_player.yspd = -20
        end

        for i = 1, abs(obj_player.yspd) do
            obj_player.y = obj_player.y + sign(obj_player.yspd)
            if obj_player.isGrounded() then
                break
            end
        end
    --    obj_player.y = obj_player.y + obj_player.yspd
    end

    function obj_player.draw()
        if obj_player.visible then
            love.graphics.draw(love.graphics.newImage(obj_player.sprite.index), obj_player.x, obj_player.y)
        end
    end

    obj_ennemy_runner = {x = 1, y = 1, xspd = 0, yspd = 0, grounded = false, sprite = {index = "src/sprites/spr_ennemy1.png", image = 0}, visible = true}
    function obj_ennemy_runner.step()

    end
    function obj_ennemy_runner.draw()
        if obj_ennemy_runner.visible then
            love.graphics.draw(love.graphics.newImage(obj_ennemy_runner.sprite.index), obj_ennemy_runner.x, obj_ennemy_runner.y)
        end
    end

    -- Definition du sol
    ground = {y = 500, h = 100}
    function ground.draw()
        love.graphics.rectangle("fill", 0, ground.y, width, ground.h)
    end

    -- Création de la liste des instances
    instanced = {}
    -- Ajout de l'objet joueur
    instanced[1] = obj_player

end



function love.update(dt)

    for ins_upd = 1, #instanced do
        if instanced[ins_upd].step() ~= nil then
            instanced[ins_upd].step()
        end
    end

end


function love.draw()
    -- In versions prior to 11.0, color component values are (0, 102, 102)
    love.graphics.setColor(255, 255, 255)
    ground.draw()
    love.graphics.setColor(0, 0.4, 0.4)
    for ins_upd = 1, #instanced do
        if instanced[ins_upd].draw() ~= nil then
            instanced[ins_upd].draw()
        end
    end

end
