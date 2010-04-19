class Card < ActiveRecord::Base
  belongs_to :deck
  attr_accessor :should_destroy
  has_one :card_sound

  def should_destroy?
    should_destroy.to_i == 1
  end

  def sound_file=(input)
    unless input == ""
      new_card_sound = build_card_sound
      new_card_sound.file = input
      temp = new_card_sound.save
      self.card_sound_id = new_card_sound.id
    end
  end
end
