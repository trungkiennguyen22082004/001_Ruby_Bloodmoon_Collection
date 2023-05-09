class Heart
    attr_accessor :x, :y
    
    def initialize(window)
        @x = rand (25-775)
        @y = 25
        @heart = Gosu::Image.new('Media/Image_Heart.png')
    end

    def move
        @y += 5
    end

    def draw
        @heart.draw_rot(@x, @y, 0)
    end
end