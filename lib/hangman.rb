

class Hangman
    attr_accessor :player_name
    attr_reader :misses, :corrects, :stage
    attr_reader :key_word  #for the sake of debugging. Take this out when finished

    public
    
        def initialize(player_name,misses=[],corrects=[],stage=0)
            @player_name = player_name
            @key_word = find_key_word("5desk.txt").chomp
            #@key_word = "corpsman"
            @misses = misses
            @corrects = corrects
            @stage = stage
        end

        def game()
            puts "Hi #{@player_name} <3"
            puts "Your word is #{@key_word.length}-letter long."
            puts "You have #{6-@stage} lives left."
            display_hangman()
            display_corrects()
            display_misses()

            while @stage < 6 do 
                p @corrects
                p @misses

                if @corrects.join().downcase == @key_word.downcase   #this condition has problem
                    puts File.read("assets/winner.txt")
                    break
                end

                print "Guess a letter: "
                guess = gets.chomp.downcase
                is_correct_guess = hit_or_miss(guess)

                if is_correct_guess == true
                    puts "Nice guess!!!"
                else
                    puts "Wrong :("
                    @stage += 1
                    #puts "You have #{6-@stage} lives left."
                end

                display_hangman()
                display_corrects()
                display_misses()

                if @stage == 6
                    puts "The secret word is #{@key_word}"
                    break
                end
            end
        end

    private

        def find_key_word(filename)
            lines = File.readlines(filename)
            word = lines[rand(lines.length)].chomp
        
            while word.length < 5 || word.length > 12 do
                word = lines[rand(lines.length)].chomp
            end
            
            return word
        end

        def display_corrects()
            for i in 0..(@key_word.length-1)
                if @corrects.include?(@key_word[i].downcase)
                    print "#{@key_word[i]} "
                else
                    print '_ '
                end
            end
            puts "\n"
        end

        def display_misses()
            misses_string = @misses.join(', ')
            puts "Misses: #{misses_string}"
        end

        def display_hangman()
            if @stage == 0
                puts File.read("assets/hm0.txt")
            elsif @stage == 1
                puts File.read("assets/hm1.txt")
            elsif @stage == 2
                puts File.read("assets/hm2.txt")
            elsif @stage == 3
                puts File.read("assets/hm3.txt")
            elsif @stage == 4
                puts File.read("assets/hm4.txt")
            elsif @stage == 5
                puts File.read("assets/hm5.txt")
            elsif @stage == 6
                puts File.read("assets/hm6.txt")
            end
        end

        def hit_or_miss(guess)
            if @key_word.downcase.include?(guess)
                @corrects.push(guess)
                return true
            else
                @misses.push(guess)
                return false
            end
        end
end



print "What is your name? "
name = gets.chomp

player = Hangman.new(name)
puts "keyword: #{player.key_word}"
player.game()



=begin
word = "Hangman"
guess = 'z'

misses = []
corrects = []

if word.downcase.include?(guess)
    corrects.push(guess)
else
    misses.push(guess)
end
p corrects
p misses
=end

=begin
stage = 6
if stage == 0
    puts File.read("assets/hm0.txt")
elsif stage == 6
    puts File.read("assets/hm6.txt")
end
=end

=begin
nin = Hangman.new("nin")
p nin.key_word
p nin.misses
p nin.corrects
p nin.stage
p nin.player_name
=end

=begin
misses = ['j','k','o']
misses_string = misses.join(', ')
p "misses: #{misses_string}"
=end

=begin
word = "Lightning"
corrects = ['i','l']
for i in 0..(word.length-1)
    if corrects.include?(word[i].downcase)
        print "#{word[i]} "
    else
        print '_ '
    end
end
puts "\n"
p word.include?('z')
=end





=begin
    def find_key_word(filename)

    lines = File.readlines(filename)
    word = lines[rand(lines.length)].chomp

    while word.length < 5 || word.length > 12 do
        word = lines[rand(lines.length)].chomp
    end
    
    return word
end

p find_key_word("5desk.txt")
=end