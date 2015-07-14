class User < ActiveRecord::Base

  before_create :generate_access_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex(16)
    end while self.class.exists?(access_token: access_token)
  end

end
