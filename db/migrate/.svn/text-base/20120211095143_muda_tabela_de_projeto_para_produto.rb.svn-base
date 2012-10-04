class MudaTabelaDeProjetoParaProduto < ActiveRecord::Migration
	def change
		rename_table :projetos, :produtos
		
		rename_column :funcionalidades,           :projeto_id, :produto_id
		rename_column :historias,                 :projeto_id, :produto_id
		rename_column :repositorios,              :projeto_id, :produto_id	
		rename_column :arquivos_fonte,            :projeto_id, :produto_id	
		rename_column :categorias_arquivos_fonte, :projeto_id, :produto_id	
		
	end
end