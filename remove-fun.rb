words = %x( cat /usr/share/dict/words | grep -E "^[a-z]{5}$" )
word_array = words.split("\n").to_a

print "Input letters that are _not_ in the word, separated by spaces: "
letters_not_in_word = gets.chomp.split(" ")

puts "Input letters that are in the word, but in the wrong position."
print "Input like this: _a_e_: "
letters_in_incorrect_position = gets.chomp.split("")

letters_in_incorrect_position_indexed = {}
letters_in_incorrect_position.each_with_index do |c, index|
    letters_in_incorrect_position_indexed[index] = c unless c == "_"
end

puts "Input letters that are in the word, in the correct position."
print "Input like this: _a_e_: "
letters_in_correct_position = gets.chomp.split("")

letters_in_correct_position_indexed = {}
letters_in_correct_position.each_with_index do |c, index|
    letters_in_correct_position_indexed[index] = c unless c == "_"
end

possible_words = []
word_array.each do |word|
    candidate = true

    letters_not_in_word.each do |letter|
        candidate = not(word.include? letter)
        break unless candidate
    end

    next unless candidate

    letters_in_correct_position_indexed.each do |index, letter|
        candidate = word[index] == letter
        break unless candidate
    end

    next unless candidate

    letters_in_incorrect_position_indexed.each do |index, letter|
        candidate = (word.include? letter) and (word[index] != letter)
        break unless candidate
    end

    possible_words << word if candidate
end

puts "Possible words:"
possible_words.each do |word|
    puts word
end
