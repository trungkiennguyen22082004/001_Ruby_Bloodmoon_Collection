class Player
    attr_accessor :x, :y, :angle

    def initialize(window)
        @x = @y = @v_x = @v_y = @angle = 0
        
        @spaceship = Gosu::Image.new('Media/Image_X-wing.png')
    end

    def setup
        @x = 400
        @y = 550
        @v_x = @v_y = @angle = 0
    end

    def turn_right
        @angle += 3 if (@angle <= 40)
    end

    def turn_left
        @angle -= 3 if (@angle >= -40)
    end

    def accelerate
        @v_x += Gosu.offset_x(@angle, 0.5)
        @v_y += Gosu.offset_y(@angle, 0.5)
    end

    def decelerate
        @v_x -= Gosu.offset_x(@angle, 0.5)
        @v_y -= Gosu.offset_y(@angle, 0.5)
    end

    def move
        @x += @v_x
        @y += @v_y
        @v_x *= 0.9
        @v_y *= 0.9
        if (@x > 783)
            @v_x = 0
            @x = 783
        elsif (@x < 17)
            @v_x = 0
            @x = 17
        end
        if (@y > 575)
            @v_y = 0
            @y = 575
        elsif (@y < 25)
            @v_y = 0
            @y = 25
        end
    end

    def draw
        @spaceship.draw_rot(@x, @y, 0, @angle)
    end
end