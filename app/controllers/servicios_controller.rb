class ServiciosController < ApplicationController
  before_filter :authenticate
  
  def index
    if params[:do] == 'edit' then
      @servicio = Servicio.find(params[:id])
    else
      @servicios = Servicio.all
      @servicio = Servicio.new
    end
  end

  def create
    @servicio = Servicio.new(params[:servicio])
    @servicio.save
    flash[:notice] = "Servicio Creada."
    redirect_to :action => 'index'
  end

  def update
    @servicio = Servicio.find(params[:id])
    @servicio.update_attributes(params[:servicio])
    flash[:notice] = "Servicio Editado."
    redirect_to :action => 'index'
  end

  def destroy
    Servicio.find(params[:id]).destroy
    flash[:notice] = "Servicio Eliminado."
    redirect_to :action => 'index'
  end
end
