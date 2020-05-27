

class Hangman
    attr_accessor :player_name
    attr_reader :misses, :corrects, :stage
    attr_reader :key_word  #for the sake of debugging. Take this out when finished

    public
    
        def initialize(player_name,misses=[],corrects=[],stage=0)
            @player_name = player_name
            @key_word = find_key_word("5desk.txt")
            @misses = misses
            @corrects = corrects
            @stage = stage
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

        def display_corrects(word,corrects)
            for i in 0..(word.length-1)
                if corrects.include?(word[i].downcase)
                    print "#{word[i]} "
                else
                    print '_ '
                end
            end
            puts "\n"
        end

        def display_misses(misses)
            misses_string = misses.join(', ')
            p "misses: #{misses_string}"
        end
end

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