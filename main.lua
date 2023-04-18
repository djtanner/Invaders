push = require 'push'
Class = require 'class'
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/StartState'
require 'Enemy'
require 'Levelmaker'
require 'Player'
require 'Bullet'
require 'Dependencies'
require 'Animation'




-- size of our actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size to emulate with push library
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


function love.load()

    font = love.graphics.newFont("fonts/font.ttf", 18)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Space Invaders')
    math.randomseed(os.time())
    

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        
       
    }
   --[[  gStateMachine:change('play', {
        score = 0, level = 1
    }) ]]
    gStateMachine:change('start')
 

end

function love.resize(w, h)
    push:resize(w, h)
end


function love.update(dt)
    gStateMachine:update(dt)

  
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

   
   love.graphics.clear(236/255, 201/255, 238/255, 255/255)
    love.graphics.setFont(font)
    gStateMachine:render()
    
 

    -- display FPS for debugging; simply comment out to remove
     displayFPS()

     -- end our drawing to push
     push:apply('end')
 end


 function displayFPS()
    -- simple FPS display across all states
    
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 40)
end

function renderScore(score)
    
    love.graphics.print('Score:', VIRTUAL_WIDTH - 120, 5)
    love.graphics.printf(tostring(score), VIRTUAL_WIDTH - 60, 5, 60, 'right')
end

function renderLevel(level)
    
    love.graphics.print('Level:', 10, 5)
    love.graphics.printf(tostring(level),  60, 5, 40, 'left')
end