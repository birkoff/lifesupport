class CreateStatusllamadas < ActiveRecord::Migration
  def change
    create_table :statusllamadas do |t|

      t.timestamps
    end
  end
end
