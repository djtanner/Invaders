StartState = Class{__includes = BaseState}

function StartState:enter()
    self.level = 1
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


end

function StartState:render()
    -- title
    

    love.graphics.printf("SPACE INVADERS", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')

        love.graphics.printf("PRESS ENTER TO START, PRESS SPACE BAR TO SHOOT", 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')

end