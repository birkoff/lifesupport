class Servicio < ActiveRecord::Base
  has_one :llamada
  # attr_accessible :title, :body
end
