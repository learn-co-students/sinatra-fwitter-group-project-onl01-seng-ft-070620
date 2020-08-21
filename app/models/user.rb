class User < ActiveRecord::Base
  
  has_many :tweets
  has_secure_password
  

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(s)
    self.all.find do |u|
      u.slug == s
    end
  end
end
