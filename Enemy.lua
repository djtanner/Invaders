Enemy = Class{}

function Enemy:init(x, y, width, height,level)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dy = 0
    self.dx = 50

    self.level = level

    if self.level < 3 then
        self.dx = 50

    elseif self.level <= 5 then
        self.dx = 75
    
    elseif self.level <=8 then
        self.dx = 90

    else self.dx = 140
    end


end


function Enemy:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

      -- reverse direction if enemy hits a wall and move down
      if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
        self.y = self.y + 10
    end

    if self.x >= VIRTUAL_WIDTH  then
        self.x = VIRTUAL_WIDTH
        self.dx = -self.dx
        self.y = self.y + 10
    end

    -- increase speed as get lower on screen
    if self.y > VIRTUAL_HEIGHT / 2 and self.dx > 0 and self.level < 3 then
        self.dx = 75
    
    elseif self.y > VIRTUAL_HEIGHT / 2 and self.dx < 0 and self.level < 3 then
        self.dx = -75
    
    elseif self.y > VIRTUAL_HEIGHT / 2 and self.dx > 0 and self.level <= 5 then
        self.dx = 90
    
    elseif self.y > VIRTUAL_HEIGHT / 2 and self.dx < 0 and self.level <= 5 then
        self.dx = -90

    elseif self.y > VIRTUAL_HEIGHT / 2 and self.dx > 0 and self.level > 5 then
        self.dx = 150
    
    elseif self.y > VIRTUAL_HEIGHT / 2 and self.dx < 0 and self.level > 5 then
        self.dx = -150


    end








end

function Enemy:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end