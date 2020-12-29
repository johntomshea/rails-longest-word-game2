require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].upcase.split('')
    @letters = params[:letters].split
    @response = ''

    #check if word is in grid
    @word.each do |letter|
      if @letters.include?(letter)
        @letters.delete(letter)
      else
        @response = "You can't make that word from the given grid"
      end
    end

    #check if word is in English language by connecting to API
    while @response == ''
      word = params[:word]
      url = "https://wagon-dictionary.herokuapp.com/#{word}"

      data = open(url).read
      json = JSON.parse(data)
      if json["found"] == true
        @response = "yay, that word works"
      else
        @response = "That's not an English word you dummy"
      end
    end
  end
end
