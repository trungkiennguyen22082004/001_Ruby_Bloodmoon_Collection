# Class for the obstacles
class Brick 
    attr_accessor :x, :space

    def initialize(window)
        @x = 1100
        @brick = Gosu::Image.new('Media/Image_Bricks.png')
        @top_brick = Gosu::Image.new('Media/Image_Top-brick.png')
        @space = rand(1..3)
    end

    def move(speed)
        @x -= speed
    end

    def draw
        for i in 0..5 do
            if (i != @space) && (i != (@space + 1))
                z = 0
            else
                z = -1
            end    
            @brick.draw(@x, (i * 80) - 20, z, 0.2, 0.2)
        end
        @top_brick.draw(@x - 3, (@space * 80) - 41, 0, 0.2, 0.2)
        @top_brick.draw(@x - 3, (@space * 80) + 119, 0, 0.2, 0.2)
    end
end