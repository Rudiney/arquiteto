class CriaTabelaPesquisa < ActiveRecord::Migration
  def up
    create_table :pesquisas do |t|
			t.integer :indicador_id,          :null => false
			t.string  :valor
			t.string  :operador
			t.timestamps
		end
  end

  def down
    remove_table :pesquisas
  end
end
