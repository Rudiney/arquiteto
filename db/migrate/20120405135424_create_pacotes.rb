class CreatePacotes < ActiveRecord::Migration
	def change
		
		create_table :pacotes do |t|
			t.integer :produto_id
			t.string :nome
			t.text :descricao

			t.timestamps
		end
		
		add_column(:historias, :pacote_id, :integer)

	end
end
