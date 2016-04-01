require 'rails_helper'

RSpec.describe Advertisement, type: :model do

  describe "attributes" do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:body).of_type(:text) }
    it { should have_db_column(:price).of_type(:integer) }
  end

end
