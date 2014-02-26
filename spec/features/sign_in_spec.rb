require 'spec_helper'

describe 'Sign in' do
  before { visit signin_path }

  it 'has sign in fields' do
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
    expect(page).to have_button('Sign in')
  end

  describe 'when attempting to sign in' do
    let(:user) { FactoryGirl.create(:user) }

    describe 'with invalid information' do
      it 'should not sign user in with no info' do
        click_button 'Sign in'
        expect(page).to have_content('Invalid')
      end
      it 'should not sign user in with bad info' do
        fill_in 'Email', with: 'wrong email'
        fill_in 'Password', with: 'bad password'
        click_button 'Sign in'
        expect(page).to have_content('Invalid')
      end
    end
  end
end