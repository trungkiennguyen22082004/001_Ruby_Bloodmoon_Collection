require './Games/Game_2/Player.rb'
require './Games/Game_2/Enemy.rb'
require './Games/Game_2/Bullet.rb'
require './Games/Game_2/Heart.rb'
require './Games/Game_2/Explosion.rb'

class StarWars < Gosu::Window
    attr_accessor :records

    def initialize(records)
        super(800, 600)
        self.caption = 'Star Wars'

        @question = Gosu::Image.new('Media/Image_Question.png')
        @space_0 = Gosu::Image.new('Media/Image_Space_0.jpg')
        @space_1 = Gosu::Image.new('Media/Image_Space_1.jpg')
        @space_2 = Gosu::Image.new('Media/Image_Space_2.jpg')
        @spaceship = Gosu::Image.new('Media/Image_X-wing.png')
        @enemy = Gosu::Image.new('Media/Image_TIE.png')
        @heart_0 = Gosu::Image.new('Media/Image_Heart.png')
        @great_enemy = Gosu::Image.new('Media/Image_Star_Destroyer.png')
        @large_explosions = Gosu::Image.load_tiles('Media/Image_Large_Explosions.png', 200, 200)
        @start_music = Gosu::Song.new('Media/Song_Star_Wars_Main_Theme.wav')
        @instruction_music = Gosu::Song.new('Media/Song_Star_Wars_Ancient_Sith_Theme.wav')
        @game_music = Gosu::Song.new('Media/Song_Star_Wars_Battle_of_The_Heroes.wav')
        @last_music = Gosu::Song.new('Media/Song_Star_Wars_The_Empire_Theme.ogg')
        @end_music = Gosu::Song.new('Media/Song_Star_Wars_Light_of_the_Force.wav')
        @shooting_sound = Gosu::Sample.new('Media/Sound_Laser_Shoot.wav')
        @small_explosion_sound = Gosu::Sample.new('Media/Sound_Small_Explosion.wav')
        @large_explosion_sound = Gosu::Sample.new('Media/Sound_Large_Explosion.wav')
        @collect_sound = Gosu::Sample.new('Media/Sound_Collecting.wav')
        @font = Gosu::Font.new(30)

        # Set up variables used for playing this game
        @y = 43
        @player = Player.new(self)
        @bullets = []
        @enemies = []
        @explosions = []
        @hearts = []
        @score = @start_time = @i = @j = @k = 0
        @life = 5
        @screen = 0
        @instruction_y = @instruction_y_index = 0

        # Set up variables for recording process
        @count_index = 0
        @records = records
    end

    def needs_cursor?
        false
    end
    
    def button_down(id)
        if (@screen == 1)
            if (id == Gosu::KbZ)
                @bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)             
                @shooting_sound.play(0.3)
            end
        elsif (@screen == -1)
            if (id == Gosu::KbSpace)
                @screen = 1

                @player.setup
                @i = @j = @k = @score = 0
                @start_time = Gosu.milliseconds
                @life = 5
                @y = 43
            end
        elsif (@screen == 0)
            if (id == Gosu::KbSpace)
                @screen = 1

                @player.setup
                @i = @j = @k = @score = 0
                @start_time = Gosu.milliseconds
                @life = 5
                @y = 43
            elsif (id == Gosu::KbJ)
                @screen = -1
                @instruction_y = 220
                @instruction_y_index = 0
            end
        end
        if (id == Gosu::KbK) && (@screen != 0)
            @screen = 0
            @count_index = 0
        elsif (id == Gosu::KbEscape)
            close
            Menu.new(1, @records).show
        end
    end

    def update
        if (@screen == -1)                                          # Instruction screen
            # Make movement for the instructions
            if (@instruction_y >= -271)
                @instruction_y_index += 1
                @instruction_y_index = 0 if (@instruction_y_index == 500)
                @instruction_y -= 1 if ((@instruction_y_index % 5) == 1)
            else
                @instruction_y = 258
                @instruction_y_index = 0 if (@instruction_y_index == 500)
            end
        elsif (@screen == 1)                                        # Playing screen
            @player.turn_right if button_down?(Gosu::KbRight) or button_down?(Gosu::KbD)
            @player.turn_left if button_down?(Gosu::KbLeft) or button_down?(Gosu::KbA)
            @player.accelerate if button_down?(Gosu::KbUp) or button_down?(Gosu::KbW)
            @player.decelerate if button_down?(Gosu::KbDown) or button_down?(Gosu::KbS)
            @player.move
            @bullets.each do |bullet|
                bullet.move
            end
            @enemies.push Enemy.new(self) if (rand < 0.04) && (@enemies.size < 5)
            @enemies.each do |enemy|
                enemy.move
            end
            @hearts.push Heart.new(self) if rand(1-5000) <= 2
            @hearts.each do |heart|
                heart.move
            end
            @enemies.dup.each do |enemy|
                @bullets.dup.each do |bullet|
                    if (Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y) < 24)
                        @enemies.delete enemy
                        @bullets.delete bullet
                        @explosions.push Explosion.new(self, enemy.x, enemy.y)
                        @score += 3
                        @small_explosion_sound.play(0.7)
                    end
                end
                if (Gosu.distance(enemy.x, enemy.y, @player.x, @player.y) < 40)
                    @enemies.delete enemy
                    @explosions.push Explosion.new(self, enemy.x, enemy.y)
                    @life -= 1
                    @score -= 1
                    @small_explosion_sound.play(0.7)
                end
            end
            @hearts.dup.each do |heart|
                if (Gosu.distance(@player.x, @player.y, heart.x, heart.y) < 48)
                    @life += 1
                    @hearts.delete heart
                    @collect_sound.play
                end
            end
            @explosions.dup.each do |explosion|
                @explosions.delete explosion if (explosion.j)
            end
            @screen = 2 if @life <= 0
            @enemies.dup.each do |enemy|
                @enemies.delete enemy if (enemy.y > 600)
            end
            @bullets.dup.each do |bullet|
                @bullets.delete bullet if (bullet.x > 800) || (bullet.x < 0) || (bullet.y < 0)
            end

            @time = (30 - ((Gosu.milliseconds - @start_time) / 1000)).to_i
            if (@time <= 10)
                @y += 1
                if (Gosu.distance(@player.x, @player.y, 400, @y) < 100) && (@i < 20)
                    @life -= 5
                    @large_explosion_sound.play
                end
                @bullets.dup.each do |bullet|
                    if ((Gosu.distance(bullet.x, bullet.y, 400, @y) < 50) && (@i < 20))   
                        @bullets.delete bullet
                        @i += 1
                    end
                end
            end
        end
    end

    def draw
        if (@screen == 0)
            @start_music.play(true)
            @space_0.draw(0, 0, 0)
            @font.draw('Welcome to ', 60, 100, 0, 2.0, 2.0, Gosu::Color::AQUA)
            @font.draw('STAR WARS', 370, 90, 0, 2.4, 2.4, Gosu::Color::YELLOW)
            @font.draw('<i>(Author: MOON)</i>', 258, 210, 0, 1.4, 1.4, Gosu::Color::RED)
            @font.draw('<i>Press J key for Instruction or</i>', 248, 385, 0, 0.9, 0.9, Gosu::Color::GREEN)
            @font.draw('<i>Press Space bar to begin...</i>', 257, 430, 0, 0.9, 0.9, Gosu::Color::GREEN)
        elsif (@screen == -1)
            @instruction_music.play(true)
            @question.draw(0, 0, 1)

            # Instruction text
            @font.draw('-> The game lasts for 30 seconds. You will have 5 lives. Earn 80 scores to win.', 20, @instruction_y + 280, 0, 0.5, 0.5, Gosu::Color::GRAY)
            @font.draw('-> Move Your ship              with the Left, Right, Up and Down arrow keys (or A, D, W, S keys respectively).', 20, @instruction_y + 310, 0, 0.5, 0.5, Gosu::Color::GRAY)
            @spaceship.draw(140, @instruction_y + 295, 0, 0.7, 0.7)
            @font.draw('-> Shoot Enemy ships           by pressing the Z key and earn 3 score for each.', 20, @instruction_y + 340, 0, 0.5, 0.5, Gosu::Color::GRAY)
            @font.draw('If your ship crashes into an enemy, your will lose 1 life. When your life is 0, you will lose the game.', 20, @instruction_y + 370, 0, 0.5, 0.5, Gosu::Color::GRAY)
            @enemy.draw(160, @instruction_y + 335, 0, 0.7, 0.7)
            @font.draw('-> In the last 10 seconds, the enemy mother ship                 will be deployed.', 20, @instruction_y + 400, 0, 0.5, 0.5, Gosu::Color::GRAY)
            @font.draw('Shoot it 20 times to earn 15 scores. Be careful, if your ship crashed into the mother ship, you will lose the game.', 20, @instruction_y + 430, 0, 0.5, 0.5, Gosu::Color::GRAY)
            @font.draw('-> You will get an extra life if your ship gets one          from space.', 20, @instruction_y + 460, 0, 0.5, 0.5, Gosu::Color::GRAY)
            @font.draw('-> At any time, press K key to return to the Star wars Menu, or Esc to the Main Menu.', 20, @instruction_y + 490, 0, 0.5, 0.5, Gosu::Color::GRAY)
            @font.draw('-> Good luck !!!', 20, @instruction_y + 520, 0, 0.5, 0.5, Gosu::Color::GRAY)
            @heart_0.draw(310, @instruction_y + 456, 0, 0.5, 0.5)
            @great_enemy.draw(321, @instruction_y + 398, 0, 0.2, 0.2)
            Gosu.draw_rect(0, 538, 800, 70, Gosu::Color::BLACK, 1)
            @font.draw('<i>Press Space bar to begin...</i>', 257, 570, 1, 0.9, 0.9, Gosu::Color::WHITE)
        elsif (@screen == 1)
            if (@time >= 12)
                @game_music.play(true)
            else
                @last_music.play(true) 
            end
            @space_1.draw(0, 0, 0)
            @player.draw
            @bullets.each do |bullet|
                bullet.draw
            end
            @enemies.each do |enemy|
                enemy.draw
            end
            @hearts.each do |heart|
                heart.draw
            end
            @explosions.each do |explosion|
                explosion.draw
            end
            @font.draw('Your score: ' + @score.to_s + '/80', 20, 20, 0, 1.0, 1.0, Gosu::Color::WHITE)
            @font.draw(@life.to_s + 'x', 680, 15, 0, 1.5, 1.5, Gosu::Color::RED)
            @heart_0.draw(740, 12, 0)
            if (@time > 10)
                @font.draw('Remaining time: ' + @time.to_s, 20, 560, 0, 1.0, 1.0, Gosu::Color::FUCHSIA)
            else
                if (rand(1-100) < 30) && ((Gosu.milliseconds - @start_time) / 1000 >= 20)
                    @font.draw('Remaining time: ' + @time.to_s, 20, 560, 0, 1.0, 1.0, Gosu::Color::FUCHSIA)
                elsif ((Gosu.milliseconds - @start_time) / 1000 > 30)
                    @screen = 2
                end
            end
            if (@time <= 10)
                @great_enemy.draw_rot(400, @y, 0) if (@i < 20) && (@k == 0)
                if (@i == 20) && (@k == 0)
                    if (@j < @large_explosions.count)
                        @large_explosions[@j].draw_rot(400, @y, 0)
                        @j += 1
                    end
                    @large_explosion_sound.play
                    @score += 15
                    @k = 1
                end
            end
            @screen = 2 if (@score >= 80)    
        elsif (@screen == 2)
            @enemies.dup.each do |enemy|
                @enemies.delete enemy
            end
            @bullets.dup.each do |bullet|
                @bullets.delete bullet
            end
            @explosions.each do |explosion|
                @explosions.delete explosion
            end
            @end_music.play(true)
            @space_2.draw(0, 0, 0)
            @font.draw('GAME OVER', 250, 100, 0, 1.8, 1.8, Gosu::Color::WHITE)
            if (@score >= 80)
                @font.draw('Congratulation, your score is ' + @score.to_s  + '! ', 220, 470, 0, 1.0, 1.0, Gosu::Color::GREEN)
                @font.draw('  Press K key to play again!!!'.to_s, 225, 530, 0, 1.0, 1.0, Gosu::Color::BLUE)
                if (@count_index == 0)
                    @records.push Record.new('         Star Wars', @score, 30 - @time, 'Victory')
                    @count_index += 1
                end
            elsif (@life <= 0)
                @font.draw('Oops!! Your ship is destroyed, your score is ' + @score.to_s, 120, 470, 0, 1.0, 1.0, Gosu::Color::GREEN)
                @font.draw(' Press K key to try again!!! :D'.to_s, 215, 530, 0, 1.0, 1.0, Gosu::Color::BLUE)
                if (@count_index == 0)
                    @records.push Record.new('         Star Wars', @score, 30 - @time, 'Defeat')
                    @count_index += 1
                end
            else
                @font.draw('Time out, your score is ' + @score.to_s, 250, 470, 0, 1.0, 1.0, Gosu::Color::GREEN)
                @font.draw('Press K key to try again :D'.to_s, 240, 530, 0, 1.0, 1.0, Gosu::Color::BLUE)
                if (@count_index == 0)
                    @records.push Record.new('         Star Wars', @score, 30 - @time, 'Defeat')
                    @count_index += 1
                end
            end
        end
    end
end