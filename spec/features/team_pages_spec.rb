require 'spec_helper'

describe 'Team profile page' do
  let(:team) { FactoryGirl.create(:team) }
  let(:athlete) { FactoryGirl.create(:user, team: team) }
  let(:coach) { FactoryGirl.create(:user, coach: true, team: team) }
  let(:admin) { FactoryGirl.create(:user, admin: true)}
  let(:other_user) { FactoryGirl.create(:user) }
  before(:all) {team; athlete; coach; admin; other_user}

  describe 'attempting to visit' do
    describe 'as non-signed in user' do
      it 'should redirect to sign in' do
        visit team_path(team)
        expect(page.current_path).to eq signin_path
      end
    end
    describe 'as other team athlete', type: :request do
      before { sign_in other_user }
      it 'should redirect to user page' do
        visit team_path(team)
        expect(page.current_path).to eq user_path(other_user)
      end
    end

    describe 'as a coach for team', type: :request do
      before { sign_in coach }
      it 'should show team page' do
        visit team_path(team)
        expect(page.current_path).to eq team_path(team)
        expect(page).to have_content(team.name)
      end
    end

    describe 'as an athlete for team', type: :request do
      before { sign_in athlete }
      it 'should show team page' do
        visit team_path(team)
        expect(page.current_path).to eq team_path(team)
        expect(page).to have_content(team.name)
      end

      it 'should be reachable from home page' do
        visit root_path
        click_link team.name
        expect(page.current_path).to eq team_path(team)
      end

      it 'should have links to coach and athlete profiles' do
        visit team_path(team)
        expect(page).to have_link(athlete.full_name, href: user_path(athlete))
        expect(page).to have_link(coach.full_name, href: user_path(coach))
      end
    end

    describe 'as an admin', type: :request do
      before { sign_in admin }
      it 'should show team page' do
        visit team_path(team)
        expect(page.current_path).to eq team_path(team)
        expect(page).to have_content(team.name)
      end
    end
  end

end