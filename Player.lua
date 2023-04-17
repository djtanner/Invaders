Player = Class{}

function Player:init()
    -- x is placed in the middle
    self.x = VIRTUAL_WIDTH / 2 - 32

    self.y = VIRTUAL_HEIGHT - 16
    
    self.dx = 0
 
    self.width = 32
    self.height = 8

  
end

function Player:update(dt)
    
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
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end