-- Explosion class definition
Explosion = Class{}


function Explosion:init(x, y, destroyed)  
  self.x = math.floor(x)
  self.y = math.floor(y)
  self.destroyed = false

  self.animation = Animation {
    frames = {1,2,3,4,5},
    interval = .08
}
self.currentAnimation = self.animation

end

function Explosion:update(dt)

  self.currentAnimation:update(dt)
  
   
  if self.currentAnimation:getCurrentFrame() == 5 then
    -- destroy the explosion object when the animation is over
    self.destroyed = true
  end
end

function Explosion:render()
  
if self.destroyed == false then
  love.graphics.draw(gTextures['explosion'], gFrames['explosion'][self.currentAnimation:getCurrentFrame()], math.floor(self.x), math.floor(self.y))

end

end
