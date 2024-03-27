require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'Successfully creates a user' do
      user = User.new(email: "test@abc.com", password: "abcdef", password_confirmation: "abcdef" ,first_name: "John", last_name: "Doe")
      expect(user).to be_valid
    end

    it 'validates Email is already used' do
      user = User.create(email: "test@abc.com", password: "abcdef", password_confirmation: "abcdef" ,first_name: "John", last_name: "Doe")
      user2 = User.new(email: "test@abc.com", password: "abcdef", password_confirmation: "abcdef" ,first_name: "Jane", last_name: "Doe")
      user2.save
      expect(user2).not_to be_valid
    end

    it 'validates email' do
      user = User.new(email: nil, password: "abcdef", password_confirmation: "abcdef" ,first_name: "John", last_name: "Doe")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'validates password' do
      user = User.new(email: "test@abc.com", password: nil, password_confirmation: "abcdef" ,first_name: "John", last_name: "Doe")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'validates password confirmation' do
      user = User.new(email: "test@abc.com", password: "abcdef", password_confirmation: "fedcba" ,first_name: "John", last_name: "Doe")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'validates first name' do
      user = User.new(email: "test@abc.com", password: "abcdef", password_confirmation: "abcdef" ,first_name: nil, last_name: "Doe")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'validates last name' do
      user = User.new(email: "test@abc.com", password: "abcdef", password_confirmation: "abcdef" ,first_name: "John", last_name: nil)
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'validates password length' do
      user = User.new(email: "test@abc.com", password: "abcd", password_confirmation: "abcd" ,first_name: "John", last_name: "Doe")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(email: "Test@abc.com", password: "abcdef", password_confirmation: "abcdef" ,first_name: "John", last_name: "Doe")
    end

    it 'Authenticates correct email and password' do
      expect(User.authenticate_with_credentials('Test@abc.com', 'abcdef')).to eq(@user)
    end

    it 'Doesnt Authenticate incorrect email' do
      expect(User.authenticate_with_credentials('Testing@abc.com', 'abcdef')).to eq(nil)
    end

    it 'Doesnt Authenticate incorrect password' do
      expect(User.authenticate_with_credentials('Test@abc.com', 'abdcef')).to eq(nil)
    end

    it 'Authenticates correct email with wrong case' do
      expect(User.authenticate_with_credentials('teSt@Abc.com', 'abcdef')).to eq(@user)
    end
  end
end
