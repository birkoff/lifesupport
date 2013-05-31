class BitacorasController < ApplicationController
  def index
    @llamada = Llamada.find(params[:llamada_id])
    @bitacora = BitacoraLlamada.where("llamada_id = #{params[:llamada_id]}").order("id ASC")
  end
end
