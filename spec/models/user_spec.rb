require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password")}

  it { is_expected.to have_many(:posts)}

  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_length_of(:name).is_at_least(1)}

  #Shoulda tests for email
  it { is_expected.to validate_presence_of(:email)}
  # it { is_expected.to validate_uniqueness_of(:email)}
  it { is_expected.to validate_length_of(:email).is_at_least(3)}
  it { is_expected.to allow_value("user@bloccit.com").for(:email)}
  it "validates uniqueness" do
    expect(user).to validate_uniqueness_of(:email).case_insensitive
  end
  
  describe "attributes" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:role).of_type(:integer).with_options({null: false, default: 0})
    it { should define_enum_for(:role) }}
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:password)}
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_length_of(:password).is_at_least(6)}
    
    it { is_expected.to validate_length_of(:email).is_at_least(3)}
    it { is_expected.to allow_value("user@bloccit.com").for(:email)}
    it { is_expected.to validate_presence_of(:email)}
    it { should validate_uniqueness_of(:email).case_insensitive }
    
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_length_of(:name).is_at_least(1)}
  end

end
