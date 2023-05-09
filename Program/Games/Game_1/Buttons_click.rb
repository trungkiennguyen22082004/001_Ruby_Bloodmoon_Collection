class GemsCollection < Gosu::Window
    # Check if the player clicks in easy or hard level buttons
    def easy_click(mouse_x, mouse_y)
        if ((mouse_x > 200 and mouse_x < 350) && (mouse_y > 300 and mouse_y < 355))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def hard_click(mouse_x, mouse_y)
        if ((mouse_x > 450 and mouse_x < 600) and (mouse_y > 300 and mouse_y < 355))
            bool = true
        else
            bool = false
        end
        return bool
    end
end