require './Games/Game_1/Rock.rb'
require './Games/Game_1/Buttons_click.rb'

class GemsCollection < Gosu::Window
    attr_accessor :records

    def initialize(records)
        super(800, 600)
        self.caption = 'Gems Collection'

        # Set up variables for media (images, songs, sounds, fonts)
        @gemmining = Gosu::Image.new('Media/Image_Gem_Mining.png')
        @question = Gosu::Image.new('Media/Image_Question.png')
        @underground = Gosu::Image.new('Media/Image_Underground.jpg')
        @easy_image = Gosu::Image.new('Media/Image_Easy_Button.png')
        @hard_image = Gosu::Image.new('Media/Image_Hard_Button.png')
        @image_mp_2 = Gosu::Image.new('Media/Image_Mouse_pointer_2.png')
        @image_mp_3 = Gosu::Image.new('Media/Image_Mouse_pointer_3.png')
        @emerald = Gosu::Image.new('Media/Image_Emerald.png')
        @ruby = Gosu::Image.new('Media/Image_Ruby.png')
        @sapphire = Gosu::Image.new('Media/Image_Sapphire.png')
        @danburite = Gosu::Image.new('Media/Image_Danburite.png')
        @amethyst = Gosu::Image.new('Media/Image_Amethyst.png')
        @hammer = Gosu::Image.new('Media/Image_Hammer.png')
        @start_song = Gosu::Song.new('Media/Song_How_it_Begins.wav')
        @game_song_1 = Gosu::Song.new('Media/Song_Mining_by_Moonlight.wav')
        @game_song_2 = Gosu::Song.new('Media/Song_GD_The_seven_seas.wav')
        @end_song = Gosu::Song.new('Media/Song_Chill.wav')
        @collect_sound = Gosu::Sample.new('Media/Sound_Collecting.wav')
        @wrong_sound = Gosu::Sample.new('Media/Sound_Wrong.wav')
        @font = Gosu::Font.new(30)

        # Set up variables used for playing this game
        @x_0 = @x_1 = @x_2 = @x_3 = @x_4 = 400
        @y_0 = @y_1 = @y_2 = @y_3 = @y_4 = 300
        @v_x_0 = @v_y_0 = 1
        @v_x_1 = @v_y_1 = 3
        @v_x_2 = @v_y_2 = 5
        @v_x_3 = @v_y_3 = 7
        @v_x_4 = @v_y_4 = 15
        @visible_0 = @visible_1 = @visible_2 = @visible_3 = @visible_4 = 0
        @rocks = []
        @screen = 0                                                                       # Set up screen variable
        @level = 0                                                                        # Set up level variable
        @hit = @score = @start_time = 0
        @instruction_y = @instruction_y_index = 0

        # Set up variables for recording process
        @count_index = 0
        @records = records
    end

    def rocks_clicking(mouse_x, mouse_y)                                                   # Check if player click in the rocks
        bool = false
        if (@rocks.size >= 1)
            @rocks.dup.each do |rock|
                bool = true if (Gosu.distance(mouse_x, mouse_y, rock.x, rock.y) < (25 * rock.ratio))
            end
        end
        return bool
    end

    def needs_cursor?                                                                      # Hide the default mouse pointer
        false
    end
    
    def button_down(id)
        if (@screen == 1)                                                                  # When in playing screen
            if (id == Gosu::MsLeft) || (id == Gosu::MsRight)                               # Check if the player click in objects
                # Check if the player click in the emerald
                if (Gosu.distance(mouse_x, mouse_y, @x_0, @y_0) < 50) && (@visible_0 >= 0) && (!rocks_clicking(mouse_x, mouse_y))
                    @score += 1 + @level
                    @hit = 1
                # Check if the player click in the ruby
                elsif (Gosu.distance(mouse_x, mouse_y, @x_1, @y_1) < 50) && (@visible_1 >= 0) && (!rocks_clicking(mouse_x, mouse_y))
                    @score += 3 + @level
                    @hit = 1
                # Check if the player click in the sapphire
                elsif (Gosu.distance(mouse_x, mouse_y, @x_2, @y_2) < 50) && (@visible_2 >= 0) && (!rocks_clicking(mouse_x, mouse_y))
                    @score += 5 + @level
                    @hit = 1
                # Check if the player click in the danburite
                elsif (Gosu.distance(mouse_x, mouse_y, @x_3, @y_3) < 50) && (@visible_3 >= 0) && (!rocks_clicking(mouse_x, mouse_y))
                    @score += 7 + @level
                    @hit = 1
                # Check if the player click in the amethyst
                elsif (Gosu.distance(mouse_x, mouse_y, @x_4, @y_4) < 60) && (@visible_4 >= 0) && (@time <= 5) && (!rocks_clicking(mouse_x, mouse_y))
                    @score += 15 + @level
                    @hit = 1
                # Check if the player click in the rocks
                elsif (rocks_clicking(mouse_x, mouse_y))
                    @score -= 2
                    @hit = -1
                else
                    @score -= 1
                    @hit = -1
                end
            end
        elsif (@screen == 0)                                                 # When in opening screen
            if (id == Gosu::MsLeft)                                          # Check if player want to turn to playing screen
                if (easy_click(mouse_x, mouse_y)) || (hard_click(mouse_x, mouse_y))
                    @screen = 1
                    @score = @visible_0 = @visible_1 = @visible_2 = @visible_3 = @visible_4 = 0
                    @start_time = Gosu.milliseconds
                    if easy_click(mouse_x, mouse_y)
                        @level = 0
                    elsif hard_click(mouse_x, mouse_y)
                        @level = 1
                    end
                end
            elsif (id == Gosu::KbJ)                                          # Check if player want to turn to instruction screen
                @screen = -1
                @instruction_y = 250
                @instruction_y_index = 0
            end    
        end
        if (id == Gosu::KbK) && (@screen != 0)                               # Check if player want to turn to opening screen
            @screen = 0
            @count_index = 0
            @rocks.dup.each do |rock|
                @rocks.delete rock
            end
        elsif (id == Gosu::KbEscape)                                        # Check if player want to turn to escape this game and back to main menu
            close
            Menu.new(1, @records).show
        end
    end

    def update
        if (@screen == -1)                                                  # Instruction screen
            # Make movement for the instructions text
            if (@instruction_y >= -270)
                @instruction_y_index += 1
                @instruction_y_index = 0 if (@instruction_y_index == 500)
                @instruction_y -= 1 if ((@instruction_y_index % 5) == 1)
            else
                @instruction_y = 285
                @instruction_y_index = 0 if (@instruction_y_index == 500)
            end
        elsif (@screen == 1)                                                # Playing screen
            # Update the playing time
            @time = (30 - ((Gosu.milliseconds - @start_time) / 1000))

            # Move the objects
            @x_0 += @v_x_0
            @y_0 += @v_y_0
            @x_1 += @v_x_1
            @y_1 += @v_y_1
            @x_2 += @v_x_2
            @y_2 += @v_y_2
            @x_3 += @v_x_3
            @y_3 += @v_y_3

            # Change the direction of objects if the object collides with the boundary
            @v_x_0 *= -1 if (@x_0 - 40 > 720) || (@x_0 - 40 < 0)
            @v_y_0 *= -1 if (@y_0 - 34 > 532) || (@y_0 - 34 < 0)
            @v_x_1 *= -1 if (@x_1 - 40 > 720) || (@x_1 - 40 < 0)
            @v_y_1 *= -1 if (@y_1 - 30 > 540) || (@y_1 - 30 < 0)
            @v_x_2 *= -1 if (@x_2 - 29 > 742) || (@x_2 - 29 < 0)
            @v_y_2 *= -1 if (@y_2 - 42 > 516) || (@y_2 - 42 < 0)
            @v_x_3 *= -1 if (@x_3 - 42 > 716) || (@x_3 - 42 < 0)
            @v_y_3 *= -1 if (@y_3 - 40 > 520) || (@y_3 - 40 < 0)

            if (@time <= 5)
                @x_4 += @v_x_4
                @y_4 += @v_y_4
                @v_x_4 *= -1 if (@x_4 - 50 > 700) || (@x_4 - 50 < 0)
                @v_y_4 *= -1 if (@y_4 - 49 > 502) || (@y_4 - 49 < 0)
                @visible_4 -= 1
                @visible_4 = 20 if (@visible_4 < -10)
            end

            # Check if the gems is visible or not
            @visible_0 -= 1
            @visible_1 -= 1
            @visible_2 -= 1
            @visible_3 -= 1
            @visible_0 = 20 if (@visible_0 < -10)
            @visible_1 = 20 if (@visible_1 < -10)
            @visible_2 = 20 if (@visible_2 < -10)
            @visible_3 = 20 if (@visible_3 < -10)

            if (@level == 1)
                # Set up and make movement for the rocks
                @rocks.push Rock.new(self) if (@rocks.size <= 10)
                @rocks.each do |rock|
                    rock.move
                end
            end
        end
    end

    def draw
        if (@screen == 0)                                                  # Opening screen drawing
            @gemmining.draw(0, 0, 0)
            @start_song.play(true)
            
            @font.draw('Collecting', 160, 145, 0, 1.8, 1.8, Gosu::Color::AQUA)
            @font.draw('GEMS!!!', 400, 140, 0, 2.4, 2.4, Gosu::Color::FUCHSIA)
            @font.draw('<i>(Author: MOON)</i>', 300, 228, 0, 1.0, 1.0, Gosu::Color::RED)
            @font.draw('<i>Press J key for Instruction or</i>', 300, 415, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @font.draw('<i>Left-click choose the level...</i>', 305, 440, 0, 0.6, 0.6, Gosu::Color::GRAY)

            # If the player moves the mouse to the level buttons
            if easy_click(mouse_x, mouse_y)
                Gosu.draw_rect(190, 290, 170, 75, Gosu::Color::YELLOW, 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
            elsif hard_click(mouse_x, mouse_y)
                Gosu.draw_rect(440, 290, 170, 75, Gosu::Color::RED, 0)
                @image_mp_3.draw(mouse_x, mouse_y, 1)
            # Or else ...
            else
                @image_mp_2.draw(mouse_x, mouse_y, 1) if (mouse_y >= 0)
            end
            @easy_image.draw(200, 300, 0)
            @hard_image.draw(450, 300, 0)
        elsif (@screen == -1)                                              # Instruction screen drawing
            @question.draw(0, 0, 1)
            Gosu.draw_rect(0, 264, 800, 6, Gosu::Color::BLACK, 1)

            # The instructions text
            @font.draw('Click on the diffrent gems to get different numbers of point.', 15, @instruction_y + 300, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @font.draw('Clicking on rocks (in hard level only), or on places other than gems will get 1 score minus.', 15, @instruction_y + 325, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @font.draw('Earn 80 scores in 30 seconds to win the game.', 15, @instruction_y + 350, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @font.draw('At any time, press K key to return to the Gem-collecting Menu, or Esc key to the Main Menu.', 15, @instruction_y + 375, 0, 0.6, 0.6, Gosu::Color::GRAY)
            @emerald.draw(40, @instruction_y + 420, 0)
            @ruby.draw(180, @instruction_y + 423, 0)
            @sapphire.draw(337, @instruction_y + 410, 0)
            @danburite.draw(479, @instruction_y + 415, 0)
            @amethyst.draw(650, @instruction_y + 405, 0)
            @font.draw('for 1                   for 3                     for 5                     for 7                           for 15', 60, @instruction_y + 515, 0, 0.7, 0.7, Gosu::Color::GRAY)
            @font.draw('(only in the last 5 seconds)', 620, @instruction_y + 540, 0, 0.5, 0.5, Gosu::Color::GRAY)
            Gosu.draw_rect(0, 560, 800, 40, Gosu::Color::BLACK, 1)
            @font.draw('<i>Ready? Press K key to begin..</i>', 245, 560, 1, 1.0, 1.0, Gosu::Color::WHITE)

        elsif (@screen == 1)                                                    # Playing screen drawing
            if (@level == 0)
                @game_song_1.play(true)
            elsif (@level == 1)
                @game_song_2.play(true)
            end
            @underground.draw(0, 0, 0)

            @font.draw('Your score: ' + @score.to_s + '/80', 20, 20, 0, 1.0, 1.0, Gosu::Color::WHITE)
            if (@time > 5)
                @font.draw('Remaining time: ' + @time.to_s, 20, 560, 0, 1.0, 1.0, Gosu::Color::FUCHSIA)
            else
                if (rand(1-100) < 30) && ((Gosu.milliseconds - @start_time) / 1000 >= 25)
                    @font.draw('Remaining time: ' + @time.to_s, 20, 560, 0, 1.0, 1.0, Gosu::Color::FUCHSIA)
                elsif ((Gosu.milliseconds - @start_time) / 1000 >= 30)
                    @screen = 2                             # Change to ending screen if the time is out
                end
            end

            @screen = 2 if (@score >= 80)                   # Change to ending screen if player get enough score

            # Draw the gems
            @emerald.draw(@x_0 - 40, @y_0 - 34, 0) if (@visible_0 >= 0)
            @ruby.draw(@x_1 - 40, @y_1 - 30, 0) if (@visible_1 >= 0)
            @sapphire.draw(@x_2 - 29, @y_2 - 42, 0) if (@visible_2 >= 0)
            @danburite.draw(@x_3 - 42, @y_3 - 40, 0) if (@visible_3 >= 0)
            @amethyst.draw(@x_4 - 50, @y_4 - 49, 0) if (@visible_4 >= 0) && (@time <= 5)

            if (@level == 1)
                # Draw the rocks
                @rocks.each do |rock|
                    rock.draw
                end
            end

            # Draw the hammer mouse pointer
            @hammer.draw(mouse_x - 70, mouse_y - 25, 0)

            # Check clicking in gems or other
            if (@hit == 0)
                c = Gosu::Color::NONE
            elsif (@hit == 1)
                c = Gosu::Color::GREEN
                @collect_sound.play
            elsif (@hit == -1)
                c = Gosu::Color::RED
                @wrong_sound.play(5.0)
            end

            draw_quad(0, 0, c, 800, 0, c, 0, 600, c, 800, 600, c, 0)
            @hit = 0

        elsif (@screen == 2)                                               # Ending screen drawing
            @end_song.play(true)
            draw_quad(0, 0, Gosu::Color::CYAN, 800, 0, Gosu::Color::RED, 0, 600, Gosu::Color::GREEN, 800, 600, Gosu::Color::YELLOW, 0)
            @font.draw('<b>GAME OVER</b>', 190, 100, 0, 2.7, 2.7, Gosu::Color::BLACK)
            if (@score >= 80) 
                @font.draw('Congratulation, your score is ' + @score.to_s  + '! ', 218, 290, 0, 1.0, 1.0, Gosu::Color::GREEN)
                @font.draw('<i>Press the K key to play again! :D</i>'.to_s, 210, 380, 0, 1.0, 1.0, Gosu::Color::BLUE)

                # Recording the result if you win
                if (@count_index == 0)
                    @records.push Record.new('     Gems Collection', @score, 30 - @time, 'Victory')
                    @count_index += 1
                end
            else
                @font.draw('Time out, your score is ' + @score.to_s, 255, 290, 0, 1.0, 1.0, Gosu::Color::GREEN)
                @font.draw('<i>Press the K key to try again! :D</i>'.to_s, 215, 380, 0, 1.0, 1.0, Gosu::Color::BLUE)

                # Recording the result if you lose
                if (@count_index == 0)
                    @records.push Record.new('     Gems Collection', @score, 30 - @time, 'Defeat')
                    @count_index += 1
                end
            end
        end
    end
end