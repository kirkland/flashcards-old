class Card < ActiveRecord::Base
  belongs_to :deck
  attr_accessor :should_destroy
  has_one :card_sound
  validates_length_of :front, :within => 1..30, :too_long => "Card must be 30 or fewer letters", :too_short => "Card front cannot be blank."
  validates_length_of :back, :within => 1..30, :too_long => "Card back must be 30 or fewer letters.", :too_short => "Card back cannot be blank."

  def should_destroy?
    should_destroy.to_i == 1
  end

  def sound_file=(input)
    unless input == ""
      new_card_sound = build_card_sound
      new_card_sound.file = input
    end
  end
end
