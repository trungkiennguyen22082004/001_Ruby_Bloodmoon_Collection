class Original2048 < Gosu::Window
    def easy_click(mouse_x, mouse_y)
        if ((mouse_x > 150 and mouse_x < 300) && (mouse_y > 415 and mouse_y < 470))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def hard_click(mouse_x, mouse_y)
        if ((mouse_x > 500 and mouse_x < 650) and (mouse_y > 415 and mouse_y < 470))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def superhard_click(mouse_x, mouse_y)
        if ((mouse_x > 250 and mouse_x < 550) and (mouse_y > 540 and mouse_y < 650))
            bool = true
        else
            bool = false
        end
        return bool
    end
end