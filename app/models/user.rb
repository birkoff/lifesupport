class User < ActiveRecord::Base
  validates_uniqueness_of :username
  attr_accessible :username, :password

  def self.authenticate(username, password)
    find(:first, :conditions => ["username = ? and password = ?", "#{username}", "#{password}"])
  end
end
