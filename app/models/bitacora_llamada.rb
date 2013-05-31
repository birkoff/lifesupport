class BitacoraLlamada < ActiveRecord::Base
  belongs_to :llamada
  belongs_to :statusllamada
end
