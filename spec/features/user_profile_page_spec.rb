require 'spec_helper'

describe 'Profile Page' do
  let(:user) { FactoryGirl.create(:user, team: team) }
  let(:team) { FactoryGirl.create(:team) }
  let(:admin) { FactoryGirl.create(:user, admin: true) }

  describe 'for non-signed in user' do
    before do
      visit logout_path
      visit user_path(user)
    end

    it 'redirects to signin path' do
      expect(page.current_path).to eq signin_path
    end
  end

  describe 'for signed-in user', type: :request do
    before { sign_in user }

    it 'allows you to see your own profile' do
      visit user_path(user)
      expect(page).to have_content(user.full_name)
    end

    it 'is your home page' do
      visit root_path
      expect(page).to have_content(user.full_name)
      expect(page).to have_link('Edit My Account', href: edit_user_path(user))
    end

    it 'allows you to see other people on your own team' do
      teammate = FactoryGirl.create(:user, team: team)
      visit user_path(teammate)
      expect(page).to have_content(teammate.full_name)
      expect(page).to have_link('Edit My Account', href: edit_user_path(user))
    end

    it 'does not allow you to see other teams athletes profile pages' do
      other_team = FactoryGirl.create(:team)
      other_athlete = FactoryGirl.create(:user, team: other_team)
      visit user_path(other_athlete)
      expect(page).to have_content(user.full_name)
    end
  end

  describe 'for a signed in admin', type: :request do
    before { sign_in admin }
    it 'lets admin see users profile page' do
      visit user_path(user)
      expect(page).to have_content(user.full_name)
    end

  end
end
