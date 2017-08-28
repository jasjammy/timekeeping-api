require 'rails_helper'

RSpec.describe TimeCard, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:occurence) }
  it { should have_many(:time_entry).dependent(:destroy) }
end
