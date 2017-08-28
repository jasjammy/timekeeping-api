RSpec.describe 'Time Card spec', type: :request  do

  let!(:time_cards) { create_list(:time_card, 10) }
  let(:time_card_id) { time_cards.first.id }

  describe 'GET /timecards' do
    before { get "/timecards" }

    it 'returns all timecards' do
      expect(json.size).to eq(10)
    end

    it 'returns 200 status' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /timecards/id' do

    before { get "/timecards/#{time_card_id}" }

    context 'valid request' do
      it 'returns one timecard with the id' do
        expect(json["id"]).to eq(1)
      end
      it 'returns 200 status code' do
        expect(response).to have_http_status(200)
      end
    end

    context 'invalid request' do
      let(:time_card_id) { 57 }
      it 'returns 422 status code' do
        expect(response).to have_http_status(422)
      end
    end

  end

  describe 'POST /timecards ' do
    let!(:valid_params) {{ username: 'james', occurence: Date.today }}

    context 'when request is valid' do
      before { post "/timecards" , params: valid_params }
      it 'returns 201 status code' do
        expect(response).to have_http_status(200)
      end

    end

    context 'when request is invalid' do
      before { post "/timecards", params: { username: 'sally' } }
      it 'returns 422 status code' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /timecards/id' do
    let(:valid_params) { {username: 'sally'}  }
    context 'when the record exists' do
      before { put "/timecards/#{time_card_id}", params: valid_params }

      it 'returns 200 status code' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record doesnt exist' do
      let(:time_card_id) { 50 }
      before { put "/timecards/#{time_card_id}", params: valid_params }
      it 'returns 422 status code' do
        expect(response).to have_http_status(422)
      end

    end
  end

  describe 'DELETE /timecards/id' do

    context 'when the record exists' do
      before { delete "/timecards/#{time_card_id}" }
      it 'returns 200 status' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record doesnt exist' do
      before { delete "/timecards/50" }
      it 'returns 422 status' do
        expect(response).to have_http_status(422)
      end
    end
  end


end