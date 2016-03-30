require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post) {Post.create!(title: "New Post Title", body: "New Post Body")}
  let(:comment) { Comment.create!(body: 'Comment Body', post: post)}

  describe "attributes" do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_db_column(:body).of_type(:text) }
  end

end
