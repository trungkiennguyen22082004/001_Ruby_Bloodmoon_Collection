class Original2048 < Gosu::Window
    def left(images, j, k)
        index = j
        while (index < k)
            index_1 = index + 1
            if (images[index] != 0)
                if (index >= j) && (index < k)
                    while (images[index_1] == 0 ) && (index_1 <= k)
                        index_1 += 1
                    end          
                    if (images[index] == images[index_1]) && (index_1 <= k)
                        @bonus_time += ((images[index] / 32) * @level) if (images[index] >= 32)
                        @collect_sound.play(0.3)
                        images[index] *= 2
                        images[index_1] = 0
                    end
                end
            end
            index += 1
        end
        index = j
        while (index < k) do
            sum = 0
            for i in index..k
                sum += images[i]
            end
            if (sum != 0) 
                while (images[index] == 0) do
                    for i in index..k
                        images[i] = images[i + 1]
                    end
                    images[k] = 0
                end
            end
            index += 1 if (images[index] != 0) || (sum == 0)
        end
        return images
    end

    def right(images, j, k)
        index = k
        while (index > j)
            index_1 = index - 1
            if (images[index] != 0)
                if (index > j) && (index <= k)
                    while (images[index_1] == 0 ) && (index_1 >= j)
                        index_1 -= 1
                    end          
                    if (images[index] == images[index_1]) && (index_1 >= j)
                        @bonus_time += ((images[index] / 32) * @level) if (images[index] >= 32)
                        @collect_sound.play(0.3)
                        images[index] *= 2
                        images[index_1] = 0
                    end
                end
            end
            index -= 1
        end
        index = k
        while (index > j) do
            sum = 0
            for i in j..index
                sum += images[i]
            end
            if (sum != 0) 
                while (images[index] == 0) do
                    i = index
                    while (i >= j) do
                        images[i] = images[i - 1]
                        i -= 1
                    end
                    images[j] = 0
                end
            end
            index -= 1 if (images[index] != 0) || (sum == 0)
        end
        return images
    end

    def up(images, j, k)
        index = j
        while (index < k)
            index_1 = index + 4
            if (images[index] != 0)
                while (images[index_1] == 0) && (index_1 <= k)
                    index_1 += 4
                    end
                if (images[index] == images[index_1]) && (index_1 <= k)
                    @bonus_time += ((images[index] / 32) * @level) if (images[index] >= 32)
                    @collect_sound.play(0.3)
                    images[index] *= 2
                    images[index_1] = 0
                end
            end
            index += 4
        end
        index = j
        while (index < k)
            sum = 0
            i = index
            while (i <= k)
                sum += images[i]
                i += 4
            end
            if (sum != 0)
                while (images[index] == 0)
                    i = index
                    while (i <= k)
                        images[i] = images[i + 4]
                        i += 4
                    end
                    images[k] = 0
                end
            end
            index += 4 if (images[index] != 0) || (sum == 0)
        end
        return images
    end

    def down(images, j, k)
        index = k
        while (index > j)
            index_1 = index - 4
            if (images[index] != 0)
                while (images[index_1] == 0) && (index_1 >= j)
                    index_1 -= 4
                    end
                if (images[index] == images[index_1]) && (index_1 >= j)
                    @bonus_time += ((images[index] / 32) * @level) if (images[index] >= 32)
                    @collect_sound.play(0.3)
                    images[index] *= 2
                    images[index_1] = 0
                end
            end
            index -= 4
        end
        index = k
        while (index > j)
            sum = 0
            i = index
            while (i >= j)
                sum += images[i]
                i -= 4
            end
            if (sum != 0)
                while (images[index] == 0)
                    i = index
                    while (i >= j)
                        images[i] = images[i - 4]
                        i -= 4
                    end
                    images[j] = 0
                end
            end
            index -= 4 if (images[index] != 0) || (sum == 0)
        end
        return images
    end
end