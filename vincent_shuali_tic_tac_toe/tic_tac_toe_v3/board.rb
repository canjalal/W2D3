require "byebug"

class Board

    attr_reader :grid
    def initialize(dim) # later accept dim as integer
        # assume dim provided is an integer. Otherwise we will need to do more
        # error handling
        unless dim.is_a?(Integer)
            raise ArgumentError.new("You must enter a whole number between 1 and 9")
        end
        unless dim < 10 && dim > 0
            raise ArgumentError.new("The dimension must be between 1 and 9")
        end
        @dim = dim
        @grid = Array.new(dim) {Array.new(dim, '_')}
    end

    def valid?(position)
        (0...@dim).member?(position[0]) && (0...@dim).member?(position[1])
    end

    def [](*arr)  # splat removes need for double brackets
        @grid[arr[0]][arr[1]]
      end

    def []=(*position, val)
        @grid[position[0]][position[1]] = val
    end

    def empty?(position)
        self[*position] == '_'
    end

    def place_mark(position, mark)

        self[*position] = mark # does this run if error raised?
    end

    def print
        @grid.each {|subarray| puts subarray.join(" ")}
    end

    def win_row?(mark)
        @grid.any? {|subarray| subarray.all? {|ele| ele == mark}}
    end

    def win_col?(mark)
        @grid.transpose.any? {|subarray| subarray.all? {|ele| ele == mark}}
    end

    def win_diagonal?(mark)
        frontdiagonal = @grid.map.with_index {|subarray, i| subarray[i]}
        backdiagonal = @grid.map.with_index {|subarray, i| subarray[@dim - i - 1]}

        frontdiagonal.all?{|ele| ele == mark} || backdiagonal.all?{|ele| ele == mark}
    end

    def win?(mark)
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        @grid.flatten.any? {|ele| ele == "_"}
    end

    def legal_positions
        legalpositions = []

        (0...@dim).each do |i|
            (0...@dim).each do |j|
                legalpositions << [i , j] if self.empty?([i, j])
            end
        end

        legalpositions
    end

end

class WrongPositionError < ArgumentError
    def message
        "You need to place your mark on one of the empty slots"
    end
end

# board1 = Board.new(5)
# board1[2, 2] = :X
# board1.place_mark([1, 2], 7)
# p board1[1, 2]