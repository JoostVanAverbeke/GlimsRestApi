require "rails_helper"

describe 'api/v1/login', :type => :api do
  let(:user) { FactoryGirl.create(:user) }

  let(:url) { '/api/v1/login' }

  context 'signs in' do
    it 'json post with email and password' do
      params = {
          email: user.email,
          password: user.password
      }
      user_json = User.find_by_email(user.email).to_json
      post "#{url}.json", params
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(user_json)
    end
  end

  context 'unsuccessful sign in' do
    it 'json post with email and invalid password' do
      params = {
          email: user.email,
          password: 'invalid'
      }
      post "#{url}.json", params
      expect(last_response.status).to eq(401)
    end

    it 'json post with an invalid email and password' do
      params = {
          email: 'invalid',
          password: user.password
      }
      post "#{url}.json", params
      expect(last_response.status).to eq(401)
    end
  end

end
