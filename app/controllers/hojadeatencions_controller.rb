class HojadeatencionsController < ApplicationController
  def index
    @llamada = Llamada.find(params[:llamada_id])
    #@hojadeatencion = @llamada.hojadeatencion.first
    @hojadeatencion = Hojadeatencion.where("llamada_id = #{params[:llamada_id]}").first
    @sv = Signosvitale.where("hojadeatencion_id = #{@hojadeatencion.id}")
  end
  
  def update
    @llamada = Llamada.find(params[:llamada_id])
    #@hojadeatencion = @llamada.hojadeatencion.build(params[:hojadeatencion])
    @hojadeatencion = Hojadeatencion.where("llamada_id = #{params[:llamada_id]}").first
    @hojadeatencion.update_attributes(params[:hojadeatencion])
    #@hojadeatencion.save
    #params[:sv].each do |psv|
    # I know this is fucking ugly I will fix this later
      @sv = Signosvitale.find(params[:sv]["0"]["id"])
      @sv.update_attributes(params[:sv]["0"])
      
      @sv = Signosvitale.find(params[:sv]["1"]["id"])
      @sv.update_attributes(params[:sv]["1"])
      
      @sv = Signosvitale.find(params[:sv]["2"]["id"])
      @sv.update_attributes(params[:sv]["2"])
    #end
    flash[:notice] = "Hoja de atencion Editada."
    redirect_to llamada_hojadeatencions_path(@llamada)
  end
end
