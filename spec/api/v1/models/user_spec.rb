require 'spec_helper'
require 'user' # Need for simplecov

describe User do

  describe 'generate_authentication_token!' do
    let(:user) { FactoryGirl.create(:user) }

    it { expect(user.authentication_token).to match /\S{32}/ }
  end

end
