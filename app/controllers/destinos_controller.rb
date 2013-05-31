class DestinosController < ApplicationController
  before_filter :authenticate
  
  def index
    if params[:do] == 'edit' then
      @destino = Destino.find(params[:id])
    else
      @destinos = Destino.all
      @destino = Destino.new
    end
  end

  def create
    @destino = Destino.new(params[:destino])
    @destino.save
    flash[:notice] = "Destino Creado."
    redirect_to :action => 'index'
  end

  def update
    @destino = Destino.find(params[:id])
    @destino.update_attributes(params[:destino])
    flash[:notice] = "Destino Editado."
    redirect_to :action => 'index'
  end

  def destroy
    Destino.find(params[:id]).destroy
    flash[:notice] = "Destino Eliminado."
    redirect_to :action => 'index'
  end
end
