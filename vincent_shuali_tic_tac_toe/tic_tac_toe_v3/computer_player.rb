require_relative "human_player"

class ComputerPlayer
    attr_reader :mark_value
    def initialize(mark_value)
        @mark_value = mark_value
    end

    def get_position(legal_positions)
        chosenpos = legal_positions.sample

        puts "Computer of mark #{@mark_value} chooses position #{chosenpos}"

        chosenpos
    end

    

end

# comp1 = ComputerPlayer.new("Z")
# testarr = [[1, 2], [3, 7], [-3, 7], [-4, -3]]
# comp1.get_position(testarr)