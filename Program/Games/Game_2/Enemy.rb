class Enemy
    attr_accessor :x, :y
    
    def initialize(window)
        @x = rand (20-780)
        @y = 20
        @enemy = Gosu::Image.new('Media/Image_TIE.png')
    end

    def move
        @y += 2
    end

    def draw
        @enemy.draw_rot(@x, @y, 0)
    end
end