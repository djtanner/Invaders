Player = Class{}

function Player:init(params)
    -- x is placed in the middle
    self.x = VIRTUAL_WIDTH / 2 - 16

    self.y = VIRTUAL_HEIGHT - 30
    
    self.dx = 0
 
    self.width = 16
    self.height = 24

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

    if love.keyboard.isDown('up') then
        self.dy = -100
    elseif love.keyboard.isDown('down') then
        self.dy = 100
    else
        self.dy = 0
    end


    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)

    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end

    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)

    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end



end


function Player:render()
    --love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.draw(gTextures['mage'], gFrames['mage'][self.currentAnimation:getCurrentFrame()], self.x, self.y)
end