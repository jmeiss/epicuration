class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # :omniauthable, :omniauth_providers => [:facebook]

  before_create :generate_authentication_token


private

  def generate_authentication_token
    begin
      self.authentication_token = SecureRandom.hex
    end while self.class.exists?(authentication_token: authentication_token)
  end

end
