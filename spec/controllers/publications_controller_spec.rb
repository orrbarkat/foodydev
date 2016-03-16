RSpec.describe PublicationsController do
  describe "#index" do
    before(:all) do
      create(:user)
    end
    before(:each) do
      @user = build(:user)
    end
    let(:expected) do
      [
        { "title" => "First Title", "address" => "First Address"},
        { "title" => "Second Title", "address" => "Second Address"}
      ]
    end

    let(:json) { JSON.parse(response.body) }

    # before { Publication.create!(expected) }

    it "should return no publication" do
      get :index, format: :json
      expect(json).to be_empty
    end

    it "should return a single publication" do
      publication = create(:publication, :publisher_id => User.last.id)
      get :index, format: :json
      expect(json.first["id"]).to eq(publication.id)
    end



  end
end