require 'rails_helper'

RSpec.describe Comment, type: :model do


  describe "attributes" do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_db_column(:body).of_type(:text) }
  end

  describe 'associations' do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end
  
  describe 'validations' do
    #body
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(5) }
    #user
    it { should validate_presence_of(:user) }
  end

  describe "after_create" do
    before do
      @user = User.create!(email: 'admin@example.com', name: 'admin', password: 'helloworld')
      @topic = Topic.create!(name: "Topic of discussion", description: "This has to be a little longer but not too long.")
      @post = Post.create!(title: "A Post for all ages", body: "Texty Texting Textily", user: @user, topic: @topic)
      @another_comment = Comment.new(body: 'Comment Body', post: @post, user: @user)
    end

    it "sends an email to users who have favorited the post" do
      @user.favorites.create(post: @post)
      expect(FavoriteMailer).to receive(:new_comment).with(@user, @post, @another_comment).and_return(double(deliver_now: true))

      @another_comment.save!
    end

    it "does not send emails to users who haven't favorited the post" do
      expect(FavoriteMailer).not_to receive(:new_comment)

      @another_comment.save!
    end
  end

end
