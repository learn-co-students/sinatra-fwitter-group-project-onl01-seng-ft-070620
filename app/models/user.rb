class User < ActiveRecord::Base
  has_many  :tweets
  has_secure_password

  #converts spaces in name to slug with dashes
  def slug
    username.downcase.gsub(" ","-")
  end

  #find by slug
  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end