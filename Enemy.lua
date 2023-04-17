Enemy = Class{}

function Enemy:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dy = 0
    self.dx = 50
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
    if self.y > VIRTUAL_HEIGHT / 2 and self.dx > 0 then
        self.dx = 75
    end
    if self.y > VIRTUAL_HEIGHT / 2 and self.dx < 0 then
        self.dx = -75
    end



end

function Enemy:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end