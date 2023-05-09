class Explosion
    attr_accessor :j

    def initialize(window, x, y)
        @x = x
        @y = y
        @explosions = Gosu::Image.load_tiles('Media/Image_Explosions.png', 40, 40)
        @i = 0
        @j = false
    end

    def draw
        if (@i < @explosions.count)
            @explosions[@i].draw_rot(@x, @y, 0)
            @i += 1
        else
            @j = true
        end
    end
end