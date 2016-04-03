require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:spondored_post) { topic.sponsored_post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(50..100)) }

  describe "attributes" do
    it {should have_db_column(:title).of_type(:string)}
    it {should have_db_column(:body).of_type(:text)}
    it {should have_db_column(:price).of_type(:integer)}
  end

  describe 'associations' do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should belong_to(:topic) }
  end

end
