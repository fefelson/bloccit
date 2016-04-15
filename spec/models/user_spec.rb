require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "attributes" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:role).of_type(:integer).with_options({null: false, default: 0}) }
    it { should define_enum_for(:role) }
  end
  
  describe 'associations' do
    it { should have_many(:posts) }
  end
  
  describe 'validations' do
    #password
    it { is_expected.to validate_presence_of(:password)}
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_length_of(:password).is_at_least(6)}
    #email
    it { is_expected.to validate_length_of(:email).is_at_least(3)}
    it { is_expected.to allow_value("user@bloccit.com").for(:email)}
    it { is_expected.to validate_presence_of(:email)}
    it { should validate_uniqueness_of(:email).case_insensitive }
    #name
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_length_of(:name).is_at_least(1)}
    #role
    it { is_expected.to validate_presence_of(:role)}
  end

  describe "#favorite_for(post)" do
    before do 
      topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
    end

    it "returns nil if user has not fovrited the post" do
      expect(user.favorite_for(@post)).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      favorite = user.favorites.where(post: @post).create
      expect(user.favorite_for(@post)).to eq(favorite)
    end
  end

end
