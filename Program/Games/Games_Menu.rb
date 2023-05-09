require './Games/Game_1/Gems_collection.rb'
require './Games/Game_2/Star_wars.rb'
require './Games/Game_3/2048.rb'
require './Games/Game_4/Overcoming_obstacles.rb'
require './Games/Record.rb'
require './Games/Name.rb'

class Menu < Gosu::Window
    attr_accessor :screen, :records

    def initialize(screen, records)
        super(1200, 800)
        self.caption = 'Games Menu of BLOODMOON'

        # Set up variables for media (images, songs, sounds, texts)
        @image_swinburne_logo = Gosu::Image.new('Media/Image_Swinburne_logo.png')
        @image_moon_logo = Gosu::Image.new('Media/Image_Moon_Logo.png')
        @image_bloodmoon_background = Gosu::Image.new('Media/Image_Bloodmoon_Background.png')
        @image_gems_collection = Gosu::Image.new('Media/Image_Gems_Collection.png')
        @image_star_war = Gosu::Image.new('Media/Image_Star_Wars.png')
        @image_2048 = Gosu::Image.new('Media/Image_2048.png')
        @image_overcoming_obstacles = Gosu::Image.new('Media/Image_Overcoming_obstacles.png')
        @image_mp_1 = Gosu::Image.new('Media/Image_Mouse_pointer_1.png')
        @image_mp_2 = Gosu::Image.new('Media/Image_Mouse_pointer_2.png')
        @image_mp_3 = Gosu::Image.new('Media/Image_Mouse_pointer_3.png')
        @image_info_icon = Gosu::Image.new('Media/Image_Information_Icon.png')
        @image_record_icon = Gosu::Image.new('Media/Image_Record_Icon.png')
        @image_home_icon = Gosu::Image.new('Media/Image_Home_Icon.png')
        @image_exit_icon = Gosu::Image.new('Media/Image_Exiting_Icon.png')
        @image_arrow_icon = Gosu::Image.new('Media/Image_Arrow.png')
        @image_speech_bubble = Gosu::Image.new('Media/Image_Speech_bubble.png')
        @sound_intro = Gosu::Sample.new('Media/Sound_Doctor_Strange_2_trailer_Intro.wav')
        @song_menu = Gosu::Song.new('Media/Song_GD_Press_start.wav')
        @song_high_score = Gosu::Song.new('Media/Song_GD_Power_trip.wav')
        @font = Gosu::Font.new(30)

        @screen = screen     # Set up screen varaible
        @screen_1 = 0        # Set up variable for hiding/showing info bubble

        # Set up the variables used for viewing screen
        @records = records

        # Set up the varibles for drawing information speech bubble 
        @info_x = 80
        @info_y = 721

        # Set up the variables for the logos in intro screen
        @x_1 = 610
        @y_1 = 240
        @x_2 = 300
        @y_2 = 40
        @z_1 = @z_2 = 0
    end

    # Check whether to select each game or not
    def game1(mouse_x, mouse_y)
        if ((mouse_x > 310 and mouse_x < 550) && (mouse_y > 220 and mouse_y < 400))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def game2(mouse_x, mouse_y)
        if ((mouse_x > 650 and mouse_x < 890) && (mouse_y > 220 and mouse_y < 400))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def game3(mouse_x, mouse_y)
        if ((mouse_x > 310 and mouse_x < 550) && (mouse_y > 470 and mouse_y < 710))
            bool = true
        else
            bool = false
        end
        return bool
    end

    def game4(mouse_x, mouse_y)
        if ((mouse_x > 650 and mouse_x < 890) && (mouse_y > 520 and mouse_y < 640))
            bool = true
        else
            bool = false
        end
        return bool
    end   

    # Print the results in a sub text file (not Output.txt)
    def print
        file = File.new('./Games/Games.txt', "w")
        file.puts('(Game, Score, Time, Status)')
        file.puts((@records.length).to_s)
        index = 0         
        while (index < @records.length)
            file.puts("#{@records[index].game.chomp}, #{@records[index].score}, #{@records[index].time}, #{@records[index].status.chomp}")
            index += 1
        end
        file.close()
    end

    def needs_cursor?                                                             # Hide the default mouse pointer
        false
    end

    def button_down(id)
        if (@screen == 1)                         # When in the main screen
            if (id == Gosu::MsRight)              # Check if player right-click to the each game's button

                # Close the Main menu window and open each game window
                if (game1(mouse_x, mouse_y)) && (@screen_1 == 0)
                    close
                    GemsCollection.new(@records).show
                elsif (game2(mouse_x, mouse_y)) && (@screen_1 == 0)
                    close
                    StarWars.new(@records).show
                elsif (game3(mouse_x, mouse_y)) && (@screen_1 == 0)
                    close
                    Original2048.new(@records).show
                elsif (game4(mouse_x, mouse_y)) && (@screen_1 == 0)
                    close
                    OvercomingObstacles.new(@records).show
                
                # Check if player right-click to the information button
                elsif (Gosu.distance(mouse_x, mouse_y, 50, 750) <= 30)            
                    if (@screen_1 == 0)                                
                        @screen_1 = 1                                # Show the information speech bubble
                    elsif (@screen_1 == 1) && (id == Gosu::MsRight)
                        @screen_1 = 0                                # Hide the infomation speech bubble
        
                        # Renew the variables for the speech bubble
                        @info_x = 80
                        @info_y = 721
                    end
                elsif (Gosu.distance(mouse_x, mouse_y, 1150, 750) <= 30) && (@screen_1 == 0)        # Show the record screen
                    @screen = 2
                elsif (Gosu.distance(mouse_x, mouse_y, 1150, 50) <= 30) && (@screen_1 == 0)         # Exiting
                    print
                    close
                    Name.show
                end
            end
        elsif (@screen == 2)                                                      # When in viewing screen
            if (id == Gosu::MsRight)                                              # Check if player right-click to the back-to-home button
                if (Gosu.distance(mouse_x, mouse_y, 50, 50) <= 30)
                    @screen = 1
                elsif (Gosu.distance(mouse_x, mouse_y, 1150, 50) <= 30)           # Exiting
                    print
                    close
                    Name.show
                end
            end
        end
    end

    def draw

        # Intro screen drawing
        if (@screen == 0)
            draw_quad(1200, 800, Gosu::Color.argb(0xff_6e0b0b), 0, 800, Gosu::Color.argb(0xff_6e0b0b), 0, 400, Gosu::Color::BLACK, 1200, 400, Gosu::Color::BLACK, 0)
            
            # Make movement for the logos
            Gosu.draw_rect(0, 0, 600, 200, Gosu::Color::BLACK, 0)
            Gosu.draw_rect(600, 0, 600, 200, Gosu::Color::BLACK, -1)
            Gosu.draw_rect(0, 200, 600, 200, Gosu::Color::BLACK, -1)
            Gosu.draw_rect(600, 200, 600, 200, Gosu::Color::BLACK, 0)
            if (@x_1 >= 270)
                @x_1 -= 5
            else
                @y_1 -= 2 if (@y_1 >= 140)
            end
            if (@x_1 >= 310)
                @z_1 = -1
            else
                @z_1 = 0
            end
            @image_swinburne_logo.draw(@x_1, @y_1, @z_1)
            if (@x_2 <= 680)
                @x_2 += 5
            else
                @y_2 += 2 if (@y_2 <= 140)
            end
            if (@y_2 < 80)
                @z_2 = -1
            else
                @z_2 = 0
            end
            @image_moon_logo.draw(@x_2, @y_2, @z_2, 0.2, 0.2)

            @image_mp_1.draw(mouse_x, mouse_y, 0) if (mouse_y >= 0)
            @sound_intro.play(1.5) if (Gosu.milliseconds >= 250) && (Gosu.milliseconds < (250 + (50 / 3)))
            @screen = 1 if (Gosu.milliseconds >= 5000)                                  # Change to main screen after 5 seconds

        # Main screen drawing
        elsif (@screen == 1)
            @image_bloodmoon_background.draw(0, 0, 0)
            @song_menu.play(true)

            # Change the mouse pointer and effects when in the buttons
            if game1(mouse_x, mouse_y) && (@screen_1 == 0)
                Gosu.draw_rect(300, 210, 260, 200, Gosu::Color::CYAN, 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
                @font.draw('Gems Collection', 332, 421, 0, 1.0, 1.0, Gosu::Color::CYAN)
            elsif game2(mouse_x, mouse_y) && (@screen_1 == 0)
                Gosu.draw_rect(640, 210, 260, 200, Gosu::Color::YELLOW, 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
                @font.draw('Star Wars', 712, 425, 0, 1.0, 1.0, Gosu::Color::YELLOW)
            elsif game3(mouse_x, mouse_y) && (@screen_1 == 0)
                Gosu.draw_rect(300, 460, 260, 260, Gosu::Color.argb(0xff_ff3366), 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
                @font.draw('2048', 402, 730, 0, 1.0, 1.0, Gosu::Color.argb(0xff_ff3366))
            elsif game4(mouse_x, mouse_y) && (@screen_1 == 0)
                Gosu.draw_rect(640, 510, 260, 140, Gosu::Color.argb(0xff_32a85e), 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
                @font.draw('Overcoming Obstacles', 640, 715, 0, 1.0, 1.0, Gosu::Color.argb(0xff_32a85e))
            elsif ((Gosu.distance(mouse_x, mouse_y, 50, 750) <= 30) || (Gosu.distance(mouse_x, mouse_y, 1150, 750) <= 30) || (Gosu.distance(mouse_x, mouse_y, 1150, 50) <= 30)) && (@screen_1 == 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
            elsif (@screen_1 == 0)
                @image_mp_2.draw(mouse_x, mouse_y, 1) if (mouse_y >= 0)
            end
            @image_gems_collection.draw(310, 220, 0, 0.6, 0.6)
            @image_star_war.draw(650, 220, 0, 0.6, 0.6)
            @image_2048.draw(310, 470, 0, 0.6, 0.6)
            @image_overcoming_obstacles.draw(650, 520, 0, 0.6, 0.6)

            # Texts for the main screen
            @font.draw('GAMES MENU', 25, 44, 0, 1.8, 1.8, Gosu::Color::GREEN)
            @font.draw('-', 380, 30, 0, 3.0, 2.4, Gosu::Color::GREEN)
            @font.draw('BLOODMOON', 454, 10, 0, 3.6, 3.9, Gosu::Color::YELLOW)
            @font.draw('<i>(Author: MOON)</i>', 510, 145, 0, 0.9, 0.9, Gosu::Color::CYAN)
            @font.draw('Gems Collection', 350, 420, 0, 0.8, 0.8, Gosu::Color::GREEN) if (!game1(mouse_x, mouse_y)) || (@screen_1 == 1)
            @font.draw('Star Wars', 724, 420, 0, 0.8, 0.8, Gosu::Color.argb(0xff_0000aa)) if (!game2(mouse_x, mouse_y)) || (@screen_1 == 1)
            @font.draw('2048', 408, 730, 0, 0.8, 0.8, Gosu::Color.argb(0xff_00ccff)) if (!game3(mouse_x, mouse_y)) || (@screen_1 == 1)
            @font.draw('Overcoming Obstacles', 660, 730, 0, 0.8, 0.8, Gosu::Color.argb(0xff_dade68)) if (!game4(mouse_x, mouse_y)) || (@screen_1 == 1)
            @font.draw('<i>Right-click to choose your favorite game...</i>', 480, 772, 0, 0.5, 0.5, Gosu::Color::WHITE)

            # Draw some functional buttons
            @image_record_icon.draw_rot(1150, 750, 0)
            @image_info_icon.draw_rot(50, 750, 0)
            @image_exit_icon.draw_rot(1150, 50, 0)

            # Draw and make movement for information speech bubble
            if (@screen_1 == 1)
                if ((Gosu.distance(mouse_x, mouse_y, 50, 750) <= 30))
                    @image_mp_3.draw(mouse_x, mouse_y, 1) 
                else
                    @image_mp_2.draw(mouse_x, mouse_y, 1) if (mouse_y >= 0)
                end
                @image_speech_bubble.draw(@info_x, @info_y, 0, ((720 - @info_y) / 700.0), ((720 - @info_y) / 700.0)) if (@info_y < 720)
                if (@info_y > 20)
                    @info_y -= 20 
                else
                    @font.draw('<b>Hi !!!</b>', 580, 36, 0, 0.7, 0.7, Gosu::Color::BLACK)
                    @font.draw('<i>My name is Trung Kien Nguyen - MOON - Student ID 104053642 - Author of this program!!</i>', 180, 86, 0, 0.6, 0.6, Gosu::Color::BLACK)
                    @font.draw('<i>I am studying Bachelor of Computer Science, majoring in AI, at Swinburne University of Technology, sem 2, year 2022.</i>', 180, 122, 0, 0.6, 0.6, Gosu::Color::BLACK)
                    @font.draw('<i>This is the custom program for COS10009 Introduction to Programming - GAMES MENU of BLOODMOON</i>', 180, 158, 0, 0.6, 0.6, Gosu::Color::BLACK)
                    @font.draw('----------------------------------------------------------------------------------------------------------------------------------------', 250, 212, 0, 0.6, 0.6, Gosu::Color::BLACK)
                    @font.draw('<b>Resources and media used in this program:</b>', 210, 266, 0, 0.6, 0.6, Gosu::Color::BLACK)
                    @font.draw('<i>Main Resources: Learn Game Programming with Ruby - Bring your ideas to life with Gosu - Mark Sobkowicz</i>', 180, 304, 0, 0.6, 0.6, Gosu::Color::BLACK)
                    @font.draw('<i>Images: Most from                              and                                                                              (Google Image)</i>', 180, 340, 0, 0.6, 0.6, Gosu::Color::BLACK)
                    @font.draw('<i>openclipart.com         google.com.au/imghp?hl=en&authuser=0&ogbl</i>', 327, 340, 0, 0.6, 0.6, Gosu::Color.argb(0xff_1338be))
                    @font.draw('<i>Songs and sounds: Most from                          ,                       , Star Wars films, Geometry Dash, ...</i>', 180, 376, 0, 0.6, 0.6, Gosu::Color::BLACK)
                    @font.draw('<i>freesound.org   youtube.com</i>', 411, 376, 0, 0.6, 0.6, Gosu::Color.argb(0xff_1338be))
                    @font.draw('----------------------------------------------------------------------------------------------------------------------------------------', 250, 430, 0, 0.6, 0.6, Gosu::Color::BLACK)
                    @font.draw('<b>Hope you enjoy my games!!!</b>', 484, 484, 0, 0.7, 0.7, Gosu::Color::BLACK)

                    @font.draw('Rightclick here again to ', 100, 740, 0, 0.4, 0.4, Gosu::Color::WHITE)
                    @font.draw(' close the info bubble!!!', 100, 756, 0, 0.4, 0.4, Gosu::Color::WHITE)
                end
            end
        elsif (@screen == 2)
            @song_high_score.play(true)
            @image_bloodmoon_background.draw(0, 0, 0)

            # Draw the back-to-home and exit icons and change the mouse pointer
            @image_home_icon.draw_rot(50, 50, 0)
            @image_exit_icon.draw_rot(1150, 50, 0)
            if (Gosu.distance(mouse_x, mouse_y, 50, 50) <= 30) || (Gosu.distance(mouse_x, mouse_y, 1150, 50) <= 30) 
                @image_mp_3.draw(mouse_x, mouse_y, 1)
            else
                @image_mp_2.draw(mouse_x, mouse_y, 1) if (mouse_y >= 0)
            end

            # Display in detail all player's previous plays!!!
            @font.draw('<b>Viewing details of your plays!!   :D</b>', 300, 15, 0, 1.5, 1.5, Gosu::Color::WHITE)
            @font.draw('Games name', 76, 120, 0, 1.0, 1.0, Gosu::Color::CYAN)
            @font.draw('Score', 425, 120, 0, 1.0, 1.0, Gosu::Color::WHITE)
            @font.draw('Playing Time', 670, 120, 0, 1.0, 1.0, Gosu::Color::YELLOW)
            @font.draw('Victory/Defeat', 965, 120, 0, 1.0, 1.0, Gosu::Color::GREEN)
            Gosu.draw_rect(310, 115, 4, 630, Gosu::Color::WHITE, 0)
            @image_arrow_icon.draw_rot(312, 105, 0, 0)
            @image_arrow_icon.draw_rot(312, 755, 0, 180)
            Gosu.draw_rect(600, 115, 4, 630, Gosu::Color::WHITE, 0)
            @image_arrow_icon.draw_rot(602, 105, 0, 0)
            @image_arrow_icon.draw_rot(602, 755, 0, 180)
            Gosu.draw_rect(890, 115, 4, 630, Gosu::Color::WHITE, 0)
            @image_arrow_icon.draw_rot(892, 105, 0, 0)
            @image_arrow_icon.draw_rot(892, 755, 0, 180)
            Gosu.draw_rect(40, 175, 1120, 4, Gosu::Color::WHITE, 0)
            @image_arrow_icon.draw_rot(30, 177, 0, 270)
            @image_arrow_icon.draw_rot(1170, 177, 0, 90)
            if (@records.length != 0)
                count = @records.length - 1
                index = 0
                while (count >= (@records.length - 9)) && (count >= 0)
                    index += 1
                    @font.draw("<i>#{@records[count].game}</i>", 20, 150 + 60 * index, 0, 1.0, 1.0, Gosu::Color::CYAN)
                    @font.draw("<i>#{@records[count].score}</i>", 440, 150 + 60 * index, 0, 1.0, 1.0, Gosu::Color::WHITE)
                    @font.draw("<i>#{@records[count].time}s</i>", 720, 150 + 60 * index, 0, 1.0, 1.0, Gosu::Color::YELLOW)
                    @font.draw("<i>#{@records[count].status}</i>", 1000, 150 + 60 * index, 0, 1.0, 1.0, Gosu::Color::GREEN)
                    count -= 1
                end
            end
        end
    end
end