require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }
  end

  def score
    @word = params[:word]
    @word_split = params[:word].downcase.split("").sort
    @letters = params[:letters].downcase.split(" ").sort
    @result = @letters.any? { |x| @word_split.include?(x) }
    if @result == true
      response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
      json = JSON.parse(response.read)
      @result = json['found']
      if @result == true
        @result = "Well done. Your score is #{@word_split.length}!"
      else
        @result = "Not an english word"
      end
    else
      @result = "not in the grid"
    end
  end
end
