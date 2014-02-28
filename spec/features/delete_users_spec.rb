require 'spec_helper'

describe 'Deleting a user' do
  let(:user) { FactoryGirl.create(:user) }

  describe 'as a non-signed-in user', type: :request do
    before { delete user_path(user) }
    it 'should not delete user' do
      expect { User.find(user.id) }.to_not raise_error
    end
  end

  describe 'as correct user', type: :request do
    before do
      sign_in(user)
      delete user_path(user)
    end
    it 'should not delete user' do
      expect { User.find(user.id) }.to_not raise_error
    end
  end

  describe 'as admin', type: :request do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    before do
      sign_in(admin)
      delete user_path(user)
    end
    it 'should have deleted user' do
      expect { User.find(user.id) }.to raise_error
    end
  end
end