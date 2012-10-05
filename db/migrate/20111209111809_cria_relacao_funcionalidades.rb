class CriaRelacaoFuncionalidades < ActiveRecord::Migration
	def change
		create_table :relacao_funcionalidades do |t|
			t.integer :funcionalidade_um_id,   :null => false
			t.integer :funcionalidade_dois_id, :null => false
			t.string  :relacao               , :null => false, :limit => 5 #forte/fraca
			t.timestamps :null => true
		end
		
		add_index :relacao_funcionalidades, [:funcionalidade_um_id, :funcionalidade_dois_id], :unique => true, :name => :indice_entre_um_e_dois
		add_index :relacao_funcionalidades, [:funcionalidade_dois_id, :funcionalidade_um_id], :unique => true, :name => :indice_entre_dois_e_um
		
		add_foreign_key(:relacao_funcionalidades, :funcionalidades,:column => :funcionalidade_um_id)
		add_foreign_key(:relacao_funcionalidades, :funcionalidades,:column => :funcionalidade_dois_id)
	end
end