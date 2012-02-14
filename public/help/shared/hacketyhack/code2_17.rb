secret_number = 42
guess = ask "I have a secret number. Take a guess!"
if guess == secret_number
	alert "Yes! You guessed right!"
else
	alert "Sorry, you\'ll have to try again."
end
