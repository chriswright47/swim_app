require 'spec_helper'

describe User do
  before(:each) { @user = FactoryGirl.build(:user) }

  it 'has a valid factory' do
    expect(@user).to be_valid
    expect{ @user.save }.to change(User, :count).by(1)
  end

  it 'is invalid without a first name' do
    @user.first_name = ''
    expect{ @user.save! }.to raise_error
    expect(@user.errors.full_messages).to include("First name can't be blank")
  end

  it 'is invalid without a last name' do
    @user.last_name = ''
    expect{ @user.save! }.to raise_error
    expect(@user.errors.full_messages).to include("Last name can't be blank")
  end

  it 'returns a full name as a string' do
    expect(@user.full_name).to eq "#{@user.first_name} #{@user.last_name}"
  end

  it 'is invalid without an email' do
    @user.email = ''
    expect{ @user.save! }.to raise_error
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end

  it 'is invalid with a bad email format' do
    @user.email = 'bad.email'
    expect{ @user.save! }.to raise_error
    expect(@user.errors.full_messages).to include("Email not a valid email address")
  end

  it 'is invalid if email is already in use' do
    @user.save
    new_user = FactoryGirl.build(:user, email: @user.email)
    expect{ new_user.save! }.to raise_error
    expect(new_user.errors.full_messages).to include("Email has already been taken")
  end

  it 'responds to all expected attributes' do
    expect(@user).to respond_to(:first_name)
    expect(@user).to respond_to(:last_name)
    expect(@user).to respond_to(:email)
    expect(@user).to respond_to(:password)
    expect(@user).to respond_to(:password_confirmation)
    expect(@user).to respond_to(:password_digest)
    expect(@user).to respond_to(:admin)
    expect(@user).to respond_to(:coach)
    expect(@user).to respond_to(:team)
  end

end