class Board
    DIM = 3
    attr_reader :grid
    def initialize # later accept dim as integer
        @grid = Array.new(DIM) {Array.new(DIM, '_')}
    end

    def valid?(position)
        (0...DIM).member?(position[0]) && (0...DIM).member?(position[1])
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
        if(!valid?(position) || !empty?(position))
            raise WrongPositionError
        end

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
        backdiagonal = @grid.map.with_index {|subarray, i| subarray[DIM - i - 1]}

        frontdiagonal.all?{|ele| ele == mark} || backdiagonal.all?{|ele| ele == mark}
    end

    def win?(mark)
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        @grid.flatten.any? {|ele| ele == "_"}
    end

    # def getfrontdiagonal
    #     puts @frontdiagonal
    # end

    # def getbackdiagonal
    #     puts @backdiagonal
    # end

end

class WrongPositionError < StandardError
    def message
        "You need to place your mark on one of the empty slots"
    end
end

board1 = Board.new
board1[2, 2] = :X
board1.place_mark([1, 2], 7)
p board1[1, 2]