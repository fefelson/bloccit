require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) {Post.create!(title: "New Post Title", body: "New Post Body")}

  describe "attributes" do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it "responds to title" do
      expect(post).to respond_to(:title)
    end

    it "responds to body" do
      expect(post).to respond_to(:body)
    end
  end
end
