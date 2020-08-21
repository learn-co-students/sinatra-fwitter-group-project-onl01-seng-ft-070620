class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.tr(" ", "-")
  end

  def self.find_by_slug(slug)
    deslugged = slug.tr("-", " ")
    self.find_by(username: "#{deslugged}")
  end
end
