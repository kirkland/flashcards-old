class QuizController < ApplicationController
  def quiz
    session[:quiz] = Quiz.new(Deck.find(params[:id]))
    redirect_to :action => "quiz_card"
  end

  def quiz_card
    if session[:quiz].has_more?
      @card = session[:quiz].next
    else
      redirect_to root_url
    end    
  end
end
