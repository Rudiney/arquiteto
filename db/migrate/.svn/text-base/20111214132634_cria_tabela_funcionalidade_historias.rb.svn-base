class CriaTabelaFuncionalidadeHistorias < ActiveRecord::Migration
	def change
		create_table :funcionalidade_historias do |t|
		  t.integer :funcionalidade_id, :null => false
		  t.integer :historia_id,       :null => false
		  t.timestamps
		end
		
		add_foreign_key(:funcionalidade_historias,:funcionalidades, :dependent => :delete)
		add_foreign_key(:funcionalidade_historias,:historias, :dependent => :delete)
		
		add_index(:funcionalidade_historias,[:funcionalidade_id, :historia_id], unique: true, name: 'indice_unico_pela_historia_funcionalidade')
	end
end