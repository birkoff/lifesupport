class ClientesController < ApplicationController
  before_filter :authenticate
  
  def index
      $do = params[:do]
      search = params[:search]
      
      #show/edit
      if $do == 'show' then
          redirect_to :action => 'show', :id => params[:id]
      elsif search then
          $do = 'results'
          data = Cliente.num_rows(params[:search])
          $num_rows = data['rows']
          $num_pages = data['pages']
          @clientes = Cliente.search(params[:search], params[:page])
      end
  end  

  def show
      id = params[:id]
      if params[:afiliado_id] then
        id = params[:afiliado_id]
      end
      @cliente = Cliente.find(id)
      address = @cliente.direccion + ", " + @cliente.colonia + ", " + @cliente.ciudad + ", " + @cliente.estado + ", Mexico"
      @map = Geocoder.search(address)
      if params[:afiliado_id].nil? then @afiliado = Cliente.get_afiliados(id) end
  end

  def new
      @cliente = Cliente.new
      $is_afiliado = params[:afiliado]
      $cid = params[:id]
  end
  
  def create
      @cliente = Cliente.new(params[:cliente])
      @cliente.save
      
      flash[:notice] = "EL Cliente fue creado."
      redirect_to @cliente
  end

  def update
      @cliente = Cliente.find(params[:id])
      @cliente.update_attributes(params[:cliente])
      
      flash[:notice] = "EL Cliente fue editado."
      redirect_to @cliente
  end

  def destroy
      Cliente.update_all("status = 'deleted'", ["id = ? or parent_id = ?", params[:id], params[:id]])
      
      flash[:notice] = "EL Cliente fue Eliminado."
      redirect_to :action => 'index'
  end
end