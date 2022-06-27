class Code
  attr_accessor :pegs
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(arrchars)
    arrchars.all?{|char| POSSIBLE_PEGS.has_key?(char.upcase)}
  end

  def initialize(arrchars)

    unless Code.valid_pegs?(arrchars)
      raise ArgumentError.new("You have a few invalid pegs")
    end

    @pegs = arrchars.map(&:upcase)

  end

  def self.random(len)
    randopegs = Array.new(len) {POSSIBLE_PEGS.keys.sample}
    Code.new(randopegs)
  end

  def self.from_string(str)
    Code.new(str.split(''))
  end

  def [](idx)
    @pegs[idx]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(codeinst)
    @pegs.select.with_index {|peg, i| peg == codeinst.pegs[i]}.length
  end
  
  def num_near_matches(codeinst)
  
  
    temppegs = @pegs.map.with_index {|peg, i| codeinst.pegs[i] == peg ? nil : peg}.compact
    tempguess = codeinst.pegs.map.with_index {|peg, i| @pegs[i] == peg ? nil : peg}.compact
    
    count = 0
    tempguess.each do |ele|
      if(temppegs.index(ele))
        temppegs.delete_at(temppegs.index(ele))
        count += 1
      end
    end

    count

  end

  def ==(codeinst)
    return false if @pegs.length != codeinst.pegs.length
    @pegs == codeinst.pegs
  end

end
