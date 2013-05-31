class Statusllamada < ActiveRecord::Base
  has_many :llamada
  has_many :bitacorallamada
  # attr_accessible :title, :body
end
