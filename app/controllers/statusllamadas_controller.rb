class StatusllamadasController < ApplicationController
  before_filter :authenticate
  
  def index
    if params[:do] == 'edit' then
      @statusllamada = Statusllamada.find(params[:id])
    else
      @statusllamadas = Statusllamada.all
      @statusllamada = Statusllamada.new
    end
  end

  def create
    @statusllamada = Statusllamada.new(params[:statusllamada])
    @statusllamada.save
    flash[:notice] = "Status Creada."
    redirect_to :action => 'index'
  end

  def update
    @statusllamada = Statusllamada.find(params[:id])
    @statusllamada.update_attributes(params[:statusllamada])
    flash[:notice] = "Status Editado."
    redirect_to :action => 'index'
  end

  def destroy
    Statusllamada.find(params[:id]).destroy
    flash[:notice] = "Status Eliminado."
    redirect_to :action => 'index'
  end
end
