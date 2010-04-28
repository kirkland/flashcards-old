class Quiz < ActiveRecord::Base
#  belongs_to :user
  belongs_to :deck

  def has_more?
    deck.cards.delete_if { |card| card.used_in_game? == true }.length > 0
  end

  def next
    available_card_indexes = Array.new

    deck.cards.each_index { |index|
      if deck.cards[index].used_in_game? == false
        available_card_indexes << index
      end
    }

    choice_index = available_card_indexes.sort_by { rand }[0]

    deck.cards[choice_index].used_in_game = true
    deck.cards[choice_index]

  end

  def answer_choices
    choices = Array.new
    choices << deck.cards[0].back
    choices << deck.cards[1].back
    return choices
  end

end
