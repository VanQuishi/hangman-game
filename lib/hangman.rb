require "csv"

class Hangman
    attr_accessor :player_name
    attr_reader :misses, :corrects, :stage, :id
    attr_reader :key_word  #for the sake of debugging. Take this out when finished

    public
    
        def initialize(player_name,misses=[],corrects=[],stage=0,key_word = find_key_word("5desk.txt"),id = -1)
            @id = id
            @player_name = player_name
            @key_word = key_word
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

            print "Do you want to save the game?(Y/n)"
            choice = gets.chomp
            if choice.downcase == 'y'
                save_game()
            else
                while @stage < 6 do 

                    if @corrects.length == @key_word.length 
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
                    end

                    display_hangman()
                    display_corrects()
                    display_misses()

                    if @stage == 6
                        puts "The secret word is #{@key_word}"
                        break
                    end

                    print "Do you want to save the game?(Y/n)"
                    choice = gets.chomp
                    if choice.downcase == 'y'
                        save_game()
                        break
                    else
                        next
                    end
                end
            end
        end

        def self.load_game() 
            puts "List of load game: "
            contents = CSV.open 'assets/saved_games.csv', headers: true, header_converters: :symbol

            contents.each do |row|
                puts "ID: #{row[:id]}   Username: #{row[:player_name]}"
            end

            file = CSV.open 'assets/saved_games.csv', headers: true, header_converters: :symbol
            print "Enter the game ID that you want to continue: "

            match = gets.chomp
            
            file.each do |row|  
                
                if row[:id] == match
                    puts "match!!!"
                    load_id = row[:id].to_i()
                    load_player_name = row[:player_name]
                    load_misses = row[:misses].split("")
                    load_corrects = row[:corrects].split("")
                    load_stage = row[:stage].to_i()
                    load_key_word = row[:key_word]
                    player = Hangman.new(load_player_name, load_misses, load_corrects, load_stage, load_key_word, load_id)
                    player.game()
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
                
                @key_word.split("").each do |letter|     
                    if letter.downcase == guess.downcase
                        @corrects.push(guess)
                    end
                end
                return true
            else
                @misses.push(guess)
                return false
            end
        end

        def save_game()
            if @id == -1
                current_size = CSV.read("assets/saved_games.csv").size
                p "current size: #{current_size}"
                id = current_size + 1
                p "this user id: #{id}"
                CSV.open("assets/saved_games.csv", "a+") do |csv|
                    csv << ["#{id}", "#{@player_name}", "#{@misses.join()}", "#{@corrects.join()}", "#{@stage}", "#{@key_word}"]
                end
            else  
                file = CSV.read("assets/saved_games.csv")
            
                edited_ows = file.each_with_index.map do |row, index|
                    if index == @id
                        row[2] = "#{@misses.join()}"
                        row[3] = "#{@corrects.join()}"
                        row[4] = "#{@stage.to_s()}"
                    end
                end

                CSV.open("assets/saved_games.csv", "wb") do |csv|
                    file.each do |row| 
                        csv << row
                    end
                end
            end
        end
end


print "New game or Load game?(N/l): "
option = gets.chomp

if option.downcase == 'l'
    Hangman.load_game()
else
    print "What is your name? "
    name = gets.chomp

    player = Hangman.new(name)
    player.game()
end