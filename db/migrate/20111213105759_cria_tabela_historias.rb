class CriaTabelaHistorias < ActiveRecord::Migration
	def change
		create_table :historias do |t|
		  t.integer :projeto_id, :null => false
		  t.string  :nome,       :null => false
		  t.text    :descricao
		  t.integer :prioridade
		  t.integer :situacao,   :null => false
		  t.integer :tamanho
		  t.timestamps
		end
		
		add_foreign_key(:historias,:projetos)
		add_index(:historias,[:situacao,:prioridade])
	end
end