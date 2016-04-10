require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:user) {User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld")}
  let(:comment) {Comment.create!(body: 'Comment Body', post: post, user: user)}

  it { is_expected.to belong_to(:post)}
  it { is_expected.to belong_to(:user)}

  it { is_expected.to validate_presence_of(:body)}
  it { is_expected.to validate_length_of(:body).is_at_least(5)}

   describe "attributes" do
     it "responds to body" do
       expect(comment).to respond_to(:body)
     end
   end

  describe "attributes" do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_db_column(:body).of_type(:text) }
  end

  describe 'associations' do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should belong_to(:post) }
  end

end
