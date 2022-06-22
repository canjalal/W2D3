require_relative "board"
require_relative "human_player"

class Game 

    attr_reader :currentPlayer, :otherPlayer
    def initialize(player_1_mark, player_2_mark)
        @player_1_mark = player_1_mark
        @player_2_mark = player_2_mark

        @player1 = HumanPlayer.new(@player_1_mark)
        @player2 = HumanPlayer.new(@player_2_mark)
        @currentPlayer = @player1
        @otherPlayer = @player2
        puts "Welcome to the game!"
    end

    def switch_turn 
        @currentPlayer, @otherPlayer = @otherPlayer, @currentPlayer
    end

    def play

        @board1 = Board.new

        while(@board1.empty_positions?)
            @board1.print

            begin

                currpos = @currentPlayer.get_position

            rescue ArgumentError => err
                puts err.message
                puts "\n Try again, shall we? \n"
                retry
            end

            begin

                @board1.place_mark(currpos, @currentPlayer.mark_value)

            rescue WrongPositionError => e
                puts e.message

                puts "\nLet\'s try again.\n"

                @board1.print

                currpos = @currentPlayer.get_position

                retry

            end

            if(@board1.win?(@currentPlayer.mark_value))
                puts "\nPlayer with mark #{@currentPlayer.mark_value} has won! Congrats"
                return "Se acabó el juego"
            else
                self.switch_turn
            end
        end

        puts "No one won, it was a draw. Sorrey peeps"




    end
end