class CardSound < ActiveRecord::Base
  belongs_to :card

  def file=(input_data)
    self.filename = input_data.original_filename
    self.content_type = input_data.content_type.chomp
    self.sound_data = input_data.read
  end
end
