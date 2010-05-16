class QuizController < ApplicationController
  skip_before_filter :authorized

  def index
    @users = User.all.select { |user| user.decks.present? }

    # only users with 1 or more shared decks
    @users = @users.find_all do |user|
      user.decks.delete_if { |deck| deck.share == false }.length > 0
    end
  end

  def multiple_choice_index
    @decks = Deck.find(:all, :conditions => {:share => true})
    @categories = @decks.collect do |deck|
      deck.clean_category
    end
    @categories = @categories.sort.uniq

    @decks_with_categories = Hash.new
    @decks.each do |deck|
      if @decks_with_categories[deck.clean_category]
        @decks_with_categories[deck.clean_category] << deck
      else
        @decks_with_categories[deck.clean_category] = [deck]
      end
    end
  end

  def basic_flashcards_index
    @decks = Deck.find(:all, :conditions => {:share => true})
    @categories = @decks.collect do |deck|
      deck.clean_category
    end
    @categories = @categories.sort.uniq

    @decks_with_categories = Hash.new
    @decks.each do |deck|
      if @decks_with_categories[deck.clean_category]
        @decks_with_categories[deck.clean_category] << deck
      else
        @decks_with_categories[deck.clean_category] = [deck]
      end
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
    elsif params[:user_answer] # make sure we didn't just start a game
      @last_front = Card.find(session[:correct_answer]).front
      @last_back = Card.find(session[:correct_answer]).back
      @last_size = Card.find(session[:correct_answer]).text_font_size(@last_front)
    end

    if @quiz.has_more?
      @card = @quiz.next
      @frontsize = @card.text_font_size(@card.front)
      @choices = @quiz.answer_choices(@card)
      session[:correct_answer] = @card.id
    else
      render :action => 'end_game'
    end    
  end
end
