class Original2048 < Gosu::Window    
    def continue(images)
        bool = false
        j = 0
        for i in 1..16 
            j += 1 if (images[i] == 0)
        end
        bool = true if (j != 0) 
        return bool
    end

    def score(images)
        max = images[1]
        for i in 2..16 
            max = images[i] if (images[i] > max)
        end
        return max
    end

    def gameover(images)
        bool = false
        @j = 0
        for i in 1..16
            @j += 1 if (images[i] == 0)
        end
        if (@j == 0)
            images_1 = []
            @k = 0
            for i in 1..16
                images_1[i] = images[i]
            end
            images_1 = left(images_1, 1, 4)
            images_1 = left(images_1, 5, 8)
            images_1 = left(images_1, 9, 12)
            images_1 = left(images_1, 13, 16)
            k = 0
            for i in 1..16
                k += 1 if (images_1[i] == images[i])
            end
            @k += 1 if (k == 16)
            for i in 1..16
                images_1[i] = images[i]
            end
            images_1 = right(images_1, 1, 4)
            images_1 = right(images_1, 5, 8)
            images_1 = right(images_1, 9, 12)
            images_1 = right(images_1, 13, 16)
            k = 0
            for i in 1..16
                k += 1 if (images_1[i] == images[i])
            end
            @k += 1 if (k == 16)
            for i in 1..16
                images_1[i] = images[i]
            end
            images_1 = up(images_1, 1, 13)
            images_1 = up(images_1, 2, 14)
            images_1 = up(images_1, 3, 15)
            images_1 = up(images_1, 4, 16)
            k = 0
            for i in 1..16
                k += 1 if (images_1[i] == images[i])
            end
            @k += 1 if (k == 16)
            for i in 1..16
                images_1[i] = images[i]
            end
            images_1 = down(images_1, 1, 13)
            images_1 = down(images_1, 2, 14)
            images_1 = down(images_1, 3, 15)
            images_1 = down(images_1, 4, 16)
            k = 0
            for i in 1..16
                k += 1 if (images_1[i] == images[i])
            end
            @k += 1 if (k == 16)
            bool = true if (@k == 4)
        end
        return bool
    end
end