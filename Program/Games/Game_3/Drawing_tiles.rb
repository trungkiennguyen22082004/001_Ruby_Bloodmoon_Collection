class Drawing_tiles
    def initialize()
        @no2_image = Gosu::Image.new('Media/Image_2_Square.png')
        @no4_image = Gosu::Image.new('Media/Image_4_Square.png')
        @no8_image = Gosu::Image.new('Media/Image_8_Square.png')
        @no16_image = Gosu::Image.new('Media/Image_16_Square.png')
        @no32_image = Gosu::Image.new('Media/Image_32_Square.png')
        @no64_image = Gosu::Image.new('Media/Image_64_Square.png')
        @no128_image = Gosu::Image.new('Media/Image_128_Square.png')
        @no256_image = Gosu::Image.new('Media/Image_256_Square.png')
        @no512_image = Gosu::Image.new('Media/Image_512_Square.png')
        @no1024_image = Gosu::Image.new('Media/Image_1024_Square.png')
        @no2048_image = Gosu::Image.new('Media/Image_2048_Square.png')
    end

    def drawing(index, x, y)
        case index
        when 2
            @no2_image.draw_rot(x, y, 0)
        when 4
            @no4_image.draw_rot(x, y, 0)
        when 8
            @no8_image.draw_rot(x, y, 0)
        when 16
            @no16_image.draw_rot(x, y, 0)
        when 32
            @no32_image.draw_rot(x, y, 0)
        when 64
            @no64_image.draw_rot(x, y, 0)
        when 128
            @no128_image.draw_rot(x, y, 0)
        when 256
            @no256_image.draw_rot(x, y, 0)
        when 512
            @no512_image.draw_rot(x, y, 0)
        when 1024
            @no1024_image.draw_rot(x, y, 0)
        when 2048
            @no2048_image.draw_rot(x, y, 0)
        end
    end
end

