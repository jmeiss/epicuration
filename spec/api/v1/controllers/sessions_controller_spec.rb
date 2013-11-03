require 'spec_helper'

describe Api::V1::SessionsController do
  let(:user) { FactoryGirl.create(:user) }

  describe 'POST /api/v1/users/sign_in.json' do
    let(:sign_in_uri)   { '/api/v1/users/sign_in.json' }

    context 'sign_in' do
      context 'with correct password' do
        before { post sign_in_uri, email: user.email, password: user.password }

        it { expect(response.status).to eq 201 }
        it { expect(json_response['auth_token']).to eq user.authentication_token }
      end

      context 'with wrong password' do
        before { post sign_in_uri, email: user.email, password: 'wrong password' }

        it { expect(response.status).to eq 401 }
        it { expect(json_response['errors']).to eq ['Error with your email or password'] }
      end

      context 'with wrong email' do
        before { post sign_in_uri, email: 'wrong email', password: user.password }

        it { expect(response.status).to eq 401 }
        it { expect(json_response['errors']).to eq ['Error with your email or password'] }
      end
    end
  end

  describe 'DELETE /api/v1/users/sign_out.json' do
    let(:sign_out_uri)  { '/api/v1/users/sign_out.json' }

    context 'sign_out' do
      before { delete sign_out_uri, { auth_token: user.authentication_token } }

      it { expect(response.status).to eq 200 }
    end
  end
end
