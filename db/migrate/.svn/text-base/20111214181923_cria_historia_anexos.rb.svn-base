class CriaHistoriaAnexos < ActiveRecord::Migration
	def change
		create_table :historia_anexos do |t|
			t.integer   :historia_id,            :null => false
			t.string		:descricao
			t.string    :arquivo_file_name
			t.integer   :arquivo_file_size
			t.string    :arquivo_content_type
			t.timestamp :arquivo_updated_at
			t.timestamps
		end
	end
end