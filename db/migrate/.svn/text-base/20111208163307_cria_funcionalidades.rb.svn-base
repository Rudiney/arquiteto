class CriaFuncionalidades < ActiveRecord::Migration
	def change
		create_table :funcionalidades do |t|
			t.string	 :nome,           :null => false
			t.integer :projeto_id,     :null => false
			t.string  :url_artigo_wiki
			t.timestamps
		end
		
		add_foreign_key(:funcionalidades, :projetos, :dependent => :delete)
	end
end