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

  def num_exact_matches(code)
    @pegs.select.with_index {|peg, i| peg == code.pegs[i]}.length
  end
  
  def num_near_matches(code)
  
  
    code.pegs.count {|peg| @pegs.include?(peg)} - num_exact_matches(code)

  end

end
