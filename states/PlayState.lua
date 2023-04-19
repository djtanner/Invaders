PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.score = params.score
    self.level = params.level
    self.enemies = LevelMaker.createMap(self.level)
    self.player = Player()
   
    bullets = {}
end

function PlayState:update(dt)

    if next(self.enemies) == nil then
        self.level = self.level + 1
        self.enemies = LevelMaker.createMap(self.level)
    end


    for k, enemy in pairs(self.enemies) do
        enemy:update(dt)
         -- end game if enemy hits the same level as player
             if enemy.y >= VIRTUAL_HEIGHT-20 then
                gStateMachine:change('gameover', {
                    score = self.score, level = self.level
                })     
             end
     end
    
    self.player:update(dt)

    function love.keypressed(key)
        if key == "space" then
            bullet = Bullet()
            bullet.x = self.player.x + self.player.width/2 - bullet.width/2
            bullet.y = self.player.y - 8
    
            table.insert(bullets,bullet)
        end
     
        if key == 'escape' then
            love.event.quit()
        end

        if key == "r" then
            gStateMachine:change('gameover', {
                score = self.score, level = self.level
            }) 
        end
    
    end

     if next(bullets) ~= nil then
        for a, bullet in ipairs(bullets) do
            bullet:update(dt)
            for k, enemy in pairs(self.enemies) do
                if bullet:collides(enemy) then
                    self.score= self.score + 10
                    table.remove(self.enemies,k)
                    table.remove(bullets,a)
                end
            end

        end
    end

end

function PlayState:render()
    for k, enemy in pairs(self.enemies) do
        enemy:render()
    end
    
    self.player:render()

   
    for j, bullet in pairs(bullets) do
        bullet:render()
    end

    renderScore(self.score)
    
    renderLevel(self.level)

end