require 'spec_helper'

describe 'Edit User' do
  let(:team) { FactoryGirl.create(:team) }
  let(:user) { FactoryGirl.create(:user, team: team) }

  describe 'when not signed in' do
    it 'does not let a user see the edit form' do
      visit edit_user_path(user)
      expect(page.current_url).to eq signin_url
    end

    describe 'submitting a put request', type: :request do
      before { put user_path(user) }
      specify { expect(response).to redirect_to signin_path }
    end
  end

  describe 'when signed in as different user', type: :request do
    before do
      @other_user = FactoryGirl.create(:user)
      sign_in @other_user
    end
    it 'does not let user see edit form' do
      visit edit_user_path(user)
      expect(page.current_path).to eq user_path(@other_user)
    end

    describe 'submitting a put request', type: :request do
      before { put user_path(user) }
      specify { expect(response).to redirect_to root_path }
    end
  end

  describe 'when signed in as correct user', type: :request do
    before do
      sign_in user
      visit edit_user_path(user)
    end

    it 'lets user see edit form' do
      expect(page.current_path).to eq edit_user_path(user)
      expect(page).to have_content(user.full_name)
      expect(page).to have_button('Update Account')
    end

    describe 'updating user info' do
      let(:new_first) { 'NewFirst'}
      let(:new_last) { 'NewLast'}
      let(:new_email) { 'new@email.com'}
      before do
        fill_in 'First name', with: new_first
        fill_in 'Last name', with: new_last
        fill_in 'Email', with: new_email
        click_button 'Update Account'
      end

      it 'should save the changes' do
        expect(user.reload.first_name).to eq new_first
        expect(user.reload.last_name).to eq new_last
        expect(user.reload.email).to eq new_email
      end

    end
  end

  describe 'when an admin is signed in', type: :request do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    before do
      sign_in admin
      visit edit_user_path(user)
    end

    it 'lets admin see edit form' do
      expect(page.current_path).to eq edit_user_path(user)
      expect(page).to have_content(user.full_name)
      expect(page).to have_button('Update Account')
    end

    describe 'updating user info' do
      let(:admin_first) { 'adminFirst'}
      let(:admin_last) { 'adminLast'}
      let(:admin_email) { 'admin@email.com'}
      before do
        fill_in 'First name', with: admin_first
        fill_in 'Last name', with: admin_last
        fill_in 'Email', with: admin_email
        click_button 'Update Account'
      end

      it 'should save the changes' do
        expect(user.reload.first_name).to eq admin_first
        expect(user.reload.last_name).to eq admin_last
        expect(user.reload.email).to eq admin_email
      end
    end
  end
end