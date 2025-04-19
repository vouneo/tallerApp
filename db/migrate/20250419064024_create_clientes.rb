class CreateClientes < ActiveRecord::Migration[8.0]
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.string :contacto

      t.timestamps
    end
  end
end
