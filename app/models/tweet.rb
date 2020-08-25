class Tweet < ActiveRecord::Base
  belongs_to :user
  # validate char count 
end
