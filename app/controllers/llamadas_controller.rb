class LlamadasController < ApplicationController
  before_filter :authenticate
  
  def index
    conditions = "statusllamada_id not in (7,9)"
    order = "id DESC"
    
    if params[:filter] then
      filter = params[:filter]
      case filter[:name]
        when 'status'
            conditions = "statusllamada_id = #{filter[:statusllamada_id]}"
        when 'servicio'
            conditions = conditions + " and servicio_id = #{filter[:servicio_id]}"
        when 'prioridad'
            conditions = conditions + " and prioridad_id = #{filter[:prioridad_id]}"
        when 'fecha'
            order = "id #{filter[:order]}"
        else
      end
    end
    @llamadas = Llamada.where(conditions).order(order)
    
    @statusllamadas = Statusllamada.all
    @servicios = Servicio.all
    @prioridads = Prioridad.all
  end

  def show
    @llamada = Llamada.find(params[:id])
    
    #if params[:view] == 'bitacora' then
    #  @bitacora = BitacoraLlamada.where("llamada_id = #{@llamada.id}")
    #end
    
    @cliente = Cliente.find(@llamada.cliente_id)
    @prioridads = Prioridad.all
    @servicios = Servicio.all
    @destinos = Destino.all
    @ambulances = Ambulance.all
    @statusllamadas = Statusllamada.all
    address = @cliente.direccion + ", " + @cliente.colonia + ", " + @cliente.ciudad + ", " + @cliente.estado + ", Mexico"
    @map = Geocoder.search(address)
    #@hojadeatencion = @llamada.hojadeatencion
  end

  def new
    $do = params[:do]
    search = params[:search]
    
    if search then
      
        $do = 'results'
        data = Cliente.num_rows(params[:search])
        $num_rows = data['rows']
        $num_pages = data['pages']
        @clientes = Cliente.search(params[:search], params[:page])
      
    elsif $do == 'create' then
        if params[:llamada] then
            @llamada = Llamada.new(params[:llamada])
        else
            @llamada = Llamada.new  
        end
        @cliente = Cliente.find(params[:cliente_id])
        @prioridads = Prioridad.all
        @servicios = Servicio.all
        @destinos = Destino.all
        @ambulances = Ambulance.all
        @statusllamadas = Statusllamada.all
        @llamada.cliente_id = params[:cliente_id]
    end
  end

  def create
    @llamada = Llamada.new(params[:llamada])
    if @llamada.valid?
      @llamada.save
      flash[:notice] = "La llamada fue registrada."
      redirect_to @llamada
    else
      flash[:error] = "Error porfavor verifica la info."
      redirect_to :action => 'new', :do => 'create', :cliente_id => params[:llamada][:cliente_id], :llamada => params[:llamada]
    end
  end

  def update
    @llamada = Llamada.find(params[:id])
    @llamada.update_attributes(params[:llamada])
    
    flash[:notice] = "Llamada Editada."
    
    if params[:redirect] == 'index'
      redirect_to :action => 'index'
    else
      redirect_to @llamada
    end
  end

  def destroy
    Llamada.update_all("status = 'deleted'", ["id = ?", params[:id]])
    
    flash[:notice] = "Llamada Eliminada."
    redirect_to :action => 'index'
  end
end
