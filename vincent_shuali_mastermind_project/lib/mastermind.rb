require_relative "code"

class Mastermind
    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(codeinst)
        puts "You have #{@secret_code.num_exact_matches(codeinst)} exact matches"
        puts "You have #{@secret_code.num_near_matches(codeinst)} near matches"
    end

    def ask_user_for_guess
        puts "Enter a code"
        userinput = gets.chomp
        usercode = Code.from_string(userinput)
        self.print_matches(usercode)
        usercode == @secret_code


    end
end
