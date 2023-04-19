StartState = Class{__includes = BaseState}

function StartState:enter()
    self.level = 1

    backgrounds = {
        { image = love.graphics.newImage("graphics/Clouds6/1.png"), speed = 10, x=0 },
        { image = love.graphics.newImage("graphics/Clouds6/2.png"), speed = 20, x=0 },
        { image = love.graphics.newImage("graphics/Clouds6/3.png"), speed = 30, x=0 },
        { image = love.graphics.newImage("graphics/Clouds6/4.png"), speed = 40, x=0 },
        { image = love.graphics.newImage("graphics/Clouds6/5.png"), speed = 50, x=0 }, 
        { image = love.graphics.newImage("graphics/Clouds6/6.png"), speed = 60, x=0 }, 
    }
end

function StartState:update(dt)

    function love.keypressed(key)
    if key == enter or key =='return' then
        gStateMachine:change('play', {
            score = 0, level = self.level
        })
    end

        if key == 'escape' then
            love.event.quit()
        end
    end
    updateBackgrounds(dt)

end

function StartState:render()
    -- title
    --love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    drawBackgrounds()
    love.graphics.setColor(10/255, 77/255, 104/255, 255/255)
    love.graphics.printf("SPACE INVADERS", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')

        love.graphics.printf("PRESS ENTER TO START, PRESS SPACE BAR TO SHOOT", 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')

end