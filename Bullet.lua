Bullet = Class{}

function Bullet:init()
    self.width = 16
    self.height = 16
    self.dy = -90
    self.dx = 0
    

end


function Bullet:update(dt)
    self.y = self.y + self.dy * dt
    
end

function Bullet:render()
    
    love.graphics.draw(gTextures['laser'], gFrames['laser'][2], self.x, self.y)
end


function Bullet:collides(target)
    
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    return true
end