class Card < ActiveRecord::Base
  belongs_to :deck
  attr_accessor :should_destroy
  
  def should_destroy?
    should_destroy.to_i == 1
  end

  def sound_upload=(data)
    self.sound_file = data.read
  end

  def sound_upload(data)
    data.read
  end
end
