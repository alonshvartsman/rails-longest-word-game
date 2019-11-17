# require 'json'
# require 'open-uri'

# class GamesController < ApplicationController
#   def new
#     @letters = (0...7).map { ('A'..'Z').to_a[rand(26)] }
#   end

#   def score
#     score = compute_score(params[:letter_array].downcase.split, params[:word])
#     redirect_to result_path(score: score)
#   end

#   def result
#     @score = params[:score]
#   end

#   private

#   def compute_score(grid, attempt)
#     user_input = attempt.downcase
#     url = "https://wagon-dictionary.herokuapp.com/#{user_input}"
#     serialized = open(url).read
#     result = JSON.parse(serialized)
#   end
# end
# ____________________________________________________________
require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(3) { VOWELS.sample }
    @letters += Array.new(4) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def result
    @letters = params[:letters].split
    @word = (params[:word] || '').upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
