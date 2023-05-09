class Bullet
    attr_accessor :x, :y

    def initialize(window, x, y, angle)
        @x = x
        @y = y
        @angle = angle
        @bullet = Gosu::Image.new('Media/Image_Plasma_Bullet.png')
    end

    def move
        @x += Gosu.offset_x(@angle, 10)
        @y += Gosu.offset_y(@angle, 10)
    end

    def draw
        @bullet.draw_rot(@x, @y, 0, @angle)
    end
end