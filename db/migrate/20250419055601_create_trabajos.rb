class CreateTrabajos < ActiveRecord::Migration[7.1]
  def change
    create_table :trabajos do |t|
      t.integer :nro_trabajo
      t.string :tipo
      t.string :caracteristicas
      t.decimal :valor, precision: 10, scale: 2
      t.boolean :pagado, default: false

      t.timestamps
    end
  end
end
