require 'spec_helper'

describe Api::V1::RegistrationsController do

  describe 'POST /api/v1/users.json', type: :api do

    context 'test' do
      let(:create_user) { post '/api/v1/users.json', user: FactoryGirl.attributes_for(:user) }

      it { expect{create_user}.to change(User, :count).by(1) }
    end
  end

end
