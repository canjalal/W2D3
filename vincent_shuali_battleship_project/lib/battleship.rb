require_relative "board"
require_relative "player"

class Battleship
    attr_reader :board, :player
    def initialize(n)
        @player = Player.new

        @board = Board.new(n)
        @remaining_misses = n*n/2
    end

    def start_game
        @board.place_random_ships
        puts @board.num_ships
        p @board.print
    end

    def lose?
        if(@remaining_misses <= 0)
            puts "you lose"
            true
        else
            false
        end
    end

    def win?
        if(@board.num_ships == 0)
            puts "you win"
            true
        else
            false
        end
    end

    def game_over?
        self.win? || self.lose? ? true : false
    end

    def turn
        @board.print
        if (!@board.attack(@player.get_move))
            @remaining_misses -= 1
        end
        puts "You have #{@remaining_misses} misses left"

    end

end
