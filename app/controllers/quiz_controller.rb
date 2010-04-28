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
    session[:correct_answers] = 0
    session[:cards_answered] = -1
    session[:cards_remaining] = @deck.cards.length + 1 # because we subtract one immediately in multiple_choice_game

    session[:quiz] = @deck.quizzes.build
    redirect_to :action => "multiple_choice_game"
  end

  def multiple_choice_game
    if params[:user_answer].to_i == session[:correct_answer]
      session[:correct_answers] = session[:correct_answers] + 1
    end

    session[:cards_remaining] -= 1
    session[:cards_answered] += 1

    if session[:quiz].has_more?
      @card = session[:quiz].next
      @frontsize = @card.text_font_size(@card.front)
      @choices = session[:quiz].answer_choices(@card)
      @cards_remaining = session[:cards_remaining]
      @cards_answered = session[:cards_answered]
      @correct_answers = session[:correct_answers]
      session[:correct_answer] = @card.id
    else
      redirect_to root_url
    end    
  end
end
