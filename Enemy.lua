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

    self.animation = Animation {
        frames = {1,2,3,4},
        interval = 0.5
    }
    self.currentAnimation = self.animation

end


function Enemy:update(dt)

    self.currentAnimation:update(dt)

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
   -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
   
   if self.level == 1 then
   love.graphics.draw(gTextures['mermaid'], gFrames['mermaid'][self.currentAnimation:getCurrentFrame()], self.x, self.y)
   
   elseif self.level == 2 then
    love.graphics.draw(gTextures['priestess'], gFrames['priestess'][self.currentAnimation:getCurrentFrame()], self.x, self.y)
   

   elseif self.level % 3 == 0 then
    love.graphics.draw(gTextures['gypsy'], gFrames['gypsy'][self.currentAnimation:getCurrentFrame()], self.x, self.y)

   elseif self.level % 4 == 0 then
    love.graphics.draw(gTextures['steambot1'], gFrames['steambot1'][self.currentAnimation:getCurrentFrame()], self.x, self.y)

   elseif self.level % 5 == 0 then
    love.graphics.draw(gTextures['steambot3'], gFrames['steambot3'][self.currentAnimation:getCurrentFrame()], self.x, self.y)

   else love.graphics.draw(gTextures['steambot2'], gFrames['steambot2'][self.currentAnimation:getCurrentFrame()], self.x, self.y)
   
    
end




end