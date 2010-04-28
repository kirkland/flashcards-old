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
    @deck = Deck.find(params[:id])
    session[:quiz] = @deck.quizzes.build
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

  def multiple_choice
    @deck = Deck.find(params[:id])
    session[:quiz] = @deck.quizzes.build
    redirect_to :action => "multiple_choice_game"
  end

  def multiple_choice_game
    @quiz = session[:quiz]

    if params[:user_answer].to_i == session[:correct_answer]
      @quiz.cards_correct += 1
    end

    if @quiz.has_more?
      @card = @quiz.next
      @frontsize = @card.text_font_size(@card.front)
      @choices = @quiz.answer_choices(@card)
      session[:correct_answer] = @card.id
    else
      redirect_to root_url
    end    
  end
end
