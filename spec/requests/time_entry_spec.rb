RSpec.describe 'Time Entry spec', type: :request  do

  let!(:time_card) { create(:time_card) }
  let(:time_card_id) { time_card.id }

  # GET /time_entries
  # to display all time entries
  describe 'GET /time_entries' do
    let!(:time_entry11) { create(:time_entry, :eleven_am, time_card_id: time_card_id  ) }
    let!(:time_entry17) { create(:time_entry , :five_forty_five_pm, time_card_id: time_card_id ) }

    context 'valid request' do
      before { get "/time_entries" }
      it 'returns all time entries' do
        expect(json.size).to eq(2)
      end
      it 'returns 200 status code' do
        expect(response).to have_http_status(200)
      end
    end

  end

  describe 'POST /time_entries ' do
    let!(:valid_params) {{ time: DateTime.now , timecard_id: time_card_id }}

    context 'when request is valid' do
      before { post "/time_entries" , params: valid_params }
      it 'returns 200 status code' do
        expect(response).to have_http_status(200)
      end

    end

    context 'when request is invalid' do
      before { post "/time_entries", params:{ time: DateTime.now ,
                                           timecard_id: 57 } }
      it 'returns 422 status code' do
        expect(response).to have_http_status(422)
      end
    end

    context 'not enough params' do
      before { post "/time_entries", params:{ time: DateTime.now } }
      it 'returns 422 status code' do
        expect(response).to have_http_status(422)
      end

    end
  end

  describe 'PUT /time_entries/id' do
    let!(:time_entry11) { create(:time_entry, :eleven_am, time_card_id: time_card_id  ) }
    let!(:time_entry17) { create(:time_entry , :five_forty_five_pm, time_card_id: time_card_id ) }
    let(:valid_params) { {time: DateTime.now, timecard_id: time_card_id  } }

    context 'when the time_entry exists' do
      before { put "/time_entries/#{time_entry11.id}", params: valid_params }

      it 'returns 200 status code' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the time_entry doesnt exist' do
      before { put "/time_entries/57", params: valid_params }

      it 'returns 422 status code' do
        expect(response).to have_http_status(422)
      end

    end
  end

  describe 'DELETE /time_entries/id' do
    let!(:time_entry11) { create(:time_entry, :eleven_am, time_card_id: time_card_id  ) }
    let!(:time_entry17) { create(:time_entry , :five_forty_five_pm, time_card_id: time_card_id ) }

    context 'when the time_entry exists' do
      before { delete "/time_entries/#{time_entry11.id}" }
      it 'returns 200 status' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the time_entry doesnt exist' do
      before { delete "/time_entries/50" }
      it 'returns 422 status' do
        expect(response).to have_http_status(422)
      end
    end
  end


end