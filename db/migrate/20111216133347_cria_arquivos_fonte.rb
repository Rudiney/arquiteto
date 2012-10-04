class CriaArquivosFonte < ActiveRecord::Migration
	def change

		create_table :arquivos_fonte do |t|
			t.string :caminho_completo, :null => false
			t.integer :projeto_id, :null => false
			t.timestamps
		end

		add_foreign_key(:arquivos_fonte,:projetos, dependent: :delete)
		add_index(:arquivos_fonte, :caminho_completo, unique:true)
	end
end