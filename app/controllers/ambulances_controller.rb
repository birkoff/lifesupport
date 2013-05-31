class AmbulancesController < ApplicationController
  before_filter :authenticate
   
  def index
    if params[:do] == 'edit' then
      @ambulance = Ambulance.find(params[:id])
    else
      @ambulances = Ambulance.all
      @ambulance = Ambulance.new
    end
  end

  def create
    @ambulance = Ambulance.new(params[:ambulance])
    @ambulance.save
    flash[:notice] = "Ambulancia Creada."
    redirect_to :action => 'index'
  end

  def update
    @ambulance = Ambulance.find(params[:id])
    @ambulance.update_attributes(params[:ambulance])
    flash[:notice] = "Ambulancia Editada."
    redirect_to :action => 'index'
  end

  def destroy
    Ambulance.find(params[:id]).destroy
    flash[:notice] = "Ambulancia Eliminada."
    redirect_to :action => 'index'
  end
end
