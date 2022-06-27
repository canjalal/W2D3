require_relative "code"

class Mastermind
    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(codeinst)
        puts "You have #{@secret_code.num_exact_matches(codeinst)} exact matches"
        puts "You have #{@secret_code.num_near_matches(codeinst)} near matches"
    end
end
