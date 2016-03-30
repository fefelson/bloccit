require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) {Post.create!(title: "New Post Title", body: "New Post Body")}

  describe "attributes" do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:body).of_type(:text) }
  end
  
  describe 'associations' do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_many(:comments) }
  end
end
