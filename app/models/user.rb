class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  has_secure_password
  validates :username, :email, :password, :presence => true

  def self.slug(username)
    user = self.find_by(username:username)
    user.username.downcase.gsub(" ","-")
  end
end
