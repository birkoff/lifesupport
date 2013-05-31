class Hojadeatencion < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :llamada
  has_many :signosvitale
end
