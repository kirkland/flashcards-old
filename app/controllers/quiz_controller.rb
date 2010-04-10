class QuizController < ApplicationController
  skip_before_filter :authorized

  def index
    @decks = Deck.find(:all)
  end

  def quiz
    session[:quiz] = Quiz.new(Deck.find(params[:id]))
    redirect_to :action => "quiz_card"
  end

  def quiz_card
    if session[:quiz].has_more?
      @card = session[:quiz].next

      if @card.back.length < 5
        @backsize = "50px"
      else
        @backsize = "20px"
      end
      if @card.front.length < 5
        @frontsize = "80px"
      else
        @frontsize = "20px"
      end

    else
      redirect_to root_url
    end    
  end
end
