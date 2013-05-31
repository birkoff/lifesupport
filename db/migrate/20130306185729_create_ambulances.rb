class CreateAmbulances < ActiveRecord::Migration
  def change
    create_table :ambulances do |t|

      t.timestamps
    end
  end
end
