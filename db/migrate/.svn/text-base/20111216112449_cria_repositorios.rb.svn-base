class CriaRepositorios < ActiveRecord::Migration

	def change
		
		create_table :repositorios do |t|
			t.integer :projeto_id, :null => false
			t.string  :endereco,   :null => false
			t.integer :ultima_revisao_importada, :default => 0 
			t.timestamps
		end
		
		add_index(:repositorios, :projeto_id, unique: true)
		
		add_foreign_key(:repositorios,:projetos, dependent: :delete)
				
	end
end