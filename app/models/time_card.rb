class TimeCard < ApplicationRecord
  has_many :time_entry, dependent: :destroy
  validates_presence_of :username, :occurence

end
