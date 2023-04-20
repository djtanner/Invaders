require 'Util'


-- swords from https://snoopethduckduck.itch.io/swords
-- enemy assets from https://chierit.itch.io/lively-npcs
-- cloud backgrounds from https://free-game-assets.itch.io/free-sky-with-clouds-background-pixel-art-set
-- spaceship from https://ansimuz.itch.io/spaceship-shooter-environment





gTextures = {
    ['steambot1'] = love.graphics.newImage('graphics/steambot_01.png'),
    ['steambot2'] = love.graphics.newImage('graphics/steambot_02.png'),
    ['steambot3'] = love.graphics.newImage('graphics/steambot_03.png'),
    ['mermaid'] = love.graphics.newImage('graphics/mermaid.png'),
    ['gypsy'] = love.graphics.newImage('graphics/gypsy.png'),
    ['priestess'] = love.graphics.newImage('graphics/priestess.png'),
    ['mage'] = love.graphics.newImage('graphics/ship.png'),
    ['laser'] = love.graphics.newImage('graphics/laser-bolts.png'),
    
}

gFrames = {
    ['steambot1'] = GenerateQuads(gTextures['steambot1'], 32, 32),
    ['steambot2'] = GenerateQuads(gTextures['steambot2'], 32, 32),
    ['steambot3'] = GenerateQuads(gTextures['steambot3'], 32, 32),
    ['mermaid'] = GenerateQuads(gTextures['mermaid'], 32, 32),
    ['gypsy'] = GenerateQuads(gTextures['gypsy'], 32, 32),
    ['priestess'] = GenerateQuads(gTextures['priestess'], 32, 32),
    ['mage'] = GenerateQuads(gTextures['mage'], 16, 24),
    ['laser'] = GenerateQuads(gTextures['laser'], 16, 16),
    
}


