class OvercomingObstacles < Gosu::Window
    # Check if player clicks in the levels buttons
    def easy_click(mouse_x, mouse_y)
        if ((mouse_x > 110 and mouse_x < 260) && (mouse_y > 280 and mouse_y < 335))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def hard_click(mouse_x, mouse_y)
        if ((mouse_x > 470 and mouse_x < 620) and (mouse_y > 280 and mouse_y < 335))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def superhard_click(mouse_x, mouse_y)
        if ((mouse_x > 830 and mouse_x < 980) and (mouse_y > 280 and mouse_y < 335))
            bool = true
        else
            bool = false
        end
        return bool
    end
end