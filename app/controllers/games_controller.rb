require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    @answer = params[:answer]
    if validAttempt?(@answer)
    url = "https://dictionary.lewagon.com/#{@answer}"
    request = URI.open(url).read
    response = JSON.parse(request)
    response["found"] ? endGame(response) : @result = { score: 0, message: "You lost"}
    else
      @result = { score: 0, message: "Your word is invalid"}
    end
  end

  def validAttempt?(word)
    word.length <= 10
  end

  def endGame(word)
    score = (word["length"]) * 100
    @result = { score: score, message: "You win"}
  end
end
