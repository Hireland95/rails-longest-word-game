require 'open-uri'

class GamesController < ApplicationController

  def new
    @alphabet = ("A".."Z").to_a
    @letters = []
    10.times do
    @letters << @alphabet.sample
    end
  end

  def score
    @letters = params[:letters]
    @attempt = params[:attempt]
    @sorted_attempt = @attempt.upcase.split("")
    @letters_sorted = @letters.split()

    @letters_in_grid = @sorted_attempt.all? do |letter|
      if @letters_sorted.include?(letter)
        @letters_sorted.delete_at(@letters_sorted.index(letter))
        true
      else
        false
        end
      end

      if @letters_in_grid == false
        @result = "Your score is 0 as your attempt is not in the grid!"
      else
        dictionary = URI.open("https://wagon-dictionary.herokuapp.com/#{@attempt}").read
        dictionary_response = JSON.parse(dictionary)
        if dictionary_response["found"] == false
          @result = "This is not an English word"
        else
          @result = "Great word!"
        end
      end
  end
end
