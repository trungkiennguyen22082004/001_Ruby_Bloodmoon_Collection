class Bird
    attr_accessor :y

    def initialize
        @bird = Gosu::Image.load_tiles('Media/Image_Bird.png', 54, 50)

        @y = 240
        @draw_bird = false
        @bird_index = 0
    end

    def setup
        @y = 240
    end
    
    def move
        @y += 3
    end

    def jump
        @y -= 6
    end

    def fly()
        if (@y <= 440)
            if (@bird_index < @bird.count)
                @bird[@bird_index].draw_rot(150, @y, 0)
                @bird_index += 1
            else
                @draw_bird = false
                @bird_index = 0
            end
            @draw_bird = true
        else
            injury()
        end
    end

    def injury(speed)
        @bird[1].draw_rot(150 - speed, @y, 0)
    end
end