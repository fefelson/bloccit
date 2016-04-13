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
  describe "attributes" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
  end
  
  describe 'associations' do
    it { is_expected.to have_many(:posts) }
  end

    it "should respond to email" do
      expect(user).to respond_to(:email)
    end

    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end

    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end
  end

  describe "roles" do
    it "is member by default" do
      expect(user.role).to eql("member")
    end

    context "member User" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #member?" do
        expect(user.admin?).to be_truthy
      end
    end
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
