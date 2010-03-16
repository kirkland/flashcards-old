class Deck < ActiveRecord::Base
  has_many :cards

  def card_attributes=(card_attributes)
    card_attributes.each do |attributes|
      cards.build(attributes)
    end
  end
end
