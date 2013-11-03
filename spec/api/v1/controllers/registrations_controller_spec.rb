require 'spec_helper'

describe Api::V1::RegistrationsController do

  let(:sign_up_uri) { '/api/v1/users.json' }

  describe 'POST /api/v1/users.json', type: :api do

    let(:user) { FactoryGirl.attributes_for(:user) }

    context 'create user' do
      before { post sign_up_uri, user: user }

      it { expect(response.status).to eq 201 }
      it { expect(json_response['email']).to eq user[:email] }
      it { expect(json_response['authentication_token'].length).to eq 32 }
    end

    context 'create user' do
      let(:create_user) { post sign_up_uri, user: user }

      it { expect{create_user}.to change(User, :count).by(1) }
    end

  end

end
