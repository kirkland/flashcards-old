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
      @backsize = @card.text_font_size(@card.back)
      @frontsize = @card.text_font_size(@card.front)
    else
      redirect_to root_url
    end    
  end
end
