require 'spec_helper'

describe Api::V1::RegistrationsController do

  let(:sign_up_uri) { '/api/v1/users.json' }

  describe 'POST /api/v1/users.json' do

    let(:user) { FactoryGirl.attributes_for(:user) }
    let!(:existing_user) { FactoryGirl.create(:user) }

    # Splited in two contexts because be need an atomic user creation to get response status
    context 'create user' do
      let!(:action) { post sign_up_uri, user: user }

      it { expect(response.status).to eq 201 }
      it { expect(json_response['email']).to eq user[:email] }
      it { expect(json_response['auth_token']).to match /\S{32}/ }
    end
    context 'create user' do
      let(:create_user) { post sign_up_uri, user: user }

      it { expect{create_user}.to change(User, :count).by(1) }
    end

    # Splited in two contexts because be need an atomic user creation to get response status
    context 'create user with existing email' do
      let!(:action) { post sign_up_uri, user: FactoryGirl.attributes_for(:user, email: existing_user.email) }

      it { expect(response.status).to eq 422 }
      it { expect(json_response['errors']['email'].uniq).to eq ['has already been taken'] }
    end
    context 'create user with existing email' do
      let(:create_user) { post sign_up_uri, user: FactoryGirl.attributes_for(:user, email: existing_user.email) }

      it { expect{create_user}.to change(User, :count).by(0) }
    end


  end

end
