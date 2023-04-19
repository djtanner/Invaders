Player = Class{}

function Player:init(params)
    -- x is placed in the middle
    self.x = VIRTUAL_WIDTH / 2 - 16

    self.y = VIRTUAL_HEIGHT - 40
    
    self.dx = 0
 
    self.width = 16
    self.height = 16

    self.stateMachine = params.stateMachine
    
  
end



function Player:changeState(state, params)
    self.stateMachine:change(state, params)
end

function Player:update(dt)

    self.stateMachine:update(dt)
    
    if love.keyboard.isDown('left') then
        self.dx = -100
    elseif love.keyboard.isDown('right') then
        self.dx = 100
    else
        self.dx = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)

    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end


function Player:render()
    --love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.draw(gTextures['mage'], gFrames['mage'][self.currentAnimation:getCurrentFrame()], self.x, self.y)
end