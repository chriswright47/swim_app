require 'spec_helper'

describe 'Create Account' do
  before { visit new_user_path }

  it 'has user fields' do
    expect(page).to have_field('First name')
    expect(page).to have_field('Last name')
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
    expect(page).to have_field('Confirm Password')
    expect(page).to have_field('Team')
  end

  describe 'creating new user' do
    let(:user) { FactoryGirl.build(:user) }

    describe 'with invalid data' do
      it 'does not create user with no data' do
        expect{ click_button 'Create My Account' }.to change(User, :count).by(0)
        expect(page).to have_content('Account was not created')
        expect(page).to have_content("First name can't be blank")
        expect(page).to have_content("Last name can't be blank")
        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content("Password can't be blank")
      end

      it 'does not create user with invalid email' do
        fill_in 'First name', with: user.first_name
        fill_in 'Last name', with: user.last_name
        fill_in 'Email', with: 'bad.email'
        fill_in 'Password', with: user.password
        fill_in 'Confirm Password', with: user.password_confirmation
        expect{ click_button 'Create My Account' }.to change(User, :count).by(0)
        expect(page).to have_content('Email not a valid email address')
      end

      it 'does not create a user with a taken email' do
        old_user = FactoryGirl.create(:user)
        fill_in 'First name', with: user.first_name
        fill_in 'Last name', with: user.last_name
        fill_in 'Email', with: old_user.email
        fill_in 'Password', with: user.password
        fill_in 'Confirm Password', with: user.password_confirmation
        expect{ click_button 'Create My Account' }.to change(User, :count).by(0)
        expect(page).to have_content('Email has already been taken')
      end
    end

    describe 'with valid data' do
      it 'creates a new user account' do
        fill_in 'First name', with: user.first_name
        fill_in 'Last name', with: user.last_name
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Confirm Password', with: user.password_confirmation
        expect{ click_button 'Create My Account' }.to change(User, :count).by(1)
        expect(page).to have_content(user.full_name)
        expect(page).to have_link('Log Out')
      end
    end
  end
end