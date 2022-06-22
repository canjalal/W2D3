require_relative "board"
require_relative "human_player"
require_relative "computer_player"

class Game 

    attr_reader :currentPlayerIndex, :board1
    def initialize(boarddim, playerhash)
        # player hash format: key: symbol of their mark. value: computer or not
        @playermarksarray = playerhash.keys
        @boarddim = boarddim
        @player = @playermarksarray.map {|mark| playerhash[mark] ? ComputerPlayer.new(mark) : HumanPlayer.new(mark)}
        @currentPlayerIndex = 0
        @currentPlayer = @player[@currentPlayerIndex]

        begin
            @board1 = Board.new(@boarddim)
        rescue ArgumentError => e

            puts e.message
            puts "\n Enter a new board size:\n"

            @boarddim = gets.chomp.to_i

            retry

        end
        puts "Welcome to the game!"
    end

    def switch_turn 
        @currentPlayerIndex += 1
        @currentPlayerIndex = 0 if(@currentPlayerIndex == @player.size)
        @currentPlayer = @player[@currentPlayerIndex]
    end

    def play

        while(@board1.empty_positions?)
            @board1.print

            begin

                currpos = @currentPlayer.get_position(@board1.legal_positions)

            rescue ArgumentError => err
                puts err.message
                puts "\nTry again, shall we? \n"
                retry
            end

            # begin

            @board1.place_mark(currpos, @currentPlayer.mark_value)

            # rescue WrongPositionError => e
            #     puts e.message

            #     puts "\nLet\'s try again.\n"

            #     @board1.print

            #     currpos = @currentPlayer.get_position

            #     retry

            # end

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

# game1 = Game.new(4, :X, :Y, :Z)
# game1.play