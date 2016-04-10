require 'rails_helper'

RSpec.describe User, type: :model do

  let(:low_name) {User.create!(name: "bloccit user", email: "user@bloccit.com", password: "password")}

  it "validates name format" do
    expect(low_name.name).to eq("Bloccit User")
  end

  describe "attributes" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:password)}
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_length_of(:password).is_at_least(6)}
    it { is_expected.to validate_length_of(:email).is_at_least(3)}
    it { is_expected.to allow_value("user@bloccit.com").for(:email)}
    it { is_expected.to validate_presence_of(:email)}
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_length_of(:name).is_at_least(1)}
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

end
