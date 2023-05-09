class Name < Ruby2D::Window

    @keyboard = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    @name = ""
    @index = 0

    set width: 400
    set height: 135
    set title: 'Please enter your name before exiting..'
    set background: 'red'

    Text.new('Enter your name:', x: 10, y: 50, size: 20, color: 'white', z: 3)
    Text.new('Only 10 lower letters accepted! Press "/" to end', x: 176, y: 90, size: 10, color: 'white', z: 3)
    @text = Text.new(@name, x: 220, y: 50, style: 'bold', size: 20, color: 'black', z: 3)

    Rectangle.new(x: 197, y: 37, width: 156, height: 46, color: 'black', z: 1)
    Rectangle.new(x: 200, y: 40, width: 150, height: 40, color: 'white', z: 2)
    # Image.new('Media/Image_Tick_Icon.png', x: 312, y: 42, z: 3)

    on :key_down do |kb|
        for i in 0..(@keyboard.length)
            if (kb.key == '/')

                file = File.new('./Games/Games.txt', "r")
                record = []
                record[0] = file.gets
                count = file.gets.to_i
                index = 1
                while (index <= count)
                    record[index] = file.gets
                    index += 1
                end
                file.close()
        
                file1 = File.new('./Output.txt', "w")
                index = 0
                while (index <= count)
                    file1.puts(record[index])
                    index += 1
                end
                file1.puts("")
                if (@name != "")
                    file1.puts('Name of player: ' + @name)  
                else
                    file1.puts('Name of player: MoonPlayer')
                end
                file1.close()

                close
            elsif (kb.key == @keyboard[i]) && (@index < 10)
                @name += @keyboard[i]
                @index += 1
            end
        end
        @text.remove
        @text = Text.new(@name, x: 205, y: 52, style: 'bold', size: 18, color: 'black', z: 3)
    end
end