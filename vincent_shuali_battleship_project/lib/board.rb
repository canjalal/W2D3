class Board
    attr_reader :size
  def initialize(num)
    @grid = Array.new(num){Array.new(num, :N)}
    # board values can be either :N  or :S (strike)
    @size = num*num
  end

  def [](arr)
    @grid[arr[0]][arr[1]]
  end

  def []=(pos, val)
    @grid[pos[0]][pos[1]] = val
  end

  def num_ships
    @grid.flatten.count(:S)
  end

  def attack(pos)
    if self[pos] == :S
        self[pos] = :H
        puts "you sunk my battleship!"
        true
    else
        self[pos] = :X
        false
    end
  end

  def place_random_ships
=begin
    Generate a 2-D array of positions that is size/4 long.

    Each one holds a pos [y , x]
    
    If it already exists, then generate

=end

    shipstoplace = @size/4
    currpos = [nil, nil]
    width = @grid.length
    while(shipstoplace > 0)
        currpos = [rand(0...width), rand(0...width)]

        shipstoplace = self[currpos] != :S ? shipstoplace - 1 : shipstoplace
        self[currpos] = :S
    end

  end

  def hidden_ships_grid
    @grid.map {|subarray| subarray.map {|ele| ele == :S ? :N : ele}}
  end

  def self.print_grid(grid2Darray)
    grid2Darray.each do |subarray|
        puts subarray.join(' ')
    end
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(self.hidden_ships_grid)
  end

end
