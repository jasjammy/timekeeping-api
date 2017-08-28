require 'rails_helper'
# This spec tests the TimeEntry model
RSpec.describe TimeEntry, type: :model do
  # Testing validations and associations
  it { should validate_presence_of(:time) }
  it { should belong_to(:time_card) }

  # Testing hours_worked
  let!(:time_card) {create(:time_card)}
  let!(:time_card_id) { time_card.id }
  describe 'update time card hours worked' do
    let!(:time_entry11) { create(:time_entry, :eleven_am, time_card_id: time_card_id  ) }

    context 'added TimeEntry' do
      let!(:time_entry16) { create(:time_entry , :four_thirty_pm, time_card_id: time_card_id ) }
      it 'should update TimeCard hours_worked' do
        expect(time_card.reload.total_hours_worked).to eq(5)
      end
    end

    context 'added 2 TimeEntries' do
      let!(:time_entry16) { create(:time_entry , :four_thirty_pm, time_card_id: time_card_id ) }
      let!(:time_entry17) { create(:time_entry , :five_forty_five_pm, time_card_id: time_card_id ) }
      it 'should have calculated only one pair of hours worked' do
        expect(time_card.reload.total_hours_worked).to eq(5)
      end
    end

    context 'added 3 TimeEntries' do
      let!(:time_entry16) { create(:time_entry , :four_thirty_pm, time_card_id: time_card_id ) }
      let!(:time_entry17) { create(:time_entry , :five_forty_five_pm, time_card_id: time_card_id ) }
      let!(:time_entry19) { create(:time_entry , :seven_forty_five_pm, time_card_id: time_card_id ) }

      it 'should have calculated 2 pair of hours worked' do
        expect(time_card.reload.total_hours_worked).to eq(5+2)
      end

    end

    context 'removed one timeEntry' do
      let!(:time_entry16) { create(:time_entry , :four_thirty_pm, time_card_id: time_card_id ) }
      let!(:time_entry17) { create(:time_entry , :five_forty_five_pm, time_card_id: time_card_id ) }
      let!(:time_entry19) { create(:time_entry , :seven_forty_five_pm, time_card_id: time_card_id ) }

      it 'should calculate for 1 pair now' do
        time_card.time_entry.find(3).destroy
        expect(time_card.reload.total_hours_worked).to eq(5)
      end
    end

    context 'remove all but one time entry' do
      let!(:time_entry16) { create(:time_entry , :four_thirty_pm, time_card_id: time_card_id ) }
      let!(:time_entry17) { create(:time_entry , :five_forty_five_pm, time_card_id: time_card_id ) }
      let!(:time_entry19) { create(:time_entry , :seven_forty_five_pm, time_card_id: time_card_id ) }

      it 'should have total_hours == 0' do
        time_card.time_entry.find(2).destroy
        time_card.time_entry.find(3).destroy
        time_card.time_entry.find(4).destroy
        expect(time_card.reload.total_hours_worked).to eq(0)
      end

    end

  end

end
