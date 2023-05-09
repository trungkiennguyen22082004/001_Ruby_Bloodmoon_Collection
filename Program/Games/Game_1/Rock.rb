# Class for the rocks in hard level
class Rock
    attr_accessor :x, :y, :ratio

    def initialize(window)
        @rock = Gosu::Image.new('Media/Image_Rock.png')

        @x = rand(50..750)
        @y = rand(50..550)
        @v_x = rand(2..6)
        @v_y = rand(2..6)
        @ratio = rand(0..10) * 0.1 + 1
    end

    def move
        @x += @v_x
        @y += @v_y
        @v_x *= -1 if (@x - 16 > 768) || (@x - 16 < 0)
        @v_y *= -1 if (@y - 15 > 570) || (@y - 15 < 0)
    end

    def draw
        @rock.draw(@x, @y, 0, @ratio, @ratio)
    end
end