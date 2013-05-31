class Cliente < ActiveRecord::Base
  has_many :llamadas
  
  attr_accessible :user_type, :cp, :cliente, :telefono, :ciudad, 
                  :padecimientos, :razon_social, :direccion, :estado, 
                  :afiliado, :afiliacion, :fecha_nacimiento, :colonia, 
                  :tipo_sanguineo, :alergias, :nombre, :rfc, :entre_calles, 
                  :avisar, :servicio_medico, :parent_id
  
  @@results_per_page = 10
  
  def self.search(search, page)
    page = page.to_i
    if page == 0 then 
      page = 1
    end
    
    offset = ((page * @@results_per_page) - @@results_per_page)
    
    if search
      find(:all, :conditions => ["status = 'active' and nombre LIKE ?", "%#{search}%"], :limit => @@results_per_page, :offset => offset)
    else
      find(:all, :limit => @@results_per_page, :offset => offset)
    end
  end
  
  def self.num_rows(search)
    num_rows = count(:all, :conditions => ["status = 'active' and nombre LIKE ?", "%#{search}%"])
    num_pages = (num_rows/@@results_per_page.to_f).ceil
    data = Hash.new
    data['rows'] = num_rows
    data['pages'] = num_pages
    return data
  end
  
  def self.get_afiliados(parent_id)
    find(:all, :conditions => ["status = 'active' and parent_id = ?", parent_id], :limit => 30)
  end

end