PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player

    self.animation = Animation {
        frames = {1,2,3},
        interval = 0.5
    }

    self.player.currentAnimation = self.animation
end

function PlayerIdleState:update(dt)
    self.player.currentAnimation:update(dt)

    if love.keyboard.isDown('right') then
        self.player:changeState('walkingright')
    end

    if love.keyboard.isDown('left') then
        self.player:changeState('walkingleft')
    end
 
end