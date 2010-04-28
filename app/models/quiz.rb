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

  def answer_choices(correct_card)
    choices = Array.new
    choices << correct_card
    correct_id = correct_card.id

    wrong_choices = deck.cards.reject { |c| c.id == correct_id }.sort_by { rand }[0..3]

    choices.concat(wrong_choices)
    choices = choices.sort_by { rand }
    rv = Hash.new
    rv['choices'] = choices
    rv['correct_id'] = correct_id
    rv
  end
end
