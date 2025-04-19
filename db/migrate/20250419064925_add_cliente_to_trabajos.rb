class AddClienteToTrabajos < ActiveRecord::Migration[7.1]
  def change
    add_reference :trabajos, :cliente, foreign_key: true
  end
end
