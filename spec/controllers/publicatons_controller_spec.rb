RSpec.describe PublicationsController do
  describe "#index" do
    let(:expected) do
      [
        { "title" => "First Title", "address" => "First Address"},
        { "title" => "Second Title", "address" => "Second Address"}
      ]
    end

    let(:json) { JSON.parse(response.body) }

    before { Publication.create!(expected) }

    it "should return all publication" do
      get :index, format: :json

      expect(json.first).to include(expected.first)
      expect(json.last).to include(expected.last)
    end
  end
end