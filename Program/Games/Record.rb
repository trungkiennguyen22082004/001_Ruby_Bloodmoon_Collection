# Class to record the information of played game
class Record
    attr_accessor :game, :score, :time, :status

    def initialize(game, score, time, status)
        @game = game
        @score = score
        @time = time
        @status = status
    end
end