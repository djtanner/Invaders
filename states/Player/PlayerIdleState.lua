PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player

    self.animation = Animation {
        frames = {100,101,102},
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