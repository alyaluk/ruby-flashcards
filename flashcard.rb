# Main file for your code.

list = []
IO.foreach('flashcard_samples.txt') do |line|
	list << line
end
list.delete("\n")

x = 1
$game = Hash.new
random = []
$keys = []
points = 0
number = nil
$multi = false
size = list.length / 2
for i in (0...list.length/2)
	$game[list[x].gsub("\n","")] = list[x-1].gsub("\n","")
	random << list[x-1].gsub("\n","")
	$keys << list[x].gsub("\n","")
	x += 2
end

def set(number)
	if number == nil
		return nil
	else $count = number
	end
end

def multiple
	if $multi == true
		choices = [$game.key($prompt), $keys.sample, $keys.sample]
		p choices.shuffle
	end
end

puts "Welcome to the Ruby Flashcard quiz! What type of game would you like to play? (multiple_choice/set/quit)"
input = gets.chomp
if input != "quit"
	if input == "set"
		puts "How many questions?"
		number = gets.chomp.to_i
	elsif input == "multiple_choice"
		$multi = true
	end
	sleep(0.5)
	puts "", "Instructions: guess all the commands correctly to finish the game. Type quit to end the game."
	answer = nil
	until answer == "quit" || random.empty? || $count == 0
		sleep(0.5)
		puts "", "Which command is this?"
		$prompt = random.sample
		puts $prompt
		multiple
		answer = gets.chomp
		sleep(0.5)
		if $game[answer] == $prompt
			puts "", "Correct! :D"
			points += 1
			number -= 1 unless number == nil
			random.delete($prompt)
		elsif answer != "quit"
			puts "Incorrect :("
		end
		set(number)
		sleep(0.5)
		puts "", "You have answered #{points} correctly."
	end
	sleep(0.5)
	puts "", "Congratulations, you finished the game!" if answer != "quit"
end

