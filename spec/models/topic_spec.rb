require 'rails_helper'

RSpec.describe Topic, type: :model do

  describe "attributes" do
    it { should have_db_column(:name).of_type(:string)}
    it { should have_db_column(:description).of_type(:text)}
    it { should have_db_column(:public).of_type(:boolean).with_options({default: true}) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:labelings)}
    it { is_expected.to have_many(:labels).through(:labelings)}
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:name).is_at_least(5)}
    it { is_expected.to validate_length_of(:description).is_at_least(15)}
  end

  describe "scopes" do
    before do
      @public_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @private_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph, public: false)
    end

    describe "visible_to(user)" do
      it "returns all topics if the user is present" do
        user = User.new
        expect(Topic.visible_to(user)).to eq(Topic.all)
      end

      it "returns only public topics if user is nil" do
        expect(Topic.visible_to(nil)).to eq([@public_topic])
      end
    end
  end

end
