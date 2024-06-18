local dossier1_path = "src/modules/?.lua"
package.path = dossier1_path .. ";" .. package.path

Engine = require("engine")
Ennemy = require("ennemy")
Player = require("player")




function love.conf(t)
	t.console = true
end

-- Load objects types and other predefined data for the game
function love.load()
    width, height = love.graphics.getDimensions( )
    -- Objet player
   
    -- Fonctions(methodes) de l'objet player
   
    
    
    
    -- table = {}  -- Construction de la table.    
 
    -- mt = {} -- Construction de la métatable.
 
    -- mt._index(obj_ennemy_runner)   -- Construction de __index.

    -- print(mt)
    


    -- Definition du sol
    ground = {y = 500, h = 100}
    function ground.draw()
        love.graphics.rectangle("fill", 0, ground.y, width, ground.h)
    end

    -- Création de la liste des instances
    instanced = {}
    -- Ajout de l'objet joueur
    instanced[1] = Player:new(100, 1)

    instanced[2] = Ennemy:new(500, 1)
    

    instanced[3] = Ennemy:new(900, 1)
    
  
end



function love.update(dt)

    for ins_upd = 1, #instanced do
        if instanced[ins_upd]:step() ~= nil then
            instanced[ins_upd]:step()
        end
    end

end


function love.draw()
    -- In versions prior to 11.0, color component values are (0, 102, 102)
    love.graphics.setColor(255, 255, 255)

    ground.draw()

    love.graphics.setColor(0, 0.4, 15)
    
    for ins_upd = 1, #instanced do
        if instanced[ins_upd]:draw() ~= nil then
            instanced[ins_upd]:draw()
        end
    end

end



