# somehow put code in here to randomize order of quiz

class Quiz
  attr_reader :deck

  def initialize(deck)
    @deck = deck
  end

  def has_more?
    @deck.cards.length > 0
  end

  def next
    random_choice = rand(@deck.cards.length)
    @deck.cards.delete_at(random_choice)
  end
end
