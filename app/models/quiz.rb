class Quiz < ActiveRecord::Base
#  belongs_to :user
  belongs_to :deck

  def has_more?
    deck.cards.length > 0
  end

  def next
    random_choice = rand(deck.cards.length)
    deck.cards.delete_at(random_choice)
  end

  def answer_choices
    choices = Array.new
    choices << deck.cards[0].back
    choices << deck.cards[1].back
    return choices
  end

end
