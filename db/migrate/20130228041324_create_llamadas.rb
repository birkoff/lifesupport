class CreateLlamadas < ActiveRecord::Migration
  def change
    create_table :llamadas do |t|

      t.timestamps
    end
  end
end
