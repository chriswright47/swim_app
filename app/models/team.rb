class Team < ActiveRecord::Base
  has_many :athletes, :class_name => 'User'
  has_many :coaches, :class_name => 'User'
end
