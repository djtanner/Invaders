PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    
    self.score = params.score
    self.level = params.level
    self.enemies = LevelMaker.createMap(self.level)
    self.player = Player({stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['walkingright'] = function() return PlayerWalkingRightState(self.player) end, 
        ['walkingleft'] = function() return PlayerWalkingLeftState(self.player) end  
    }})
   
    bullets = {}
    explosions = {}

    background1 = {
        { image = love.graphics.newImage("graphics/Clouds1/1.png"), speed = 10, x=0 },
        { image = love.graphics.newImage("graphics/Clouds1/2.png"), speed = 20, x=0 },
        { image = love.graphics.newImage("graphics/Clouds1/4.png"), speed = 30, x=0 }}
        
    background2 = {
        { image = love.graphics.newImage("graphics/Clouds2/1.png"), speed = 10, x=0 },
        { image = love.graphics.newImage("graphics/Clouds2/2.png"), speed = 20, x=0 },
        { image = love.graphics.newImage("graphics/Clouds2/3.png"), speed = 30, x=0 },
        { image = love.graphics.newImage("graphics/Clouds2/4.png"), speed = 40, x=0 }}
        
    background3 = {
        { image = love.graphics.newImage("graphics/Clouds3/1.png"), speed = 10, x=0 },
        { image = love.graphics.newImage("graphics/Clouds3/2.png"), speed = 20, x=0 },
        { image = love.graphics.newImage("graphics/Clouds3/3.png"), speed = 30, x=0 },
        { image = love.graphics.newImage("graphics/Clouds3/4.png"), speed = 40, x=0 }, 
    }

    background4 = {
        { image = love.graphics.newImage("graphics/Clouds4/1.png"), speed = 10, x=0 },
        { image = love.graphics.newImage("graphics/Clouds4/2.png"), speed = 20, x=0 },
        { image = love.graphics.newImage("graphics/Clouds4/3.png"), speed = 30, x=0 },
        { image = love.graphics.newImage("graphics/Clouds4/4.png"), speed = 40, x=0 }, 
    }

    background5 = {
        { image = love.graphics.newImage("graphics/Clouds5/1.png"), speed = 10, x=0 },
        { image = love.graphics.newImage("graphics/Clouds5/2.png"), speed = 20, x=0 },
        { image = love.graphics.newImage("graphics/Clouds5/3.png"), speed = 30, x=0 },
        { image = love.graphics.newImage("graphics/Clouds5/4.png"), speed = 40, x=0 },
        { image = love.graphics.newImage("graphics/Clouds5/5.png"), speed = 50, x=0 }, 
    }

    background6 = {
        { image = love.graphics.newImage("graphics/Clouds6/1.png"), speed = 10, x=0 },
        { image = love.graphics.newImage("graphics/Clouds6/2.png"), speed = 20, x=0 },
        { image = love.graphics.newImage("graphics/Clouds6/3.png"), speed = 30, x=0 },
        { image = love.graphics.newImage("graphics/Clouds6/4.png"), speed = 40, x=0 },
        { image = love.graphics.newImage("graphics/Clouds6/5.png"), speed = 50, x=0 }, 
        { image = love.graphics.newImage("graphics/Clouds6/6.png"), speed = 60, x=0 }, 
    }

    background7 = {
        { image = love.graphics.newImage("graphics/Clouds7/1.png"), speed = 10, x=0 },
        { image = love.graphics.newImage("graphics/Clouds7/2.png"), speed = 20, x=0 },
        { image = love.graphics.newImage("graphics/Clouds7/3.png"), speed = 30, x=0 },
        { image = love.graphics.newImage("graphics/Clouds7/4.png"), speed = 40, x=0 },
        
    }

    background8 = {
        { image = love.graphics.newImage("graphics/Clouds8/1.png"), speed = 10, x=0 },
        { image = love.graphics.newImage("graphics/Clouds8/2.png"), speed = 20, x=0 },
        { image = love.graphics.newImage("graphics/Clouds8/3.png"), speed = 30, x=0 },
        { image = love.graphics.newImage("graphics/Clouds8/4.png"), speed = 40, x=0 },
        { image = love.graphics.newImage("graphics/Clouds8/5.png"), speed = 50, x=0 }, 
        { image = love.graphics.newImage("graphics/Clouds8/6.png"), speed = 60, x=0 }, 
    }


    backgrounds = background8

   
    self.player:changeState('idle')
end




function PlayState:update(dt)


    if next(self.enemies) == nil then
        self.level = self.level + 1
        self.enemies = LevelMaker.createMap(self.level)
        -- update the background on new level    
        local randomNumber = math.random(1, 5)
        backgroundName = "background" .. randomNumber
        backgrounds = _G[backgroundName]

    end


    for k, enemy in pairs(self.enemies) do
        enemy:update(dt)
         -- end game if enemy hits the same level as player
             if enemy:collides(self.player) then
                gStateMachine:change('gameover', {
                    score = self.score, level = self.level
                })     
             end
     end
    
    self.player:update(dt)
    updateBackgrounds(dt)

    function love.keypressed(key)
        if key == "space" then
            shoot = love.audio.newSource('sounds/shoot.wav', 'static')
            shoot:setVolume(.25)
            shoot:play()
            bullet = Bullet()
            bullet.x = self.player.x + self.player.width/2 - bullet.width/2
            bullet.y = self.player.y - 8
            -- only allow shooting 3 bullets at a time
            if tablelength(bullets) < 3 then
            table.insert(bullets,bullet)
            end
        end
     
        if key == 'escape' then
            love.event.quit()
        end

        -- for testing
       --[[  if key == "r" then
            gStateMachine:change('gameover', {
                score = self.score, level = self.level
            }) 
        end ]]
    
    end

    for n, explosion in pairs(explosions) do
        explosion:update(dt)

        if explosion.destroyed == true then
            table.remove(explosions,n)
        end
     end

     if next(bullets) ~= nil then
        for a, bullet in ipairs(bullets) do
            bullet:update(dt)
            -- remove bullet if it goes off screen
            if bullet.y <= 0 then 
                table.remove(bullets,a)
            end

            for k, enemy in pairs(self.enemies) do
                if bullet:collides(enemy) then
                    self.score= self.score + 10
                    table.remove(self.enemies,k)
                    table.remove(bullets,a)
                      
                    --create explosion
                    explosion = Explosion(math.floor(enemy.x), math.floor(enemy.y), false)
                    table.insert(explosions,explosion)
                    explode = love.audio.newSource('sounds/explode.wav', 'static')
                    explode:setVolume(1.5)
                    explode:play()

                end
            end
        end
    end

end

function PlayState:render()
    drawBackgrounds()

    for k, enemy in pairs(self.enemies) do
        enemy:render()
    end

    for m, explosion in pairs(explosions) do
        explosion:render()
    end
    
    self.player:render()

   
    for j, bullet in pairs(bullets) do
        bullet:render()
    end

    renderScore(self.score)
    
    renderLevel(self.level)

end

function updateBackgrounds(dt)
    for _, bg in ipairs(backgrounds) do
        bg.x = bg.x - bg.speed * dt
        if bg.x < -bg.image:getWidth() then
            bg.x = 0
        end
    end
end

-- draw each background layer at its current position
function drawBackgrounds()
    for _, bg in ipairs(backgrounds) do
        love.graphics.draw(bg.image, bg.x, 0)
        love.graphics.draw(bg.image, bg.x + bg.image:getWidth(), 0)
    end
end