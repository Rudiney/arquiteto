class CriaCategoriasArquivosFonte < ActiveRecord::Migration
	def change
		create_table :categorias_arquivos_fonte do |t|
			t.integer :projeto_id,               null:false
			t.string  :nome,                     limit: 255,  null: false
			t.string  :string_expressao_regular, limit: 255,  null: false
			t.timestamps
		end
	end
end