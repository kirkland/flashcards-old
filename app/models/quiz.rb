class Quiz < ActiveRecord::Base
#  belongs_to :user
  belongs_to :deck

  def has_more?
    deck.cards.select { |card| card.used_in_game == false }.length > 0
  end

  def next
    available_card_indices = Array.new

    deck.cards.each_index { |index|
      available_card_indices << index unless deck.cards[index].used_in_game
    }

    choice_index = available_card_indices.sort_by { rand }[0]
    deck.cards[choice_index].used_in_game = true
    deck.cards[choice_index]
  end

  def answer_choices(correct_answer_card)
    possible_choices = Array.new
    possible_choices << correct_answer_card
    correct_id = correct_answer_card.id

    # pick 4 other random cards, other than the correct one
    wrong_choices = deck.cards.reject { |c| c.id == correct_id }.sort_by { rand }[0..3]

    possible_choices.concat(wrong_choices)
    possible_choices.sort_by { rand }
  end
end
