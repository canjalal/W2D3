require_relative "board"

class HumanPlayer 
    attr_reader :mark_value
    def initialize(mark_value)
        @mark_value = mark_value
    end

    def get_position
        puts "Player of mark #{@mark_value}:"
        puts "Enter a position of row and col separated by a space, e.g. \"2 0\""
        userpos = gets.chomp

# 6/21: check for valid format and position
        unless !!userpos.match(/^\d \d$/)
            raise ArgumentError.new("You need to enter two single-digit numbers separated by a space")
        end
        currpos = userpos.split(' ').map(&:to_i)
        
    end

end