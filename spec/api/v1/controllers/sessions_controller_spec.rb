require 'spec_helper'

describe Api::V1::SessionsController do

  let(:sign_in_uri) { '/api/v1/users/sign_in.json' }

  describe 'POST /api/v1/users/sign_in.json', type: :api do

    let(:user) { FactoryGirl.create(:user) }

    context 'sign_in user' do

      context 'with correct password' do
        before { post sign_in_uri, user: { email: user.email, password: user.password } }

        it { expect(response.status).to eq 201 }
        it { expect(response_json['authentication_token']).to eq user.authentication_token }
      end

      context 'sign_in user with wrong password' do
        before { post sign_in_uri, user: { email: user.email, password: 'wrong password' } }

        it { expect(response.status).to eq 401 }
      end

    end

  end

end
