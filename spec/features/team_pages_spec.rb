require 'spec_helper'

describe 'Team profile page' do
  let(:team) { FactoryGirl.create(:team) }
  let(:athlete) { FactoryGirl.create(:user, team: team) }
  let(:coach) { FactoryGirl.create(:user, coach: true, team: team) }
  let(:admin) { FactoryGirl.create(:user, admin: true)}
  let(:other_user) { FactoryGirl.create(:user) }

  describe 'attempting to visit' do
    describe 'as non-signed in user' do
      it 'should redirect to sign in' do
        visit team_path(team)
        expect(page.current_path).to eq signin_path
      end
    end
    describe 'as other team athlete', type: :request do
      it 'should redirect to user page' do
        sign_in other_user
        visit team_path(team)
        expect(page.current_path).to eq user_path(other_user)
      end
    end

    describe 'as a coach for team', type: :request do
      it 'should show team page' do
        sign_in coach
        visit team_path(team)
        expect(page.current_path).to eq team_path(team)
        expect(page).to have_content(team.name)
      end
    end

    describe 'as an athlete for team', type: :request do
      it 'should show team page' do
        sign_in athlete
        visit team_path(team)
        expect(page.current_path).to eq team_path(team)
        expect(page).to have_content(team.name)
      end

      it 'should be reachable from home page' do
        sign_in athlete
        visit root_path
        click_link team.name
        expect(page.current_path).to eq team_path(team)
      end

      it 'should have links to coach and athlete profiles' do
        sign_in athlete
        coach
        visit team_path(team)
        expect(page).to have_link(athlete.full_name, href: user_path(athlete))
        expect(page).to have_link(coach.full_name, href: user_path(coach))
      end
    end

    describe 'as an admin', type: :request do
      it 'should show team page' do
        sign_in admin
        visit team_path(team)
        expect(page.current_path).to eq team_path(team)
        expect(page).to have_content(team.name)
      end
    end
  end

end