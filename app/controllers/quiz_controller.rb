class QuizController < ApplicationController
  skip_before_filter :authorized

  def index
    @users = User.all.select { |user| user.decks.present? }

    # only users with 1 or more shared decks
    @users = @users.find_all do |user|
      user.decks.delete_if { |deck| deck.share == false }.length > 0
    end
  end

  def quiz
    session[:quiz] = Quiz.new(Deck.find(params[:id]))
    redirect_to :action => "quiz_card"
  end

  def quiz_card
    if session[:quiz].has_more?
      @card = session[:quiz].next

      if @card.back.length < 7
        @backsize = "80px"
      elsif @card.back.length < 11
        @backsize = "50px"
      else
        @backsize = "20px"
      end

      if @card.front.length < 7
        @frontsize = "80px"
      elsif @card.front.length < 11
        @frontsize = "50px"
      else
        @frontsize = "20px"
      end

    else
      redirect_to root_url
    end    
  end
end
