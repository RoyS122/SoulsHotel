local dossier1_path = "src/modules/?.lua"
package.path = dossier1_path .. ";" .. package.path

Collision = require("collisions")
Engine = require("engine")
Ennemy = require("ennemy")
Player = require("player")

fps = 60
local timerFPScount = 0
local frames = 0

math.randomseed(os.time())
local ennemyGenerationClock = math.random(3, 10) * fps

function love.conf(t)
    t.console = true
end

function love.load()
    width, height = love.graphics.getDimensions()

    -- Définition du sol
    ground = {y = 500, h = 100}
    function ground.draw()
        love.graphics.rectangle("fill", 0, ground.y, width, ground.h)
    end

    -- Création de la liste des instances
    instanced = {}
    -- Ajout de l'objet joueur
    table.insert(instanced, Player:new(100, 1))
    table.insert(instanced, Ennemy:new(500, 1))
    table.insert(instanced, Ennemy:new(900, 1))
end

function love.update(dt)
    -- Mise à jour des instances
    --fps = dt 
    frames = frames + 1 
    timerFPScount = timerFPScount + dt
    if timerFPScount > 1 then 
        fps = frames
        frames = 0
        timerFPScount = 0
    end

    for i = #instanced, 1, -1 do
        local instance = instanced[i]
        if instance.toKill then
            table.remove(instanced, i)
        else
            instance:step()
        end
    end

    -- Génération des ennemis
    if ennemyGenerationClock > 0 then 
        ennemyGenerationClock = ennemyGenerationClock - 1
    else
        width, _ = love.graphics.getDimensions()
        table.insert(instanced, Ennemy:new(width, 1))
        ennemyGenerationClock = math.random(3, 10) *  fps
    end
end

function love.draw()
    love.graphics.setColor(255, 255, 255)

    ground.draw()


    
    for _, instance in ipairs(instanced) do
        instance:draw()
    end

    love.graphics.setColor(255, 255, 255)
    love.graphics.print(fps, 100, 100)
end
