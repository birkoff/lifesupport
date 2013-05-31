class Llamada < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :prioridad
  belongs_to :servicio
  belongs_to :statusllamada
  belongs_to :destino
  belongs_to :ambulance
  has_many   :bitacorallamada
  has_many   :hojadeatencion
  
  #accepts_nested_attributes_for :hojadeatencion
  
  validates :reporta, :reporte, :ubicacion, :presence => true
  
  before_save do |llamada|
      if llamada.id then
          original = Llamada.find(llamada.id)
          if original.statusllamada_id != llamada.statusllamada_id then
              BitacoraLlamada.create(:llamada_id => llamada.id, :statusllamada_id => llamada.statusllamada_id, :user_id => 1)
          end
      end
  end
  
  after_create do |llamada|
      BitacoraLlamada.create(:llamada_id => llamada.id, :statusllamada_id => llamada.statusllamada_id, :user_id => 1)
      @hoja = Hojadeatencion.create(:llamada_id => llamada.id)
      # I know this is ugly but I promess to fix it when I have more time
      Signosvitale.create(:hojadeatencion_id => @hoja.id)
      Signosvitale.create(:hojadeatencion_id => @hoja.id)
      Signosvitale.create(:hojadeatencion_id => @hoja.id)
  end
end