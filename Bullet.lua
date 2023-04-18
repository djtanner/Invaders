Bullet = Class{}

function Bullet:init()
    self.width = 8
    self.height = 12
    self.dy = -90
    self.dx = 0
    bulletimg = love.graphics.newImage("graphics/bullet.png")

end


function Bullet:update(dt)
    self.y = self.y + self.dy * dt
    
end

function Bullet:render()
    --love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.draw(bulletimg, self.x,self.y, 0, 0.3,0.3)
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