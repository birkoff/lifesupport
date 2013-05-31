class CreateBitacoraLlamadas < ActiveRecord::Migration
  def change
    create_table :bitacora_llamadas do |t|

      t.timestamps
    end
  end
end
