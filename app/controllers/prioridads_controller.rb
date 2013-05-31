class PrioridadsController < ApplicationController
  before_filter :authenticate
  
  def index
    if params[:do] == 'edit' then
      @prioridad = Prioridad.find(params[:id])
    else
      @prioridads = Prioridad.all
      @prioridad = Prioridad.new
    end
  end

  def create
    @prioridad = Prioridad.new(params[:prioridad])
    @prioridad.save
    flash[:notice] = "Prioridad Creada."
    redirect_to :action => 'index'
  end

  def update
    @prioridad = Prioridad.find(params[:id])
    @prioridad.update_attributes(params[:prioridad])
    flash[:notice] = "Prioridad Editada."
    redirect_to :action => 'index'
  end

  def destroy
    Prioridad.find(params[:id]).destroy
    flash[:notice] = "Prioridad Eliminada."
    redirect_to :action => 'index'
  end
end
