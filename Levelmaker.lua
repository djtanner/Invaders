LevelMaker = Class{}

-- Create a table of enemies

function LevelMaker.createMap(level)
    local enemies = {}

     -- randomly choose the number of rows
     local numRows = math.random(1, 6)

      -- randomly choose the number of columns
    local numCols = math.random(7, 13)
    

    -- lay out the enemies with some spacing
        for y = 1, numRows do
            for x = 1, numCols do

                if x % 2 == 0 then
                    goto continue
                end
                    

                e = Enemy(
                    (x-1) * 20 + 40 , y * 20 + 24 , 32, 32, level
                )
              
                table.insert(enemies,e)
            
                ::continue::
            end

       
        end

    return enemies
end