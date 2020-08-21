class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.tr(" ", "-")
  end

# input is test-123, output should be "test 123"
  def self.find_by_slug(slug)
    deslugged = slug.tr("-", " ")
    self.find_by(username: "#{deslugged}")
  end
end
