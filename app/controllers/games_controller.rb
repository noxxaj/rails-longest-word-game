require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || '')
    @included = included?(@word, @letters)
    @real_word = real_word?(@word)
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def real_word?(word)
    check = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(check.read)
    json['found']
  end
end
