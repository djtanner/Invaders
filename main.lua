push = require 'push'
Class = require 'class'

require 'Enemy'
require 'Levelmaker'
require 'Player'
require 'Bullet'


-- size of our actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size to emulate with push library
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Space Invaders')
    math.randomseed(os.time())
    

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    
    enemy = Enemy(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    score = 0

    gameState = 'start'
    
    
    level = 1
    enemies = LevelMaker.createMap(level)
    player = Player()
   
    bullets = {}

end

function love.resize(w, h)
    push:resize(w, h)
end


function love.update(dt)

    for k, enemy in pairs(enemies) do
        enemy:update(dt)
         -- end game if enemy hits the ground (change this later to colliding with player)
             if enemy.y >= VIRTUAL_HEIGHT then
                     gameState = 'gameover'
        
                    end
     end
    
    player:update(dt)


    function love.keypressed(key)
        if key == "space" then
            bullet = Bullet()
            bullet.x = player.x + player.width/2 - bullet.width/2
            bullet.y = player.y - 8
            
            table.insert(bullets,bullet)
        end
     end

-- destroy bullet and enemy on collision
    if next(bullets) ~= nil then
        for a, bullet in ipairs(bullets) do
            bullet:update(dt)
            for k, enemy in pairs(enemies) do
                if bullet:collides(enemy) then
                    table.remove(enemies,k)
                    table.remove(bullets,a)
                end
            end

        end
    end

    

  
end




function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    print(count)
    return count
  end


function love.draw()
    -- begin drawing with push, in our virtual resolution
    push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

   
    
   for k, enemy in pairs(enemies) do
        enemy:render()
    end
    
    player:render()

   
    for k, enemy in pairs(bullets) do
        bullet:render()
    end



    -- display FPS for debugging; simply comment out to remove
     displayFPS()

     -- end our drawing to push
     push:apply('end')
 end


 function displayFPS()
    -- simple FPS display across all states
    
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
