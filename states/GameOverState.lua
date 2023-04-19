GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    self.level = params.level
    self.score = params.score
end

function GameOverState:update(dt)
    
    updateBackgrounds(dt)
    function love.keypressed(key)
    if key == enter or key =='return' then
        gStateMachine:change('play', {
            score = 0, level = 1
        })
    end

        if key == 'escape' then
            love.event.quit()
        end
    end


end

function GameOverState:render()
    -- title
    --love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    drawBackgrounds()

    love.graphics.printf("GAME OVER", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')


        love.graphics.printf("PRESS ENTER TO PLAY AGAIN", 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')

        

        renderScore(self.score)
        renderLevel(self.level)

end