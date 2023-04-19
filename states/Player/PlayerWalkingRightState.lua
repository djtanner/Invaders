PlayerWalkingRightState = Class{__includes = BaseState}

function PlayerWalkingRightState:init(player)
    self.player = player

    self.animation = Animation {
        frames = {1,2,3,4,5,6,7,8,9,10},
        interval = 0.2
    }

    self.player.currentAnimation = self.animation
end

function PlayerWalkingRightState:update(dt)
    self.player.currentAnimation:update(dt)

    if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
        self.player:changeState('idle')
    end

 
end