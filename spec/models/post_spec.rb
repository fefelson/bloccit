require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "attributes" do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:body).of_type(:text) }
  end

  describe 'associations' do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should belong_to(:user)}
    it { should have_many(:comments).dependent(:destroy) }
  end
  
  describe 'validations' do 
    it { is_expected.to belong_to(:topic)}
    it { is_expected.to validate_presence_of(:title)}
    it { is_expected.to validate_presence_of(:body)}
    it { is_expected.to validate_presence_of(:topic)}

    it { is_expected.to validate_length_of(:title).is_at_least(5)}
    it { is_expected.to validate_length_of(:body).is_at_least(20)}
  end
end
